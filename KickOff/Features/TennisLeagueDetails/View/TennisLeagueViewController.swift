
import UIKit

protocol TennisLeagueDetailsProtocol {    
    func loadData(lastMatches:[TennisMatch] , upcomingMatches:[TennisMatch] , players:[TennisPlayer])
    func loadFavState(isFav:Bool)
}


class TennisLeagueViewController: UICollectionViewController , TennisLeagueDetailsProtocol {
   
    
    var isFav=false
    var sport : SportType = .tennis
    var league : League?
    
    var presenter : TennisDetailsPresenter?
    
    var lastMatches : [TennisMatch] = []
    var upcomingMatches : [TennisMatch] = []
    var players : [TennisPlayer] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = league?.league_name
        let leagueId = league?.league_key ?? 2833
        

        let heartButton = UIBarButtonItem(image: UIImage(systemName: "heart"),style: .plain,target: self,action: #selector(onFavTapped))
        
        navigationItem.rightBarButtonItem = heartButton
        
        view.backgroundColor = .systemBackground
        collectionView.backgroundColor = .clear
        collectionView.alpha = 0
        LoadingIndicatorUtil.shared.show(on: view)
        
        presenter = TennisDetailsPresenter(view: self)
        presenter?.fetchData(sport: sport, leagueId: leagueId)
        presenter?.isFav(leagueId: leagueId)
        
        collectionView.collectionViewLayout = createLayout()
        
        collectionView.register(UINib(nibName: "LastMatchCell", bundle: nil), forCellWithReuseIdentifier: "LastMatchCell")
        
        collectionView.register(UINib(nibName: "TennisGameCell", bundle: nil), forCellWithReuseIdentifier: "TennisGameCell")
        
        collectionView.register(UINib(nibName: "TeamCell", bundle: nil), forCellWithReuseIdentifier: "TeamCell")
        
        collectionView.register(UINib(nibName: "EmptyCell", bundle: nil), forCellWithReuseIdentifier: "EmptyCell")

        
        collectionView.register(SectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderView.identifier)

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
    
    
    func loadData(lastMatches: [TennisMatch], upcomingMatches: [TennisMatch], players: [TennisPlayer]) {
        loadUpcomingGames(matches: upcomingMatches)
        loadLastGames(matches: lastMatches)
        loadPlayers(players: players)
        UIView.animate(withDuration: 0.3) {
                self.collectionView.alpha = 1
            }
        LoadingIndicatorUtil.shared.hide()
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
    
    func createLastMatchesSection()-> NSCollectionLayoutSection {
      let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1)
      , heightDimension: .fractionalHeight(1))
      let item = NSCollectionLayoutItem(layoutSize: itemSize)
      
      let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1)
                                             , heightDimension: .fractionalHeight(0.18))
      let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize
      , subitems: [item])
          group.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16
          , bottom: 8, trailing: 16)
          
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
                                               , heightDimension: .absolute(180))
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



    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        switch section {
        case 0: return players.count
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
            
            cell.homeLabel.text = match.eventFirstPlayer
            cell.awayLabel.text = match.eventSecondPlayer
            
            cell.dateLabel.text = match.eventDate?.toArabicDate()
            cell.timeLabel.text = match.eventTime?.convertEnglishDigitsToArabic()
            
            let logo1 = match.eventFirstPlayerLogo ?? ""
            let logo2 = match.eventSecondPlayerLogo ?? ""
            

            if let url = URL(string: logo1 ){
                cell.homeImageView.kf.setImage(with: url , placeholder: UIImage(named: "teamPlaceHolder"))
                
            }
            
            if let url = URL(string: logo2){
                cell.awayImageView.kf.setImage(with: url , placeholder: UIImage(named: "teamPlaceHolder"))
                
            }
            return cell
        case 2:
            if lastMatches.isEmpty {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmptyCell", for: indexPath) as! EmptyCell
                return cell
            }
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TennisGameCell", for: indexPath) as! TennisGameCell
            
            let match = lastMatches[indexPath.item]
            
            cell.fNameLabel.text = match.eventFirstPlayer
            cell.sNameLabel.text = match.eventSecondPlayer
            
            let labels1 = [cell.l11,cell.l21,cell.l31,cell.l41,cell.l51]
            let labels2 = [cell.l12,cell.l22,cell.l32,cell.l42,cell.l52]
            
            print(match.scores ?? "no data")
                        
            var i = 0
            for s in match.scores! {
                labels1[i]?.text = s.scoreFirst.components(separatedBy: ".").first?.convertEnglishDigitsToArabic() ?? "-"
                labels2[i]?.text = s.scoreSecond.components(separatedBy: ".").first?.convertEnglishDigitsToArabic() ?? "-"
                i += 1
            }
            
            
            if let results = FormatUtils.splitMatchResult(match.eventFinalResult),
               results.count == 2 {
                
                let score1 = Int(results[0]) ?? 0
                let score2 = Int(results[1]) ?? 0

                cell.result1.text = results[0].convertEnglishDigitsToArabic()
                cell.result2.text = results[1].convertEnglishDigitsToArabic()

                if score1 < score2 {
                    cell.result1.textColor = .systemRed
                    cell.result2.textColor = UIColor.systemGreen
                } else{
                    cell.result1.textColor = UIColor.systemGreen
                    cell.result2.textColor = .systemRed
                }
            }

            
            cell.dateLabel.text = match.eventDate?.toArabicDate()
            
            let logo1 = match.eventFirstPlayerLogo ?? ""
            let logo2 = match.eventSecondPlayerLogo ?? ""
            

            if let url = URL(string: logo1 ){
                cell.fImageView.kf.setImage(with: url , placeholder: UIImage(named: "teamPlaceHolder"))
                
            }
            
            if let url = URL(string: logo2){
                cell.sImageView.kf.setImage(with: url , placeholder: UIImage(named: "teamPlaceHolder"))
                
            }
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamCell", for: indexPath) as! TeamCell
            
            let player = players[indexPath.item]
            cell.teamLabel.text = player.playerName
            if let url = URL(string: player.playerLogo ?? ""){
                cell.teamImageView.kf.setImage(with: url , placeholder: UIImage(named: "teamPlaceHolder"))
                
            }
            return cell
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderView.identifier, for: indexPath) as! SectionHeaderView
            switch indexPath.section {
            case 0: header.configure(with: NSLocalizedString("players", comment: ""))
            case 1: header.configure(with: NSLocalizedString("upcoming_matches", comment: ""))
            case 2: header.configure(with: NSLocalizedString("last_matches", comment: ""))
            default: break
            }
            return header
        }
        return UICollectionReusableView()
    }

    
    private func loadLastGames(matches: [TennisMatch]) {
        lastMatches = matches
        collectionView.reloadData()
    }
    
    private func loadUpcomingGames(matches: [TennisMatch]) {
        upcomingMatches = matches
        collectionView.reloadData()
    }
    
    private func loadPlayers(players : [TennisPlayer]) {
        self.players = players
        collectionView.reloadData()
    }

}
