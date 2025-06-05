//
//  EmptyCell.swift
//  KickOff
//
//  Created by Abdelrahman on 04/06/2025.
//

import UIKit

class EmptyCell: UICollectionViewCell {

    @IBOutlet weak var Mylabel: UILabel!
    @IBOutlet weak var myImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        Mylabel.text = NSLocalizedString("no", comment: "")
        // Initialization code
    }
}
