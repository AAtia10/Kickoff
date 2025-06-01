//
//  TeamDetailsViewController.swift
//  KickOff
//
//  Created by Abdelrahman Atia on 31/05/2025.
//

import UIKit
import Kingfisher
protocol TeamDetailsProtocol: AnyObject {
    func renderTeamDetails(_ team: Team)
}


class TeamDetailsViewController: UIViewController, TeamDetailsProtocol, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var teamTable: UITableView!
    @IBOutlet weak var teamLabel: UILabel!
    @IBOutlet weak var teamImage: UIImageView!
    
    var presenter: TeamDetailsPresenter?
    var team: Team?

    var playerSections: [String: [FootballPlayer]] = [:]
    var sectionTitles: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        teamTable.delegate = self
        teamTable.dataSource = self
        teamTable.rowHeight = 100
        
        presenter = TeamDetailsPresenter(view: self)
        
        if let id = team?.team_key {
            presenter?.fetchTeamDetails(sport: .football, teamId: id)
        }
        
        
        let nib=UINib(nibName: "PlayerDetailsCell", bundle: nil)
        teamTable.register(nib, forCellReuseIdentifier: "cell")

        // Do any additional setup after loading the view.
    }
    
    func renderTeamDetails(_ team: Team) {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }

                self.team = team
                self.teamLabel.text = team.team_name
                if let logoUrl = team.team_logo, let url = URL(string: logoUrl) {
                    self.teamImage.kf.setImage(with: url)
                }

                if let players = team.players {
                    self.playerSections = Dictionary(grouping: players) { player in
                        switch player.player_type?.lowercased() {
                        case "goalkeepers":
                            return "Goalkeepers"
                        case "defenders":
                            return "Defenders"
                        case "midfielders":
                            return "Midfielders"
                        case "forwards":
                            return "Forwards"
                        default:
                            return "Others"
                        }
                    }
                }

                if let _ = team.coaches, !team.coaches!.isEmpty {
                    self.sectionTitles = ["Coach"]
                }
                
                let order = ["Goalkeepers", "Defenders", "Midfielders", "Forwards", "Others"]
                self.sectionTitles += order.filter { self.playerSections[$0] != nil }

                self.teamTable.reloadData()
            }
        }
    
    func numberOfSections(in tableView: UITableView) -> Int {
            return sectionTitles.count
        }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return sectionTitles[section]
        }

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            let title = sectionTitles[section]
            if title == "Coach" {
                return team?.coaches?.count ?? 0
            }
            return playerSections[title]?.count ?? 0
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

            let title = sectionTitles[indexPath.section]
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PlayerDetailsCell

            if title == "Coach" {
                if let coach = team?.coaches?[indexPath.row] {
                    cell.playerName.text = coach.coach_name
                    cell.playerNumber.text = coach.coach_country
                    cell.playerImage.image = UIImage(named: "coach")
                }
            } else {
                if let player = playerSections[title]?[indexPath.row] {
                    cell.playerName.text = player.player_name
                    cell.playerNumber.text = player.player_number
                    if let imageUrl = player.player_image, let url = URL(string: imageUrl) {
                        cell.playerImage.kf.setImage(with: url,placeholder: UIImage(named: "playerplaceholder"))
                    } else {
                        cell.playerImage.image = UIImage(named: "playerplaceholder")
                    }
                }
            }

            return cell
        }

    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
