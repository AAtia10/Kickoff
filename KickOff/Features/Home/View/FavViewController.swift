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
       let placeholerImage = UIImage(systemName: "soccerball")
        cell.leagueName.text = league.league_name
        if let url = URL(string: league.league_logo) {
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
    
    

    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
