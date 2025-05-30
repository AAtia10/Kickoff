import Foundation

import UIKit

enum SportType: String, CaseIterable {
    case football
    case tennis
    case basketball
    case cricket

    var image: UIImage? {
        switch self {
        case .football:
            return UIImage(systemName: "soccerball.inverse")
        case .tennis:
            return UIImage(systemName: "tennis.racket")
        case .basketball:
            return UIImage(systemName: "basketball")
        case .cricket:
            return UIImage(systemName: "cricket.ball")
        }
    }

    var displayName: String {
        return self.rawValue.capitalized
    }
}
