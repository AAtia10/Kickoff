//
//  LeaugeDetailsPresenter.swift
//  KickOff
//
//  Created by Abdelrahman on 30/05/2025.
//

import Foundation

class LeaugeDetailsPresenter{
    
    var view : LeagueDetailsProtocol?
    
    init(view: LeagueDetailsProtocol? = nil) {
        self.view = view
    }
    
    func fetchLastMatches(sport:SportType , leagueId:Int){
        RemoteDataSource.shared.getLastMatches(sport: sport, leagueId: leagueId){
            result in
            
            switch result {
            case .success(let matches):
                self.view?.loadLastMatches(matches: matches)
            case .failure(_):
                self.view?.loadLastMatches(matches: [])
            }
        }
    }
    
}
