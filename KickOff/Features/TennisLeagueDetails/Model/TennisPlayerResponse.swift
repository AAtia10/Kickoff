import Foundation

struct TennisPlayerResponse: Codable {
    let success: Int
    let result: [TennisPlayer]?
}

struct TennisPlayer: Codable {
    let playerKey: Int
    let playerName: String
    let playerCountry: String?
    let playerBirthday: String?
    let playerLogo: String?

    enum CodingKeys: String, CodingKey {
        case playerKey = "player_key"
        case playerName = "player_name"
        case playerCountry = "player_country"
        case playerBirthday = "player_bday"
        case playerLogo = "player_logo"
    }
}
