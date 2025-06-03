import Foundation

class LeaugeDetailsPresenter{
    
    var view : LeagueDetailsProtocol?
    
    init(view: LeagueDetailsProtocol? = nil) {
        self.view = view
    }
    
    func fetchData(sport:SportType , leagueId:Int){
        fetchLastMatches(sport: sport, leagueId: leagueId)
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
    
    
    private func fetchLastMatches(sport:SportType , leagueId:Int){
        
        let fromDate = DateUtils.dateTwoMonthsAgo()
        let toDate = DateUtils.dateYesterday()
        
        RemoteDataSource.shared.requestFixtures(sport: sport, leagueId: leagueId, from: fromDate, to: toDate){
            result in
            var lastMatches : [Match] = []
            switch result {
            case .success(let matches):
                lastMatches = matches
            case .failure(_):
                lastMatches = []
            }
            self.fetchUpcomingMatches(sport: sport, leagueId: leagueId, lastMatches: lastMatches)
        }
    }
    private func fetchUpcomingMatches(sport:SportType , leagueId:Int , lastMatches:[Match]){
        let fromDate = DateUtils.dateToday()
        let toDate = DateUtils.dateNextMonth()
        var upcomingMatches : [Match] = []
        
        RemoteDataSource.shared.requestFixtures(sport: sport, leagueId: leagueId, from: fromDate, to: toDate){
            result in
            
            switch result {
            case .success(let matches):
                upcomingMatches = matches
            case .failure(_):
                upcomingMatches = []
            }
            self.fetchTeams(sport: sport, leagueId: leagueId, lastMatches: lastMatches, upcomingMatches: upcomingMatches)
        }
    }
    
    private func fetchTeams(sport:SportType , leagueId:Int , lastMatches:[Match] , upcomingMatches:[Match]){
        RemoteDataSource.shared.getTeamsOfLeague(sport: sport, leagueId: leagueId){
            result in
            var list : [Team] = []
            switch result {
            case .success(let teams):
                list = teams
            case .failure(_):
                list = []
            }
            self.showData(lastMatches: lastMatches, upcomingMatches: upcomingMatches, teams: list)
        }
    }
    
    private func showData(lastMatches:[Match] , upcomingMatches:[Match] , teams:[Team]){
        self.view?.loadData(lastMatches: lastMatches, upcomingMatches: upcomingMatches, teams: teams)
    }
    
    
    
}
