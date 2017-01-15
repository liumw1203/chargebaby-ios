//
//  commentCell.swift
//  chargebaby
//
//  Created by 刘明伟 on 2017/1/5.
//  Copyright © 2017年 刘明伟. All rights reserved.
//

import UIKit

class commentCell: UITableViewCell {
    @IBOutlet weak var authouLabel: UILabel!

    @IBOutlet weak var createTimeLabel: UILabel!
 
    @IBOutlet weak var infoLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
