//
//  LeaguesPresenter.swift
//  KickOff
//
//  Created by Abdelrahman Atia on 30/05/2025.
//

class LeaguesPresenter {
    
    weak var view: LeaguesProtocol?

    init(view: LeaguesProtocol) {
        self.view = view
    }

    func fetchLeagues(for sport: SportType) {
        RemoteDataSource.shared.getAllLeagues(for: sport) { [weak self] result in
            if case .success(let leagues) = result {
                self?.view?.renderLeagues(leagues: leagues)
            }
        }
    }
}


