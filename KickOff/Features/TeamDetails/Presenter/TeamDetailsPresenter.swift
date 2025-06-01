//
//  TeamDetailsPresenter.swift
//  KickOff
//
//  Created by Abdelrahman Atia on 01/06/2025.
//

import Foundation

class TeamDetailsPresenter {
    weak var view: TeamDetailsProtocol?
    
    init(view: TeamDetailsProtocol) {
        self.view = view
    }
    
    func fetchTeamDetails(sport: SportType, teamId: Int) {
        RemoteDataSource.shared.getTeamDetails(for: sport, teamId: teamId) { [weak self] result in
            print(result)
            switch result {
            case .success(let teams):
                if let team = teams.first {
                    self?.view?.renderTeamDetails(team)
                } else {
                    print("No team found in the response.")
                }
            case .failure(let error):
                print("Failed to fetch team details: \(error)")
            }
        }
    }
}
