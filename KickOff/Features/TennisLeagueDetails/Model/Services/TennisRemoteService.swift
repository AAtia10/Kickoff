//
//  TennisRemoteService.swift
//  KickOff
//
//  Created by Abdelrahman on 31/05/2025.
//

import Foundation

import Foundation
import Alamofire

extension RemoteDataSource {
    
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



