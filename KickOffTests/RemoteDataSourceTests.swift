//
//  KickOffTests.swift
//  KickOffTests
//
//  Created by Abdelrahman Atia on 29/05/2025.
//

import XCTest
@testable import KickOff

final class RemoteDataSourceTests: XCTestCase {
    
    var remoteDataSource : RemoteDataSource?

    override func setUpWithError() throws {
        remoteDataSource = RemoteDataSource.shared
    }

    override func tearDownWithError() throws {
        remoteDataSource = nil
    }
    
    func testGetAlllLeagues(){
        let exp = expectation(description: "Waiting for calling api")
        remoteDataSource?.getAllLeagues(for: .football){ result in
            
            switch result{
            case .success(let leagues):
                XCTAssertNotNil(leagues)
                XCTAssertFalse(leagues.isEmpty)
            case .failure(let error):
                XCTFail("error \(error.localizedDescription)")
            }
            exp.fulfill()
        }
        waitForExpectations(timeout: 10)
    }
    
    func testGetTeamDetails(){
        let exp = expectation(description: "Waiting for calling api")
        remoteDataSource?.getTeamDetails(for: .football, teamId: 102){
            result in
            switch result{
            case .success(let data):
                XCTAssertNotNil(data)
                XCTAssertFalse(data.isEmpty)
            case .failure(let error):
                XCTFail("error \(error.localizedDescription)")
            }
            exp.fulfill()
        }
        waitForExpectations(timeout: 10)
    }
    
    func testGetTeamsOfleagues(){
        let exp = expectation(description: "Waiting for calling api")
        remoteDataSource?.getTeamsOfLeague(sport: .football, leagueId:3){
            result in
            switch result{
            case .success(let data):
                XCTAssertNotNil(data)
                XCTAssertFalse(data.isEmpty)
            case .failure(let error):
                XCTFail("error \(error.localizedDescription)")
            }
            exp.fulfill()
        }
        waitForExpectations(timeout: 10)
    }
    
    func testGetFixtures(){
        let exp = expectation(description: "Waiting for calling api")
        remoteDataSource?.requestFixtures(sport: .football,
                                          leagueId: 3, from: "2025-04-30", to: "2025-05-30"){
            result in
            switch result{
            case .success(let matches):
                XCTAssertNotNil(matches)
                XCTAssertFalse(matches.isEmpty)
            case .failure(let error):
                XCTFail("error \(error.localizedDescription)")
            }
            exp.fulfill()
        }
        waitForExpectations(timeout: 10)
    }
    
    func testGetTennisFixtures(){
        let exp = expectation(description: "Waiting for calling api")
        remoteDataSource?.requestTennisFixtures(sport: .tennis,
                                          leagueId: 12417, from: "2025-03-10", to: "2025-05-30"){
            result in
            switch result{
            case .success(let matches):
                XCTAssertNotNil(matches)
                XCTAssertFalse(matches.isEmpty)
            case .failure(let error):
                XCTFail("error \(error.localizedDescription)")
            }
            exp.fulfill()
        }
        waitForExpectations(timeout: 10)
    }
    
    func testGetTennisPlayersOfLeagues(){
        let exp = expectation(description: "Waiting for calling api")
        remoteDataSource?.getTennisPlayersOfLeague(leagueId: 12417){
            result in
            switch result{
            case .success(let data):
                XCTAssertNotNil(data)
                XCTAssertFalse(data.isEmpty)
            case .failure(let error):
                XCTFail("error \(error.localizedDescription)")
            }
            exp.fulfill()
        }
        waitForExpectations(timeout: 10)
    }

}
