//
//  CricketLeaguePresenter.swift
//  KickOff
//
//  Created by Abdelrahman on 01/06/2025.
//

import Foundation

class CricketLeaguePresenter{
    
    
    var view : CricketLeagueDetailsProtocol?
    
    init(view: CricketLeagueDetailsProtocol? = nil) {
        self.view = view
    }
    
    func fetchUpcomingMatches(sport:SportType , leagueId:Int){
        let fromDate = DateUtils.dateToday()
        let toDate = DateUtils.dateNextMonth()
        RemoteDataSource.shared.requestFixtures(sport: sport, leagueId: leagueId, from: fromDate, to: toDate){
            result in
            switch result {
            case .success(let matches):
                self.view?.loadUpcomingGames(matches: matches)
            case .failure(_):
                self.view?.loadUpcomingGames(matches: [])
            }
        }
    }
    
    func fetchLastMatches(sport:SportType , leagueId:Int){
        
        let fromDate = DateUtils.dateFiveYearsAgo()
        let toDate = DateUtils.dateYesterday()
        
        RemoteDataSource.shared.requestFixtures(sport: sport, leagueId: leagueId, from: fromDate, to:toDate){
            result in
            switch result {
            case .success(let matches):
                self.view?.loadLastGames(matches: matches)
            case .failure(_):
                self.view?.loadLastGames(matches: [])
            }
        }
    }
    
    func fetchTeams(sport:SportType , leagueId:Int){
        RemoteDataSource.shared.getTeamsOfLeague(sport: sport, leagueId: leagueId){
            result in
            
            switch result {
            case .success(let teams):
                self.view?.loadTeams(teams: teams)
            case .failure(_):
                self.view?.loadTeams(teams: [])
            }
        }
    }
    
}
