//
//  LeaguesViewController.swift
//  KickOff
//
//  Created by Abdelrahman Atia on 30/05/2025.
//

import UIKit
import Kingfisher


protocol LeaguesProtocol: AnyObject {
    func renderLeagues(leagues: [League])
}


class LeaguesViewController: UITableViewController,LeaguesProtocol, UISearchResultsUpdating {
    
    
    
    var filteredLeagues: [League] = []
        
    var presenter: LeaguesPresenter!
    var leagues: [League] = []
    var sportType: SportType?
    var searchController: UISearchController!
    
   
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let t = sportType?.displayName{
            self.title = t
        }

        let nib=UINib(nibName: "LeaguesTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "cell")
        
        LoadingIndicatorUtil.shared.show(on: self.view)
        presenter = LeaguesPresenter(view: self)
        presenter.fetchLeagues(for: sportType ?? .football)
        
        setupSearchController()
      
        
    }
    
    func renderLeagues(leagues: [League]) {
           DispatchQueue.main.async {
               self.leagues = leagues
               self.filteredLeagues = leagues
               self.tableView.reloadData()
               LoadingIndicatorUtil.shared.hide()
           }
       }
    
    
    
    private func setupSearchController() {
           searchController = UISearchController(searchResultsController: nil)
           searchController.searchResultsUpdater = self
           searchController.obscuresBackgroundDuringPresentation = false
           searchController.searchBar.placeholder = "Search Leagues"
           navigationItem.searchController = searchController
           definesPresentationContext = true
           
           // Customize search bar appearance if needed
           searchController.searchBar.tintColor = .systemBlue
           searchController.searchBar.searchTextField.backgroundColor = .systemBackground
       }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return isFiltering() ? filteredLeagues.count : leagues.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LeaguesTableViewCell
        cell.contentView.frame = cell.contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 64, bottom: 0, right: 64))
        
        var placeholerImage: UIImage!
        
        switch sportType {
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
        case nil:
            placeholerImage = UIImage(named: "leaguePlaceholder")
        }
        
        let league = isFiltering() ? filteredLeagues[indexPath.row] : leagues[indexPath.row]
        cell.leagueName.text = league.league_name
        if let logo = league.league_logo, let url = URL(string: logo) {
            cell.leagueImage.kf.setImage(with: url, placeholder: placeholerImage)
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedLeague = isFiltering() ? filteredLeagues[indexPath.row] : leagues[indexPath.row]
        NetworkManager.isInternetAvailable  { isConnected in
            DispatchQueue.main.async {
                if isConnected {
                    switch self.sportType {
                    case .tennis:
                        self.navigateToTennisLeagueDetails(leauge: selectedLeague)
                    case .cricket:
                        self.navigateToCricketLeagueDetails(leauge: selectedLeague)
                    default:
                        self.navigateToLeagueDetails(leauge: selectedLeague)
                    }                } else {
                        AlertManager.showNoInternetAlert(on: self)
                    }
            }
        }
    }
    
    private func isFiltering() -> Bool {
           return searchController.isActive && !(searchController.searchBar.text?.isEmpty ?? true)
       }
    
    private func filterContentForSearchText(_ searchText: String) {
            filteredLeagues = leagues.filter { league in
                return league.league_name.lowercased().contains(searchText.lowercased()) ?? false
            }
            tableView.reloadData()
        }
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text ?? "")
    }
    
    func navigateToLeagueDetails(leauge : League){
        let storyboard = UIStoryboard(name: "LeagueDetails", bundle: nil)
        let lVC = storyboard.instantiateViewController(withIdentifier: "leagueDetails") as! LeagueDetailsViewController
        lVC.sport = self.sportType
        lVC.league = leauge
        self.navigationController?.pushViewController(lVC, animated: true)
    }
    
    func navigateToTennisLeagueDetails(leauge : League){
        let storyboard = UIStoryboard(name: "TennisDetails", bundle: nil)
        let lVC = storyboard.instantiateViewController(withIdentifier: "TennisDetails") as! TennisLeagueViewController
        lVC.league = leauge
        self.navigationController?.pushViewController(lVC, animated: true)
    }
    
    func navigateToCricketLeagueDetails(leauge : League){
        let storyboard = UIStoryboard(name: "CricketDetails", bundle: nil)
        let lVC = storyboard.instantiateViewController(withIdentifier: "CricketDetails") as! CircketLeagueViewController
        lVC.league = leauge
        self.navigationController?.pushViewController(lVC, animated: true)
    }

   

    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
