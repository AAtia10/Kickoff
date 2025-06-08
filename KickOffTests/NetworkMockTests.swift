import XCTest
@testable import KickOff

final class NetworkMockTests: XCTestCase {

    func testGetLeaguesSuccess() {
        let fakeRemoteDataSource = FakeRemoteDataSource(shouldReturnError: false)
        let expectation = self.expectation(description: "Should return leagues")

        fakeRemoteDataSource.getAllLeagues(for: .football) { leagues, error in
            XCTAssertNil(error)
            XCTAssertNotNil(leagues)
            XCTAssertEqual(leagues?.count, 1)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 2)
    }

    func testGetLeaguesFailure() {
        let fakeRemoteDataSource = FakeRemoteDataSource(shouldReturnError: true)
        let expectation = self.expectation(description: "Should return error")
        fakeRemoteDataSource.getAllLeagues(for: .football) { leagues, error in
            // Then
            XCTAssertNotNil(error)
            XCTAssertNil(leagues)
            XCTAssertEqual(error, NetworkError.ResponseError)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 2)
    }
}
