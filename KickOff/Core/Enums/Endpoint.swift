import Foundation

enum Endpoint {
    case leagues(sport: SportType)


    private var baseURL: String {
        return "https://apiv2.allsportsapi.com/"
    }
    
    private var apiKey: String {
        return "951a4e5ff5f0c33a22aa28695ab0ad3ae1e1b8a3343073217ecbbdc9d1962dc6"
    }

    private var path: String {
        switch self {
        case .leagues(let sport):
            return "\(sport.rawValue)?met=Leagues"
        }
    }

    var url: String {
        return "\(baseURL)\(path)&APIkey=\(apiKey)"
    }

}

