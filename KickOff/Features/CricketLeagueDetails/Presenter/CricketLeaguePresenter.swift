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
    
    func isFav(leagueId:Int){
        let isFav = LocalDataSource.instance.isFav(key: leagueId)
        self.view?.loadFavState(isFav: isFav)
    }
    
    func removeFromFav(leagueId:Int){
        LocalDataSource.instance.removeLeague(byKey: leagueId, completion: {
            self.view?.loadFavState(isFav: false)
        })
    }
    
    func addToFav(league: LocalLeague){
        LocalDataSource.instance.addLeague(league)
        self.view?.loadFavState(isFav: true)
    }
    
    func fetchData(sport:SportType , leagueId:Int){
        fetchUpcomingMatches(sport: sport, leagueId: leagueId)
    }
    
    private func fetchUpcomingMatches(sport:SportType , leagueId:Int){
        let fromDate = DateUtils.dateToday()
        let toDate = DateUtils.dateNextMonth()
        RemoteDataSource.shared.requestFixtures(sport: sport, leagueId: leagueId, from: fromDate, to: toDate){
            result in
            switch result {
            case .success(let matches):
                self.fetchLastMatches(sport: sport, leagueId: leagueId, upcomingMatches: matches)
            case .failure(_):
                self.fetchLastMatches(sport: sport, leagueId: leagueId, upcomingMatches: [])
            }
        }
    }
    
    private func fetchLastMatches(sport:SportType , leagueId:Int , upcomingMatches:[Match]){
        
        let fromDate = DateUtils.dateFiveYearsAgo()
        let toDate = DateUtils.dateYesterday()
        
        RemoteDataSource.shared.requestFixtures(sport: sport, leagueId: leagueId, from: fromDate, to:toDate){
            result in
            switch result {
            case .success(let matches):
                self.fetchTeams(sport:sport , leagueId:leagueId, upcomingMatches:upcomingMatches, lastMatches:matches)
            case .failure(_):
                self.fetchTeams(sport:sport , leagueId:leagueId, upcomingMatches:upcomingMatches, lastMatches:[])
            }
        }
    }
    
    private func fetchTeams(sport:SportType , leagueId:Int, upcomingMatches:[Match], lastMatches:[Match]){
        RemoteDataSource.shared.getTeamsOfLeague(sport: sport, leagueId: leagueId){
            result in
            
            switch result {
            case .success(let teams):
                self.view?.loadData(lastMatches: lastMatches, upcomingMatches: upcomingMatches, teams: teams)
            case .failure(_):
                self.view?.loadData(lastMatches: lastMatches, upcomingMatches: upcomingMatches, teams: [])
            }
        }
    }
    
}
