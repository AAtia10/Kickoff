
import UIKit
import Kingfisher


protocol LeagueDetailsProtocol {
    func loadData(lastMatches:[Match] , upcomingMatches:[Match] , teams:[Team])
    func loadFavState(isFav:Bool)
}

class LeagueDetailsViewController: UICollectionViewController , LeagueDetailsProtocol{
    
    var sport : SportType?
    var league : League?
    var isFav=false
    
    var presenter : LeaugeDetailsPresenter?
    
    var lastMatches : [Match] = []
    var upcomingMatches : [Match] = []
    var teams : [Team] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = league?.league_name
        let leagueId = league?.league_key ?? 3
        
        let heartButton = UIBarButtonItem(image: UIImage(systemName: "heart"),style: .plain,target: self,action: #selector(onFavTapped))
        
        navigationItem.rightBarButtonItem = heartButton
        
        view.backgroundColor = .systemBackground
        collectionView.backgroundColor = .clear
        collectionView.alpha = 0
        LoadingIndicatorUtil.shared.show(on: view)
        
        presenter = LeaugeDetailsPresenter(view: self)
        
        
        presenter?.fetchData(sport: sport ?? .football, leagueId: leagueId)
        presenter?.isFav(leagueId: leagueId)

        collectionView.collectionViewLayout = createLayout()
        
        collectionView.register(UINib(nibName: "LastMatchCell", bundle: nil), forCellWithReuseIdentifier: "LastMatchCell")
        
        collectionView.register(UINib(nibName: "UpcomingMatchCell", bundle: nil), forCellWithReuseIdentifier: "UpcomingMatchCell")
        
        collectionView.register(UINib(nibName: "TeamCell", bundle: nil), forCellWithReuseIdentifier: "TeamCell")
        
        collectionView.register(SectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderView.identifier)

        
        collectionView.register(UINib(nibName: "EmptyCell", bundle: nil), forCellWithReuseIdentifier: "EmptyCell")

    }
    
    @objc func onFavTapped() {
        guard let league = league else { return }
           let leagueId = league.league_key
        
           if isFav {
               AlertManager.showDeleteAlert(on: self,
                                            title: NSLocalizedString("confirm", comment: ""),
                                            message: NSLocalizedString("delete_message", comment: "")
               ){
                   self.presenter?.removeFromFav(leagueId: leagueId)
               }
           } else {
               let localLeague = LocalLeague(fromLeague: league, sport: sport ?? .football)
               presenter?.addToFav(league: localLeague)
           }
    }
    
    func loadFavState(isFav: Bool) {
        self.isFav = isFav
        if(isFav){
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart.fill")
        }else{
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart")
        }
    }


    func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, environment in
            switch sectionIndex {
            case 0: return self.createTeamsSection()
            case 1: return self.createLastMatchesSection()
            default: return self.createUpcomingMatchesSection()
            }
        }
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0: return teams.count
        case 1: return upcomingMatches.isEmpty ? 1 : upcomingMatches.count
        default: return lastMatches.isEmpty ? 1 : lastMatches.count
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        switch indexPath.section {
        case 1:
            if upcomingMatches.isEmpty {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmptyCell", for: indexPath) as! EmptyCell
                return cell
            }
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LastMatchCell", for: indexPath) as! LastMatchCell
            
            let match = upcomingMatches[indexPath.item]
            
            cell.homeLabel.text = match.event_home_team
            cell.awayLabel.text = match.event_away_team
            
            cell.dateLabel.text = match.event_date?.toArabicDate()
            cell.timeLabel.text = match.event_time?.convertEnglishDigitsToArabic()
            
            if let url = URL(string: match.home_team_logo ?? ""){
                cell.homeImageView.kf.setImage(with: url , placeholder: UIImage(named: "teamPlaceHolder"))
            }
            
            if let url = URL(string: match.away_team_logo ?? ""){
                cell.awayImageView.kf.setImage(with: url , placeholder: UIImage(named: "teamPlaceHolder"))
            }
            
            return cell
        case 2:
            if lastMatches.isEmpty {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmptyCell", for: indexPath) as! EmptyCell
                return cell
            }
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UpcomingMatchCell", for: indexPath) as! UpcomingMatchCell
            
            let match = lastMatches[indexPath.item]
            
            cell.homeLabel.text = match.event_home_team ?? match.event_first_player ?? ""
            cell.awayLabel.text = match.event_away_team ?? match.event_second_player ?? ""
            
            if let results = FormatUtils.splitMatchResult(match.event_final_result){
                cell.homeResultLabel.text = results[0].convertEnglishDigitsToArabic()
                cell.awayResultLabel.text = results[1].convertEnglishDigitsToArabic()
            }
            
            cell.dateLabel.text = match.event_date?.toArabicDate()
            
            var logo1 = ""
            var logo2 = ""
            
            
            switch self.sport!{
            case .football:
                logo1 = match.home_team_logo ?? ""
                logo2 = match.away_team_logo ?? ""
            case .tennis:
                logo1 = match.event_first_player_logo ?? ""
                logo2 = match.event_second_player_logo ?? ""
            case .basketball:
                logo1 = match.event_home_team_logo ?? ""
                logo2 = match.event_away_team_logo ?? ""
            case .cricket:
                logo1 = match.event_home_team_logo ?? ""
                logo2 = match.event_away_team_logo ?? ""
            }
            
            if let url = URL(string: logo1 ){
                cell.homeImageView.kf.setImage(with: url , placeholder: UIImage(named: "teamPlaceHolder"))
                
            }
            
            if let url = URL(string: logo2){
                cell.awayImageView.kf.setImage(with: url , placeholder: UIImage(named: "teamPlaceHolder"))
                
            }
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamCell", for: indexPath) as! TeamCell
            
            let team = teams[indexPath.item]
            
            cell.teamLabel.text = team.team_name
            
            if let url = URL(string: team.team_logo ?? ""){
                cell.teamImageView.kf.setImage(with: url , placeholder: UIImage(named: "teamPlaceHolder"))
            }
            
            switch sport {
            case .football:
                cell.setupCardStyle()
            default: break
            }
            return cell
        }

    }
    
    func createLastMatchesSection()-> NSCollectionLayoutSection {
      let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1)
      , heightDimension: .fractionalHeight(1))
      let item = NSCollectionLayoutItem(layoutSize: itemSize)
      
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1)
                                             , heightDimension: .absolute(160))
      let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize
      , subitems: [item])
          group.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16
          , bottom: 8, trailing: 16)
          
      let section = NSCollectionLayoutSection(group: group)
          section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 0
          , bottom: 0, trailing: 0)
          section.orthogonalScrollingBehavior = .continuous
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(44))
           let header = NSCollectionLayoutBoundarySupplementaryItem(
               layoutSize: headerSize,
               elementKind: UICollectionView.elementKindSectionHeader,
               alignment: .top)
           section.boundarySupplementaryItems = [header]
        
         return section
    }
    
    func createTeamsSection()-> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1)
                                              , heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4)
                                               , heightDimension: .absolute(150))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize
                                                     , subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8
                                                      , bottom: 8, trailing: 8)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0
                                                        , bottom: 0, trailing: 0)
        section.orthogonalScrollingBehavior = .continuous
        
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(44))
           let header = NSCollectionLayoutBoundarySupplementaryItem(
               layoutSize: headerSize,
               elementKind: UICollectionView.elementKindSectionHeader,
               alignment: .top)
           section.boundarySupplementaryItems = [header]
        
        return section
    }
    
    func createUpcomingMatchesSection()->NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1)
                                              , heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1)
                                               , heightDimension: .absolute(140))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize
                                                     , subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8
                                                      , bottom: 8, trailing: 8)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0
                                                        , bottom: 0, trailing: 0)
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(44))
           let header = NSCollectionLayoutBoundarySupplementaryItem(
               layoutSize: headerSize,
               elementKind: UICollectionView.elementKindSectionHeader,
               alignment: .top)
           section.boundarySupplementaryItems = [header]
        
        
        return section
    }
    
    func loadData(lastMatches: [Match], upcomingMatches: [Match], teams: [Team]) {
        loadUpcomingMatches(matches: upcomingMatches)
        loadLastMatches(matches: lastMatches)
        loadTeams(teams: teams)
        UIView.animate(withDuration: 0.3) {
                self.collectionView.alpha = 1
            }
        LoadingIndicatorUtil.shared.hide()
    }
    
    private func loadLastMatches(matches: [Match]) {
        lastMatches = matches
        collectionView.reloadData()
        print("last -> \(matches.count)")
    }
    
    private func loadUpcomingMatches(matches: [Match]) {
        upcomingMatches = matches
        collectionView.reloadData()
        print("upcoming -> \(matches.count)")
    }
    
    private func loadTeams(teams : [Team]) {
        self.teams = teams
        collectionView.reloadData()
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        NetworkManager.isInternetAvailable  { isConnected in
            DispatchQueue.main.async {
                if isConnected {
                    if(indexPath.section == 0 && self.sport == .football){
                        let team = self.teams[indexPath.item]
                        self.navigateToTeamDetails(team: team)
                    }
                } else {
                    AlertManager.showNoInternetAlert(on: self)
                }
            }
        }        
    }
    
    func navigateToTeamDetails(team : Team){
        let teamsStoryboard = UIStoryboard(name: "TeamDetails", bundle: nil)
        let tVC = teamsStoryboard.instantiateViewController(withIdentifier: "teamDetails") as! TeamDetailsViewController
        tVC.team = team
        navigationController?.pushViewController(tVC, animated: true)
    }

    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderView.identifier, for: indexPath) as! SectionHeaderView
            switch indexPath.section {
            case 0: header.configure(with: NSLocalizedString("teams", comment: ""))
            case 1: header.configure(with: NSLocalizedString("upcoming_matches", comment: ""))
            case 2: header.configure(with: NSLocalizedString("last_matches", comment: ""))
            default: break
            }
            return header
        }
        return UICollectionReusableView()
    }


    
    

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {

    }
    */

}
