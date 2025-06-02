//
//  LocalLeague.swift
//  KickOff
//
//  Created by Abdelrahman Atia on 02/06/2025.
//

import Foundation

struct LocalLeague: Decodable {
    let league_key: Int
    let league_name: String
    let league_logo: String?
    let isFav: Bool
    let sport: SportType
}


extension LocalLeague {
    init(fromLeague league: League, sport: SportType, isFav: Bool = true) {
        self.league_key = league.league_key
        self.league_name = league.league_name
        self.league_logo = league.league_logo ?? ""
        self.isFav = isFav
        self.sport = sport
    }
}
