import Foundation
import Alamofire

class RemoteDataSource {
    
    static let shared = RemoteDataSource()

    private init() {}
    
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
}

