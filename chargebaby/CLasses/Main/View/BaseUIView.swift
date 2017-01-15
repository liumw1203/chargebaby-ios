//
//  BaseUIView.swift
//  chargebaby
//
//  Created by 刘明伟 on 2016/12/31.
//  Copyright © 2016年 刘明伟. All rights reserved.
//

import UIKit

class BaseUIView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
extension UIView {
    class func loadFromNibNamed(_ nibName:String,bundle : Bundle? = nil) -> UIView? {
        return UINib(nibName: nibName, bundle: bundle).instantiate(withOwner: nil, options: nil)[0] as? UIView
    }
}
