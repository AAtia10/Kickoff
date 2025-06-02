import Foundation

struct League: Decodable {
    let league_key: Int
    let league_name: String
    let country_key: Int?
    let country_name: String?
    let league_logo: String?
    let country_logo: String?
    let league_surface: String?
    let league_year: String?
    
    init(league_key: Int, league_name: String, league_logo: String?) {
        self.league_key = league_key
        self.league_name = league_name
        self.country_key = 0
        self.country_name = ""
        self.league_logo = league_logo
        self.country_logo = ""
        self.league_surface = ""
        self.league_year = ""
    }
}
