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
            return UIImage(named: "football_icon")
        case .tennis:
            return UIImage(named: "tennis_icon")
        case .basketball:
            return UIImage(named: "basketball_icon")
        case .cricket:
            return UIImage(named: "cricket_icon")
        }
    }

    var displayName: String {
        return self.rawValue.capitalized
    }
}
