
import UIKit
import Kingfisher


protocol LeagueDetailsProtocol {
    func loadLastMatches(matches : [Match])
    func loadUpcomingMatches(matches : [Match])
    func loadTeams(teams : [Team])
}

class LeagueDetailsViewController: UICollectionViewController , LeagueDetailsProtocol{
    
    var sport : SportType?
    var league : League?
    
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
        
        presenter = LeaugeDetailsPresenter(view: self)
        presenter?.fetchLastMatches(sport: sport ?? .football, leagueId: leagueId)
        presenter?.fetchUpcomingMatches(sport: sport ?? .football, leagueId: leagueId)
        presenter?.fetchTeams(sport: sport ?? .football, leagueId: leagueId)

        collectionView.collectionViewLayout = createLayout()
        
        collectionView.register(UINib(nibName: "LastMatchCell", bundle: nil), forCellWithReuseIdentifier: "LastMatchCell")
        
        collectionView.register(UINib(nibName: "UpcomingMatchCell", bundle: nil), forCellWithReuseIdentifier: "UpcomingMatchCell")
        
        collectionView.register(UINib(nibName: "TeamCell", bundle: nil), forCellWithReuseIdentifier: "TeamCell")
    }
    
    @objc func onFavTapped() {
        print("fav Tapped")
    }


    func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, environment in
            switch sectionIndex {
            case 0: return self.createLastMatchesSection()
            case 1: return self.createUpcomingMatchesSection()
            default: return self.createTeamsSection()
            }
        }
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0: return upcomingMatches.count
        case 1: return lastMatches.count
        default: return teams.count
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LastMatchCell", for: indexPath) as! LastMatchCell
            
            let match = upcomingMatches[indexPath.item]
            
            cell.homeLabel.text = match.event_home_team
            cell.awayLabel.text = match.event_away_team
            
            if let url = URL(string: match.home_team_logo ?? ""){
                cell.homeImageView.kf.setImage(with: url , placeholder: UIImage(systemName: "photo"))
            }
            
            if let url = URL(string: match.away_team_logo ?? ""){
                cell.awayImageView.kf.setImage(with: url , placeholder: UIImage(systemName: "photo"))
            }
            
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UpcomingMatchCell", for: indexPath) as! UpcomingMatchCell
            
            let match = lastMatches[indexPath.item]
            
            cell.homeLabel.text = match.event_home_team ?? match.event_first_player ?? ""
            cell.awayLabel.text = match.event_away_team ?? match.event_second_player ?? ""
            
            if let results = FormatUtils.splitMatchResult(match.event_final_result){
                cell.homeResultLabel.text = results[0]
                cell.awayResultLabel.text = results[1]
            }
            
            cell.dateLabel.text = match.event_date
            
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
                cell.homeImageView.kf.setImage(with: url , placeholder: UIImage(systemName: "photo"))
                
            }
            
            if let url = URL(string: logo2){
                cell.awayImageView.kf.setImage(with: url , placeholder: UIImage(systemName: "photo"))
                
            }
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamCell", for: indexPath) as! TeamCell
            
            let team = teams[indexPath.item]
            
            cell.teamLabel.text = team.team_name
            
            if let url = URL(string: team.team_logo ?? ""){
                cell.teamImageView.kf.setImage(with: url , placeholder: UIImage(systemName: "photo"))
            }
            return cell
        }

    }
    
    func createLastMatchesSection()-> NSCollectionLayoutSection {
      let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1)
      , heightDimension: .fractionalHeight(1))
      let item = NSCollectionLayoutItem(layoutSize: itemSize)
      
      let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.75)
                                             , heightDimension: .fractionalHeight(0.18))
      let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize
      , subitems: [item])
          group.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8
          , bottom: 8, trailing: 8)
          
      let section = NSCollectionLayoutSection(group: group)
          section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0
          , bottom: 0, trailing: 0)
          section.orthogonalScrollingBehavior = .continuous
        
         return section
    }
    
    func createTeamsSection()-> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1)
                                              , heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4)
                                               , heightDimension: .absolute(130))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize
                                                     , subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8
                                                      , bottom: 8, trailing: 8)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0
                                                        , bottom: 0, trailing: 0)
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
    
    func createUpcomingMatchesSection()->NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1)
                                              , heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1)
                                               , heightDimension: .absolute(120))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize
                                                     , subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8
                                                      , bottom: 8, trailing: 8)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0
                                                        , bottom: 0, trailing: 0)
        return section
    }
    
    func loadLastMatches(matches: [Match]) {
        lastMatches = matches
        collectionView.reloadData()
    }
    
    func loadUpcomingMatches(matches: [Match]) {
        upcomingMatches = matches
        collectionView.reloadData()
    }
    
    func loadTeams(teams : [Team]) {
        self.teams = teams
        collectionView.reloadData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if(indexPath.section == 2 && sport == .football){
            let team = teams[indexPath.item]
            navigateToTeamDetails(team: team)
        }
        
    }
    
    func navigateToTeamDetails(team : Team){
        let teamsStoryboard = UIStoryboard(name: "TeamDetails", bundle: nil)
        let tVC = teamsStoryboard.instantiateViewController(withIdentifier: "teamDetails") as! TeamDetailsViewController
        tVC.team = team
        navigationController?.pushViewController(tVC, animated: true)
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
