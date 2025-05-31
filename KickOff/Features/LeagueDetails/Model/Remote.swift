import Foundation
import Alamofire

extension RemoteDataSource {
    func getLastMatches(
        sport: SportType,
        leagueId: Int,
        completion: @escaping (Result<[Match], Error>) -> Void
    ) {
        let fromDate = DateUtils.dateTwoMonthsAgo()
        let toDate = DateUtils.dateYesterday()

        requestFixtures(sport: sport, leagueId: leagueId, from: fromDate, to: toDate, completion: completion)
    }

    func getUpcomingMatches(
        sport: SportType,
        leagueId: Int,
        completion: @escaping (Result<[Match], Error>) -> Void
    ) {
        let fromDate = DateUtils.dateToday()
        let toDate = DateUtils.dateNextMonth()

        requestFixtures(sport: sport, leagueId: leagueId, from: fromDate, to: toDate, completion: completion)
    }

    private func requestFixtures(
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
}


