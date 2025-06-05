//
//  TeamCell.swift
//  KickOff
//
//  Created by Abdelrahman on 30/05/2025.
//

import UIKit

class TeamCell: UICollectionViewCell {

    @IBOutlet weak var teamLabel: UILabel!
    @IBOutlet weak var teamImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setupCardStyle() {
        layer.cornerRadius = 16
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemGray4.cgColor

        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 6
        layer.masksToBounds = false
        
        
    }

}
