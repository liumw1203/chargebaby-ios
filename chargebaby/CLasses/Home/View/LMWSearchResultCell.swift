//
//  LMWSearchResultCell.swift
//  chargebaby
//
//  Created by 刘明伟 on 2017/1/3.
//  Copyright © 2017年 刘明伟. All rights reserved.
//

import UIKit

class LMWSearchResultCell: UITableViewCell {

    
    @IBOutlet weak var chargeAddressLabel: UILabel!
    @IBOutlet weak var chargeNameLabel: UILabel!
    @IBOutlet weak var chargeAreaLabel: UILabel!
    
    @IBOutlet weak var chargeDetailLabel: UILabel!
    var charge_no:String!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(for searchResult: Charge) {
        chargeNameLabel.text = searchResult.name
        chargeAreaLabel.text = searchResult.area
        chargeAddressLabel.text = searchResult.address
        chargeDetailLabel.text = searchResult.detail
        
        
        
    }
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//        // 设置cell被点中后的背景颜色
//        let selectedView = UIView(frame: CGRect.zero)
//        selectedView.backgroundColor = UIColor(red: 20/255, green: 160/255, blue: 160/255, alpha: 0.5)
//        selectedBackgroundView = selectedView
//    }

}
