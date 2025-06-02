//
//  TeamCell.swift
//  KickOff
//
//  Created by Abdelrahman on 30/05/2025.
//

import UIKit

class TeamCell: UICollectionViewCell {

    @IBOutlet weak var container: UIView!
    @IBOutlet weak var teamLabel: UILabel!
    @IBOutlet weak var teamImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setupCardStyle() {
        container.layer.cornerRadius = 12
        container.layer.borderWidth = 1
        container.layer.borderColor = UIColor.systemGray4.cgColor

        container.layer.shadowColor = UIColor.black.cgColor
        container.layer.shadowOpacity = 0.2
        container.layer.shadowOffset = CGSize(width: 0, height: 2)
        container.layer.shadowRadius = 4
        container.layer.masksToBounds = false
    }

}
