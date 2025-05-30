import Foundation

struct Match: Decodable {
    
    let event_key: Int
    let event_date: String
    let event_time: String
    
    let event_home_team: String
    let home_team_key: Int
    let home_team_logo: String?
    
    let event_away_team: String
    let away_team_key: Int
    let away_team_logo: String?
    
    let event_final_result: String?
    let event_halftime_result: String?
    let event_penalty_result: String?
    
    let event_status: String
    
    let country_name: String?
    let country_logo: String?
    
    let league_name: String?
    let league_key: Int?
    let league_logo: String?
}
