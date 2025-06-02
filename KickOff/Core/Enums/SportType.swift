import Foundation

import UIKit

enum SportType: String, CaseIterable,Decodable {
    case football
    case tennis
    case basketball
    case cricket

    var image: UIImage? {
        switch self {
        case .football:
            return UIImage(named: "baggio")
        case .tennis:
            return UIImage(named: "tennis")
        case .basketball:
            return UIImage(named: "basketball")
        case .cricket:
            return UIImage(named: "cricket")
        }
    }

    var displayName: String {
        return self.rawValue.capitalized
    }
}
