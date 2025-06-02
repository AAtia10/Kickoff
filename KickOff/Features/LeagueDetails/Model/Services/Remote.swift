import Foundation
import Alamofire

extension RemoteDataSource {
    

   
    
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
    
    
}


