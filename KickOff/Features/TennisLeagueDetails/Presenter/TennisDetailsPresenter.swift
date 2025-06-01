import Foundation

class TennisDetailsPresenter{
    
    
    var view : TennisLeagueDetailsProtocol?
    
    init(view: TennisLeagueDetailsProtocol? = nil) {
        self.view = view
    }
    
    func fetchLastMatches(sport:SportType , leagueId:Int){
        RemoteDataSource.shared.getLastGames(sport: sport, leagueId: leagueId){
            result in
            switch result {
            case .success(let matches):
                self.view?.loadLastGames(matches: matches)
            case .failure(_):
                self.view?.loadLastGames(matches: [])
            }
        }
    }
    
    func fetchUpcomingMatches(sport:SportType , leagueId:Int){
        RemoteDataSource.shared.getUpcomingGames(sport: sport, leagueId: leagueId){
            result in
            switch result {
            case .success(let matches):
                self.view?.loadUpcomingGames(matches: matches)
            case .failure(_):
                self.view?.loadUpcomingGames(matches: [])
            }
        }
    }
    
    func fetchPlayers(leagueId:Int){
        RemoteDataSource.shared.getTennisPlayersOfLeague(leagueId: leagueId){
            result in
            switch result {
            case .success(let players):
                self.view?.loadPlayers(players: players)
            case .failure(_):
                self.view?.loadPlayers(players: [])
            }
        }
    }
}
