import Foundation

struct TennisMatchResponse: Codable {
    let success: Int
    let result: [TennisMatch]?
}

struct TennisMatch: Codable {
    let eventKey: Int?
    let eventDate: String?
    let eventTime: String?
    let eventFirstPlayer: String?
    let firstPlayerKey: Int?
    let eventSecondPlayer: String?
    let secondPlayerKey: Int?
    let eventFinalResult: String?
    let eventWinner: String?
    let eventStatus: String?
    let countryName: String?
    let leagueName: String?
    let leagueKey: Int?
    let leagueRound: String?
    let leagueSeason: String?
    let eventLive: String?
    let eventFirstPlayerLogo: String?
    let eventSecondPlayerLogo: String?
    let scores: [Score]?
    
    enum CodingKeys: String, CodingKey {
        case eventKey = "event_key"
        case eventDate = "event_date"
        case eventTime = "event_time"
        case eventFirstPlayer = "event_first_player"
        case firstPlayerKey = "first_player_key"
        case eventSecondPlayer = "event_second_player"
        case secondPlayerKey = "second_player_key"
        case eventFinalResult = "event_final_result"
        case eventWinner = "event_winner"
        case eventStatus = "event_status"
        case countryName = "country_name"
        case leagueName = "league_name"
        case leagueKey = "league_key"
        case leagueRound = "league_round"
        case leagueSeason = "league_season"
        case eventLive = "event_live"
        case eventFirstPlayerLogo = "event_first_player_logo"
        case eventSecondPlayerLogo = "event_second_player_logo"
        case scores
    }
}

struct Score: Codable {
    let scoreFirst: String
    let scoreSecond: String
    let scoreSet: String
    
    enum CodingKeys: String, CodingKey {
        case scoreFirst = "score_first"
        case scoreSecond = "score_second"
        case scoreSet = "score_set"
    }
}

