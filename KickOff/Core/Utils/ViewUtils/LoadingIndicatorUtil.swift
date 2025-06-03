import UIKit

class LoadingIndicatorUtil {

    static let shared = LoadingIndicatorUtil()
    private var indicator = UIActivityIndicatorView(style: .large)

    private init() {
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
    }

    func show(on parent: UIView) {
        if indicator.superview == nil {
            parent.addSubview(indicator)

            NSLayoutConstraint.activate([
                indicator.centerXAnchor.constraint(equalTo: parent.centerXAnchor),
                indicator.centerYAnchor.constraint(equalTo: parent.centerYAnchor)
            ])
        }

        indicator.startAnimating()
    }

    func hide() {
        indicator.stopAnimating()
        indicator.removeFromSuperview()
    }
}
