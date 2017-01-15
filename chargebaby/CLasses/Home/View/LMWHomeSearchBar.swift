//
//  LMWHomeSearchBar.swift
//  chargebaby
//
//  Created by 刘明伟 on 2017/1/2.
//  Copyright © 2017年 刘明伟. All rights reserved.
//

import UIKit

class LMWHomeSearchBar: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override init(frame: CGRect) {
        super.init(frame: frame)
//        backgroundColor = UIColor.orange
        addSubview(searchBar)
        
        searchBar.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: SCREENW - 60, height: 30))
            make.center.equalTo(self)
        }
    }
    
    lazy var searchBar: LMWSearchBar = {
        let searchBar = LMWSearchBar()
        searchBar.placeholder = "输入区域、充电点"
        searchBar.isEnabled = false
//        searchBar.isEditing = false
        return searchBar
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}



class LMWSearchBar: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        layer.cornerRadius = kCornerRadius
        layer.masksToBounds = true
        let searchIcon = UIImageView(frame: CGRect(x:0, y:0, width:16, height:16))
        font = UIFont.systemFont(ofSize: 15)
        searchIcon.image = UIImage(named: "search_discover_16x16")
//        searchIcon.image.f
//        searchIcon.frame.width = 16.0
//        searchIcon.frame.height = 16.0
        leftView = searchIcon
        leftViewMode = UITextFieldViewMode.always
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
