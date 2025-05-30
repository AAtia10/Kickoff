//
//  LeaguesTableViewCell.swift
//  KickOff
//
//  Created by Abdelrahman Atia on 30/05/2025.
//

import UIKit

class LeaguesTableViewCell: UITableViewCell {

    @IBOutlet weak var leagueName: UILabel!
    @IBOutlet weak var leagueImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 16
        self.clipsToBounds = true
        
        leagueImage.layer.cornerRadius =  leagueImage.frame.size.width / 2
        leagueImage.clipsToBounds = true
       
    
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
