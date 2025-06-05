//
//  HomeCollectionViewCell.swift
//  KickOff
//
//  Created by Abdelrahman Atia on 30/05/2025.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var sportLabrl: UILabel!
    @IBOutlet weak var sportsImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCardStyle()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if previousTraitCollection?.userInterfaceStyle != traitCollection.userInterfaceStyle {
            setupCardStyle()
        }
    }

        
    func setupCardStyle() {
        
        contentView.layer.cornerRadius = 16
        contentView.layer.masksToBounds = true
        
        
        layer.cornerRadius = 16
        
        if traitCollection.userInterfaceStyle == .dark {
            layer.shadowColor = UIColor.white.cgColor
        } else {
            layer.shadowColor = UIColor.black.cgColor
        }
        
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 8
        layer.masksToBounds = false
        
        
    }


}
