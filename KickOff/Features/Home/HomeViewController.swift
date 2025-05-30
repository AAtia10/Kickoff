//
//  HomeViewController.swift
//  KickOff
//
//  Created by Abdelrahman on 29/05/2025.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        RemoteDataSource.shared.getAllLeagues(for: .football) { result in
            switch result {
            case .success(let leagues):
                for league in leagues {
                    print("League: \(league.league_name), Country: \(league.country_name)")
                }
            case .failure(let error):
                print("Error fetching leagues:", error)
            }
        }
    }
    
}
