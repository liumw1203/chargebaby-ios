//
//  LMWChargeDetailView.swift
//  chargebaby
//
//  Created by 刘明伟 on 2016/12/30.
//  Copyright © 2016年 刘明伟. All rights reserved.
//

import UIKit




@objc protocol LMWChargeDetailViewDelegate{
   
    
    //导航
    @objc optional func nav(name:String, latitude:Double, longitude:Double)
    
   }

class LMWChargeDetailView: BaseUIView {
    
    var delegate:LMWChargeDetailViewDelegate?

    
    
    //充电点名称
    var name:String?
    //经度
    var longitude:Double?
    //纬度
    var latitude:Double?
    
    
    @IBOutlet weak var chargeNavView: UIView!
    @IBOutlet weak var chargeDetailView: UIView!
   
    @IBOutlet weak var chargeACBuildedTF: UITextField!
    @IBOutlet weak var chargeACBuildingTF: UITextField!
    
    @IBOutlet weak var chargeDCBuildedTF: UITextField!
    @IBOutlet weak var chargeDCBuildingTF: UITextField!
   
    @IBOutlet weak var chargeBeginTimeLabel: UILabel!
    @IBOutlet weak var chargeStandardNameLabel: UILabel!
    @IBOutlet weak var chargeTelLabel: UILabel!
    @IBOutlet weak var chargeFeeStandardLabel: UILabel!
    @IBOutlet weak var chargeDetailLabel: UILabel!
    @IBOutlet weak var chargeDepartLabel: UILabel!
    
    
    
    
    

}



