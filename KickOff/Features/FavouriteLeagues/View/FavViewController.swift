//
//  FavViewController.swift
//  KickOff
//
//  Created by Abdelrahman Atia on 02/06/2025.
//

import UIKit
import Kingfisher

protocol FavViewProtocol {
    func showFavoriteLeagues(_ leagues: [LocalLeague])
}

class FavViewController: UITableViewController,FavViewProtocol {
   
    
    var favoriteLeagues: [LocalLeague] = []
    var presenter:FavPresenter?


    override func viewDidLoad() {
        super.viewDidLoad()
        presenter=FavPresenter(view:self)
    
        let nib=UINib(nibName: "LeaguesTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "cell")
        
        
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        presenter?.fetchFav()
    }
    
    
    func showFavoriteLeagues(_ leagues: [LocalLeague]) {
        favoriteLeagues=leagues
        tableView.reloadData()
    }
    



    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return favoriteLeagues.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)as! LeaguesTableViewCell

        let league = favoriteLeagues[indexPath.row]
        
        var placeholerImage : UIImage!
        
        
        switch league.sport {
        case .football:
            placeholerImage = UIImage(systemName: "soccerball")
        case .tennis:
            placeholerImage = UIImage(systemName: "tennisball.fill")
            cell.leagueImage.tintColor = .systemGreen
        case .basketball:
            placeholerImage = UIImage(systemName: "basketball.fill")
            cell.leagueImage.tintColor = .systemOrange
        case .cricket:
            placeholerImage = UIImage(systemName: "cricket.ball.fill")
            cell.leagueImage.tintColor = .systemRed
        }
        
        cell.leagueName.text = league.league_name
        if let url = URL(string: league.league_logo ?? "") {
            cell.leagueImage.kf.setImage(with: url , placeholder: placeholerImage)
        } else {
            cell.leagueImage.image = placeholerImage
        }

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100 // Your cell height
    }

    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50// Space below the last cell
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50// Space above the first cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let league = favoriteLeagues[indexPath.row]
        if editingStyle == .delete {
            AlertManager.showDeleteAlert(
                on: self,
                title: "Confirm",
                message: "Are you sure you want to remove this from favorites?"
            ) {
                self.presenter?.removeLeague(id: league.league_key)
            }
        } else if editingStyle == .insert {
            // Handle insert if needed
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let league = favoriteLeagues[indexPath.row]
        
        switch league.sport{
        case .tennis:
            navigateToTennisLeagueDetails(leauge: league)
        case .cricket:
            navigateToCricketLeagueDetails(leauge: league)
        default:
            navigateToLeagueDetails(leauge: league)
        }
    }
    
    
    func navigateToLeagueDetails(leauge : LocalLeague){
        let storyboard = UIStoryboard(name: "LeagueDetails", bundle: nil)
        let lVC = storyboard.instantiateViewController(withIdentifier: "leagueDetails") as! LeagueDetailsViewController
        lVC.sport = leauge.sport
        lVC.league = League(league_key: leauge.league_key, league_name: leauge.league_name, league_logo: leauge.league_logo)
        self.navigationController?.pushViewController(lVC, animated: true)
    }
    
    func navigateToTennisLeagueDetails(leauge : LocalLeague){
        let storyboard = UIStoryboard(name: "TennisDetails", bundle: nil)
        let lVC = storyboard.instantiateViewController(withIdentifier: "TennisDetails") as! TennisLeagueViewController
        lVC.league = League(league_key: leauge.league_key, league_name: leauge.league_name, league_logo: leauge.league_logo)
        self.navigationController?.pushViewController(lVC, animated: true)
    }
    
    func navigateToCricketLeagueDetails(leauge : LocalLeague){
        let storyboard = UIStoryboard(name: "CricketDetails", bundle: nil)
        let lVC = storyboard.instantiateViewController(withIdentifier: "CricketDetails") as! CircketLeagueViewController
        lVC.league = League(league_key: leauge.league_key, league_name: leauge.league_name, league_logo: leauge.league_logo)
        self.navigationController?.pushViewController(lVC, animated: true)
    }

}
