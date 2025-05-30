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
            return UIImage(named: "1")
        case .tennis:
            return UIImage(named: "1")
        case .basketball:
            return UIImage(named: "1")
        case .cricket:
            return UIImage(named: "1")
        }
    }

    var displayName: String {
        return self.rawValue.capitalized
    }
}
