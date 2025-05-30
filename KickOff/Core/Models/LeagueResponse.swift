import Foundation

struct LeaguesResponse: Decodable {
    let success: Int
    let result: [League]
}

