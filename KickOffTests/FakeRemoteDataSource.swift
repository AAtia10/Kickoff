//
//  FakeRemoteDataSource.swift
//  KickOffTests
//
//  Created by Abdelrahman on 04/06/2025.
//

import Foundation

@testable import KickOff

enum NetworkError : Error {
case ResponseError
}

class FakeRemoteDataSource{
    
    var shouldReturnError : Bool
    
    init(shouldReturnError: Bool) {
        self.shouldReturnError = shouldReturnError
    }
    
    func getAllLeagues(for sport: SportType, completion: @escaping ([League]?, NetworkError?) -> Void) {
       
        if shouldReturnError {
            completion(nil , .ResponseError)
        }
        else{
            let leauges = [League(league_key: 0, league_name: "", league_logo: "")]
            completion(leauges , nil)
        }
    }
    
    
    
    
}
