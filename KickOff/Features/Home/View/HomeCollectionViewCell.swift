//
//  HomeCollectionViewCell.swift
//  KickOff
//
//  Created by Abdelrahman Atia on 30/05/2025.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var sportsImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 16
        self.clipsToBounds = true
       
    }

}
