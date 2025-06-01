//
//  RemoteData.swift
//  KickOff
//
//  Created by Abdelrahman Atia on 01/06/2025.
//

import Foundation
import Alamofire

extension RemoteDataSource {
    
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

    
    
}
