//
//  NetworkMockTests.swift
//  KickOffTests
//
//  Created by Abdelrahman on 04/06/2025.
//

import XCTest
@testable import KickOff

final class NetworkMockTests: XCTestCase {
    
    var fakeRemoteDataSource : FakeRemoteDataSource?

    override func setUpWithError() throws {
        NetworkManager.isInternetAvailable{
            flag in
            self.fakeRemoteDataSource = FakeRemoteDataSource(shouldReturnError: flag)
        }
    }

    override func tearDownWithError() throws {
        fakeRemoteDataSource = nil
    }
    
    
    func testGetLeaguesFailure(){
        fakeRemoteDataSource?.getAllLeagues(for: .football){
            leagues , error in
            if let error = error {
                XCTAssertNil(leagues)
                print("error")
            }
            else{
                XCTAssertNotNil(leagues)
                print("success")
            }
            
        }
    }

}
