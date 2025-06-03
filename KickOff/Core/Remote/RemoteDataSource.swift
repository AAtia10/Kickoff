import Foundation
import Alamofire

class RemoteDataSource {
    
    static let shared = RemoteDataSource()

    private init() {}
    
    func getAllLeagues(for sport: SportType, completion: @escaping (Result<[League], Error>) -> Void) {
        
        let endpoint = Endpoint.leagues(sport: sport)
        AF.request(endpoint.url, parameters: endpoint.parameters)
            .validate()
            .responseDecodable(of: LeaguesResponse.self) {
                response in
                switch response.result {
                    case .success(let data):
                        completion(.success(data.result))
                    case .failure(let error):
                        completion(.failure(error))
                    }
            }
    }
    
    func requestFixtures(
        sport: SportType,
        leagueId: Int,
        from: String,
        to: String,
        completion: @escaping (Result<[Match], Error>) -> Void
    ) {
        let endpoint = Endpoint.fixtures(sport: sport, leagueId: leagueId, from: from, to: to)

        AF.request(endpoint.url, parameters: endpoint.parameters)
            .validate()
            .responseDecodable(of: MatchesResponse.self) { response in
                switch response.result {
                case .success(let data):
                    completion(.success(data.result ?? []))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func getTeamsOfLeague(
        sport: SportType,
        leagueId: Int,
        completion: @escaping (Result<[Team], Error>) -> Void
    ) {
        let endpoint = Endpoint.teams(sport: sport, leagueId: leagueId)

        AF.request(endpoint.url, parameters: endpoint.parameters)
            .validate()
            .responseDecodable(of: TeamsResponse.self) { response in
                switch response.result {
                case .success(let data):
                    completion(.success(data.result ?? []))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func getTeamDetails(for sport: SportType, teamId: Int, completion: @escaping (Result<[Team], Error>) -> Void) {
        
        let endpoint = Endpoint.teamDetails(sport: sport, teamId: teamId)
        
        AF.request(endpoint.url, parameters: endpoint.parameters)
            .validate()
            .responseDecodable(of: TeamsResponse.self) { response in
                switch response.result {
                case .success(let data):
                    if let teams = data.result {
                        completion(.success(teams))
                    } else {
                        completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No team data found."])))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func requestTennisFixtures(
        sport: SportType,
        leagueId: Int,
        from: String,
        to: String,
        completion: @escaping (Result<[TennisMatch], Error>) -> Void
    ) {
        let endpoint = Endpoint.fixtures(sport: sport, leagueId: leagueId, from: from, to: to)

        AF.request(endpoint.url, parameters: endpoint.parameters)
            .validate()
            .responseDecodable(of: TennisMatchResponse.self) { response in
                                
                switch response.result {
                case .success(let data):
                    completion(.success(data.result ?? []))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func getTennisPlayersOfLeague(
        leagueId: Int,
        completion: @escaping (Result<[TennisPlayer], Error>) -> Void
    ) {
        let endpoint = Endpoint.tennisPlayers(leagueId: leagueId)

        AF.request(endpoint.url, parameters: endpoint.parameters)
            .validate()
            .responseDecodable(of: TennisPlayerResponse.self) { response in
                switch response.result {
                case .success(let data):
                    completion(.success(data.result ?? []))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }

    
}

