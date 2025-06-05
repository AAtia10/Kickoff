import Foundation

class TennisDetailsPresenter{
    
    
    var view : TennisLeagueDetailsProtocol?
    
    init(view: TennisLeagueDetailsProtocol? = nil) {
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
        fetchLastMatches(sport: sport, leagueId: leagueId)
    }
    
    private func fetchLastMatches(sport:SportType , leagueId:Int){
        
        let fromDate = DateUtils.dateTwentyYearsAgo()
        let toDate = DateUtils.dateYesterday()
        
        RemoteDataSource.shared.requestTennisFixtures(sport: sport, leagueId: leagueId, from: fromDate, to:toDate){
            result in
            switch result {
            case .success(let matches):
                self.fetchUpcomingMatches(sport: sport, leagueId: leagueId, lastMatches:matches)
            case .failure(_):
                self.fetchUpcomingMatches(sport: sport, leagueId: leagueId, lastMatches:[])
            }
        }
    }
    
    private func fetchUpcomingMatches(sport:SportType , leagueId:Int , lastMatches : [TennisMatch]){
        let fromDate = DateUtils.dateToday()
        let toDate = DateUtils.dateNextMonth()
        RemoteDataSource.shared.requestTennisFixtures(sport: sport, leagueId: leagueId, from: fromDate, to: toDate){
            result in
            switch result {
            case .success(let matches):
                self.fetchPlayers(leagueId: leagueId, lastMatches: lastMatches, upComingMatches: matches)
            case .failure(_):
                self.fetchPlayers(leagueId: leagueId, lastMatches: lastMatches, upComingMatches: [])
            }
        }
    }
    
    private func fetchPlayers(leagueId:Int, lastMatches : [TennisMatch], upComingMatches : [TennisMatch]){
        RemoteDataSource.shared.getTennisPlayersOfLeague(leagueId: leagueId){
            result in
            switch result {
            case .success(let players):
                self.view?.loadData(lastMatches: lastMatches, upcomingMatches: upComingMatches, players: players)
            case .failure(_):
                self.view?.loadData(lastMatches: lastMatches, upcomingMatches: upComingMatches, players: [])
            }
        }
    }
}
