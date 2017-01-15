//
//  BottomView.swift
//  PopView
//
//  Created by chengfeiheng on 16/3/28.
//  Copyright © 2016年 chengfeisoft. All rights reserved.
//

import UIKit

//extension UIView {
//    class func loadFromNibNamed(_ nibName:String,bundle : Bundle? = nil) -> UIView? {
//        return UINib(nibName: nibName, bundle: bundle).instantiate(withOwner: nil, options: nil)[0] as? UIView
//    }
//}

class BottomView: BaseUIView {
    // 详情按钮
    @IBOutlet weak var chargeDetailView: UIStackView!
    //点评按钮

    @IBOutlet weak var dianpingView: UIStackView!
    
    //导航按钮
    @IBOutlet weak var navView: UIView!

    
   
    @IBOutlet weak var myFavoriteView: UIView!
    @IBOutlet weak var chargeNameTF: UITextField!
    
    @IBOutlet weak var myFavoriteIV: UIImageView!
    
    
    @IBOutlet weak var chargePriceTF: UITextField!
    
    @IBOutlet weak var chargeAddressTV: UITextView!
    
    @IBOutlet weak var chargeACTF: UITextField!
    
    @IBOutlet weak var chargeDCTF: UITextField!
   
   
}
