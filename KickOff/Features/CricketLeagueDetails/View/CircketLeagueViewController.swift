//
//  CircketLeagueViewController.swift
//  KickOff
//
//  Created by Abdelrahman on 01/06/2025.
//

import UIKit
import Kingfisher

protocol CricketLeagueDetailsProtocol {
    func loadLastGames(matches : [Match])
    func loadUpcomingGames(matches : [Match])
    func loadTeams(teams : [Team])
}


class CircketLeagueViewController: UICollectionViewController , CricketLeagueDetailsProtocol {
    
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
        
        presenter = CricketLeaguePresenter(view: self)
        presenter?.fetchLastMatches(sport: sport, leagueId: leagueId)
        presenter?.fetchUpcomingMatches(sport: sport, leagueId: leagueId)
        presenter?.fetchTeams(sport: sport, leagueId: leagueId)
        
       

        collectionView.collectionViewLayout = createLayout()
        
        collectionView.register(UINib(nibName: "LastMatchCell", bundle: nil), forCellWithReuseIdentifier: "LastMatchCell")
        
        collectionView.register(UINib(nibName: "CricketGameCell", bundle: nil), forCellWithReuseIdentifier: "CricketGameCell")
        
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
                                               , heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize
                                                     , subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8
                                                      , bottom: 8, trailing: 8)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0
                                                        , bottom: 0, trailing: 0)
        return section
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
            
            let logo1 = match.event_home_team_logo ?? ""
            let logo2 = match.event_away_team_logo ?? ""
            

            if let url = URL(string: logo1 ){
                cell.homeImageView.kf.setImage(with: url , placeholder: UIImage(systemName: "photo"))
                
            }
            
            if let url = URL(string: logo2){
                cell.awayImageView.kf.setImage(with: url , placeholder: UIImage(systemName: "photo"))
                
            }
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CricketGameCell", for: indexPath) as! CricketGameCell
            
            let match = lastMatches[indexPath.item]
            
            cell.homeName.text = match.event_home_team
            cell.awayName.text = match.event_away_team
            
            
            cell.homeResult.text = match.event_home_final_result ?? "-"
            cell.awayResult.text = match.event_away_final_result ?? "-"
            
           
            cell.dateLabel.text = match.event_date_stop ?? ""
            
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

    func loadLastGames(matches: [Match]) {
        lastMatches = matches
        collectionView.reloadData()
    }
    
    func loadUpcomingGames(matches: [Match]) {
        upcomingMatches = matches
        collectionView.reloadData()
    }
    
    func loadTeams(teams: [Team]) {
        self.teams = teams
        collectionView.reloadData()
    }
    

}
