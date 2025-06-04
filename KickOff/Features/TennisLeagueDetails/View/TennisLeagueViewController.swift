
import UIKit

protocol TennisLeagueDetailsProtocol {
    func loadLastGames(matches : [TennisMatch])
    func loadUpcomingGames(matches : [TennisMatch])
    func loadPlayers(players : [TennisPlayer])
}


class TennisLeagueViewController: UICollectionViewController , TennisLeagueDetailsProtocol {
    
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
        
        presenter = TennisDetailsPresenter(view: self)
        presenter?.fetchUpcomingMatches(sport: sport, leagueId: leagueId)
        presenter?.fetchLastMatches(sport: sport, leagueId: leagueId)
        presenter?.fetchPlayers(leagueId: leagueId)
        
        
       

        collectionView.collectionViewLayout = createLayout()
        
        collectionView.register(UINib(nibName: "LastMatchCell", bundle: nil), forCellWithReuseIdentifier: "LastMatchCell")
        
        collectionView.register(UINib(nibName: "TennisGameCell", bundle: nil), forCellWithReuseIdentifier: "TennisGameCell")
        
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
                                               , heightDimension: .absolute(180))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize
                                                     , subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8
                                                      , bottom: 8, trailing: 8)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0
                                                        , bottom: 0, trailing: 0)
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
        case 0: return upcomingMatches.count
        case 1: return lastMatches.count
        default: return players.count
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LastMatchCell", for: indexPath) as! LastMatchCell
            let match = upcomingMatches[indexPath.item]
            
            cell.homeLabel.text = match.eventFirstPlayer
            cell.awayLabel.text = match.eventSecondPlayer
            
            let logo1 = match.eventFirstPlayerLogo ?? ""
            let logo2 = match.eventSecondPlayerLogo ?? ""
            

            if let url = URL(string: logo1 ){
                cell.homeImageView.kf.setImage(with: url , placeholder: UIImage(systemName: "photo"))
                
            }
            
            if let url = URL(string: logo2){
                cell.awayImageView.kf.setImage(with: url , placeholder: UIImage(systemName: "photo"))
                
            }
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TennisGameCell", for: indexPath) as! TennisGameCell
            
            let match = lastMatches[indexPath.item]
            
            cell.fNameLabel.text = match.eventFirstPlayer
            cell.sNameLabel.text = match.eventSecondPlayer
            
            let labels1 = [cell.l11,cell.l21,cell.l31,cell.l41,cell.l51]
            let labels2 = [cell.l12,cell.l22,cell.l32,cell.l42,cell.l52]
            
            print(match.scores ?? "no data")
                        
            var i = 0
            for s in match.scores! {
                labels1[i]?.text = s.scoreFirst.components(separatedBy: ".").first ?? "-"
                labels2[i]?.text = s.scoreSecond.components(separatedBy: ".").first ?? "-"
                i += 1
            }
            
            
            if let results = FormatUtils.splitMatchResult(match.eventFinalResult),
               results.count == 2 {
                
                let score1 = Int(results[0]) ?? 0
                let score2 = Int(results[1]) ?? 0

                cell.result1.text = results[0]
                cell.result2.text = results[1]

                if score1 < score2 {
                    cell.result1.textColor = .systemRed
                    cell.result2.textColor = UIColor.systemGreen
                } else{
                    cell.result1.textColor = UIColor.systemGreen
                    cell.result2.textColor = .systemRed
                }
            }

            
            cell.dateLabel.text = match.eventDate
            
            let logo1 = match.eventFirstPlayerLogo ?? ""
            let logo2 = match.eventSecondPlayerLogo ?? ""
            

            if let url = URL(string: logo1 ){
                cell.fImageView.kf.setImage(with: url , placeholder: UIImage(systemName: "photo"))
                
            }
            
            if let url = URL(string: logo2){
                cell.sImageView.kf.setImage(with: url , placeholder: UIImage(systemName: "photo"))
                
            }
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamCell", for: indexPath) as! TeamCell
            
            let player = players[indexPath.item]
            cell.teamLabel.text = player.playerName
            if let url = URL(string: player.playerLogo ?? ""){
                cell.teamImageView.kf.setImage(with: url , placeholder: UIImage(systemName: "photo"))
                
            }
            
            cell.container.backgroundColor  = UIColor { traitCollection in
                return traitCollection.userInterfaceStyle == .dark ? .black : .white
            }
            return cell
        }
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
    
    func loadLastGames(matches: [TennisMatch]) {
        lastMatches = matches
        collectionView.reloadData()
    }
    
    func loadUpcomingGames(matches: [TennisMatch]) {
        upcomingMatches = matches
        collectionView.reloadData()
    }
    
    func loadPlayers(players : [TennisPlayer]) {
        self.players = players
        collectionView.reloadData()
    }

}
