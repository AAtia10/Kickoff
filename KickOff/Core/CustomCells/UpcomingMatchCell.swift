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
        // Remove previous gradient to avoid duplicates when reloading
        gradientLayer.removeFromSuperlayer()
        
        // Setup gradient colors depending on user interface style
        if traitCollection.userInterfaceStyle == .dark {
            // Dark mode gradient - dark blue to dark teal
            gradientLayer.colors = [
                UIColor(red: 0x00/255, green: 0x4e/255, blue: 0x92/255, alpha: 1).cgColor,  // #004e92
                UIColor(red: 0x00/255, green: 0x69/255, blue: 0x7a/255, alpha: 1).cgColor   // #00697a
            ]
            
            // White text for all labels
            let whiteColor = UIColor.white
            dateLabel.textColor = whiteColor
            awayResultLabel.textColor = whiteColor
            homeResultLabel.textColor = whiteColor
            awayLabel.textColor = whiteColor
            homeLabel.textColor = whiteColor
            
            // Shadow color lighter for dark backgrounds
            layer.shadowColor = UIColor(white: 1, alpha: 0.3).cgColor
            layer.shadowOpacity = 0.5
        } else {
            // Light mode gradient - soft mint to white
            gradientLayer.colors = [
                UIColor(red: 225/255, green: 255/255, blue: 245/255, alpha: 1).cgColor,  // #e1fff5
                UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1).cgColor   // #ffffff
            ]
            
            // Black text for all labels
            let blackColor = UIColor.black
            dateLabel.textColor = blackColor
            awayResultLabel.textColor = blackColor
            homeResultLabel.textColor = blackColor
            awayLabel.textColor = blackColor
            homeLabel.textColor = blackColor
            
            // Shadow color darker for light backgrounds
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOpacity = 0.2
        }
        
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.cornerRadius = 16

        if gradientLayer.superlayer == nil {
            contentView.layer.insertSublayer(gradientLayer, at: 0)
        }

        contentView.layer.cornerRadius = 16
        contentView.layer.masksToBounds = true

        layer.cornerRadius = 16
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 8
        layer.masksToBounds = false
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if previousTraitCollection?.userInterfaceStyle != traitCollection.userInterfaceStyle {
            setupCardStyle()
        }
    }




}
