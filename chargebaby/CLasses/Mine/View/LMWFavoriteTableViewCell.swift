//
//  LMWFavoriteTableViewCell.swift
//  chargebaby
//
//  Created by 刘明伟 on 2017/1/2.
//  Copyright © 2017年 刘明伟. All rights reserved.
//

import UIKit

class LMWFavoriteTableViewCell: UITableViewCell {

    
    @IBOutlet weak var chargeNameLabel: UILabel!
    

    @IBOutlet weak var chargeAreaLabel: UILabel!

 
    @IBOutlet weak var chargeAddressLabel: UILabel!
    
    
    var charge_no:String!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configure(for favorite: Favorite) {
        chargeNameLabel.text = favorite.name
        chargeAreaLabel.text = favorite.area
        chargeAddressLabel.text = favorite.address
        charge_no = favorite.chargeNo
    }

}
