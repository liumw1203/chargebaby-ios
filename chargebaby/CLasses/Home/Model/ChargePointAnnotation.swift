//
//  ChargePointAnnotation.swift
//  chargebaby
//
//  Created by 刘明伟 on 2016/12/28.
//  Copyright © 2016年 刘明伟. All rights reserved.
//

import UIKit

class ChargePointAnnotation: MAPointAnnotation {

    /**charge中的数据*/
    //编码
    var charge_no:String?
    //充电点名称
    var name:String?
    //地址
    var address:String?
    //价格
    var price:String?
    /**交流电已建数量*/
    var ac_builded:Int?
    
    /**交流电在建数量*/
    var ac_building:Int?
    
    /**直流电已建数量*/
    var dc_builded:Int?
    
    /**直流电在建数量*/
    var dc_building:Int?
    
    
    //距离
    var distance:Double?
}
