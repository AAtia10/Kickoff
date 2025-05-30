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
}

