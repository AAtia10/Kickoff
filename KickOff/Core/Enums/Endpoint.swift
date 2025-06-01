import Foundation

enum Endpoint {
    case leagues(sport: SportType)
    case fixtures(sport: SportType, leagueId: Int, from: String, to: String)
    case teams(sport: SportType, leagueId: Int)
    case tennisPlayers(sport: SportType = .tennis ,leagueId: Int)
    case teamDetails(sport: SportType, teamId: Int)
    
    
    private var baseURL: String {
        return "https://apiv2.allsportsapi.com/"
    }
    
    private var apiKey: String {
        return "951a4e5ff5f0c33a22aa28695ab0ad3ae1e1b8a3343073217ecbbdc9d1962dc6"
        
        
    }
    
    var url: String {
        switch self {
        case .leagues(let sport), .fixtures(let sport, _, _, _) , .teams(let sport,_) , .tennisPlayers(let sport , _, .teamDetails(let sport, _)):
            return "\(baseURL)\(sport.rawValue)"
        }
    }
        
        var parameters: [String: Any] {
            switch self {
            case .leagues:
                return [
                    "met": "Leagues",
                    "APIkey": apiKey
                ]
            case .fixtures(_, let leagueId, let from, let to):
                return [
                    "met": "Fixtures",
                    "APIkey": apiKey,
                    "from": from,
                    "to": to,
                    "leagueId": leagueId
                ]
            case .teams(_, leagueId: let leagueId):
                return [
                    "met": "Teams",
                    "APIkey": apiKey,
                    "leagueId": leagueId
                ]
            case .tennisPlayers(_, leagueId: let leagueId):
                return [
                    "met": "Players",
                    "APIkey": apiKey,
                    "leagueId": leagueId
                ]
            case .teamDetails(_, let teamId):
                       return [
                           "met": "Teams",
                           "APIkey": apiKey,
                           "teamId": teamId
                       ]
            }
        }
}


