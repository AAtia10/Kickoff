//
//  CricketGameCell.swift
//  KickOff
//
//  Created by Abdelrahman on 02/06/2025.
//

import UIKit

class CricketGameCell: UICollectionViewCell {

    @IBOutlet weak var awayName: UILabel!
    @IBOutlet weak var homeName: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var awayResult: UILabel!
    @IBOutlet weak var homeResult: UILabel!
    @IBOutlet weak var awayImageView: UIImageView!
    @IBOutlet weak var homeImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
