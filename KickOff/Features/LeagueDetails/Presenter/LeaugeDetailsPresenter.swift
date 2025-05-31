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
    func fetchUpcomingMatches(sport:SportType , leagueId:Int){
        RemoteDataSource.shared.getUpcomingMatches(sport: sport, leagueId: leagueId){
            result in
            
            switch result {
            case .success(let matches):
                self.view?.loadUpcomingMatches(matches: matches)
            case .failure(_):
                self.view?.loadUpcomingMatches(matches: [])
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
