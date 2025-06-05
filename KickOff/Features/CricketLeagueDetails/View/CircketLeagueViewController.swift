//
//  CircketLeagueViewController.swift
//  KickOff
//
//  Created by Abdelrahman on 01/06/2025.
//

import UIKit
import Kingfisher

protocol CricketLeagueDetailsProtocol {
    func loadData(lastMatches:[Match] , upcomingMatches:[Match] , teams:[Team])
    func loadFavState(isFav:Bool)
}


class CircketLeagueViewController: UICollectionViewController , CricketLeagueDetailsProtocol {
   
    
    var isFav=false
    
    var sport : SportType = .cricket
    var league : League?
    
    var presenter : CricketLeaguePresenter?
    
    var lastMatches : [Match] = []
    var upcomingMatches : [Match] = []
    var teams : [Team] = []
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = league?.league_name
        let leagueId = league?.league_key ?? 0
        

        let heartButton = UIBarButtonItem(image: UIImage(systemName: "heart"),style: .plain,target: self,action: #selector(onFavTapped))
        
        navigationItem.rightBarButtonItem = heartButton
        
        view.backgroundColor = .systemBackground
        collectionView.backgroundColor = .clear
        collectionView.alpha = 0
        LoadingIndicatorUtil.shared.show(on: self.view)
        
        
        presenter = CricketLeaguePresenter(view: self)
        presenter?.fetchData(sport: sport, leagueId: leagueId)
        presenter?.isFav(leagueId: leagueId)

 

        collectionView.collectionViewLayout = createLayout()
        
        collectionView.register(UINib(nibName: "LastMatchCell", bundle: nil), forCellWithReuseIdentifier: "LastMatchCell")
        
        collectionView.register(UINib(nibName: "CricketGameCell", bundle: nil), forCellWithReuseIdentifier: "CricketGameCell")
        
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
    
    func loadData(lastMatches: [Match], upcomingMatches: [Match], teams: [Team]) {
        loadUpcomingGames(matches: upcomingMatches)
        loadLastGames(matches: lastMatches)
        loadTeams(teams: teams)
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
            case 1: return self.createLastMatchesSection()
            case 2: return self.createUpcomingMatchesSection()
            default: return self.createTeamsSection()
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
                                               , heightDimension: .absolute(200))
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
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 1: return upcomingMatches.isEmpty ? 1 : upcomingMatches.count
        case 2: return lastMatches.isEmpty ? 1 : lastMatches.count
        default: return teams.count
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
            
            let logo1 = match.event_home_team_logo ?? ""
            let logo2 = match.event_away_team_logo ?? ""
            

            if let url = URL(string: logo1 ){
                cell.homeImageView.kf.setImage(with: url , placeholder: UIImage(systemName: "photo"))
                
            }
            
            if let url = URL(string: logo2){
                cell.awayImageView.kf.setImage(with: url , placeholder: UIImage(systemName: "photo"))
                
            }
            return cell
        case 2:
            if lastMatches.isEmpty {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmptyCell", for: indexPath) as! EmptyCell
                return cell
            }
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CricketGameCell", for: indexPath) as! CricketGameCell
            
            let match = lastMatches[indexPath.item]
            
            cell.homeName.text = match.event_home_team
            cell.awayName.text = match.event_away_team
            
            
            cell.homeResult.text = match.event_home_final_result?.convertEnglishDigitsToArabic() ?? "-"
            cell.awayResult.text = match.event_away_final_result?.convertEnglishDigitsToArabic() ?? "-"
            
           
            cell.dateLabel.text = match.event_date_stop?.toArabicDate() ?? ""
            
            let logo1 = match.event_home_team_logo ?? ""
            let logo2 = match.event_away_team_logo ?? ""
            

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


    private func loadLastGames(matches: [Match]) {
        lastMatches = matches
        collectionView.reloadData()
    }
    
    private func loadUpcomingGames(matches: [Match]) {
        upcomingMatches = matches
        collectionView.reloadData()
    }
    
    private func loadTeams(teams: [Team]) {
        self.teams = teams
        collectionView.reloadData()
    }
    

}
