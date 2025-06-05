//
//  UpcomingMatchCell.swift
//  KickOff
//
//  Created by Abdelrahman on 30/05/2025.
//

import UIKit

class UpcomingMatchCell: UICollectionViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var awayResultLabel: UILabel!
    @IBOutlet weak var homeResultLabel: UILabel!
    @IBOutlet weak var awayLabel: UILabel!
    @IBOutlet weak var homeLabel: UILabel!
    @IBOutlet weak var awayImageView: UIImageView!
    @IBOutlet weak var homeImageView: UIImageView!
    
    private let gradientLayer = CAGradientLayer()

    
    override func awakeFromNib() {
        super.awakeFromNib()
       setupCardStyle()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = contentView.bounds
    }
    
    func setupCardStyle() {
        gradientLayer.colors = [
            UIColor(white: 0.8, alpha: 1).cgColor,
            UIColor(white: 0.5, alpha: 1).cgColor,
            UIColor(white: 0.2, alpha: 1).cgColor
        ]
        gradientLayer.locations = [0.0, 0.5, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.cornerRadius = 16

        if gradientLayer.superlayer == nil {
            contentView.layer.insertSublayer(gradientLayer, at: 0)
        }

        contentView.layer.cornerRadius = 16
        contentView.layer.masksToBounds = true

        layer.cornerRadius = 16
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 8
        layer.masksToBounds = false
    }


}
