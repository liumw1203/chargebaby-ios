//
//  LMWChargeModel.swift
//  chargebaby
//
//  Created by 刘明伟 on 2017/1/3.
//  Copyright © 2017年 刘明伟. All rights reserved.
//

import Foundation
import HandyJSON

class Charge: HandyJSON {
    //id
    var id: Int64?
    //创建时间
    var create_time:Date?
    //修改时间
    var update_time:Date?
    //编码
    var charge_no:String?
    //充电点名称
    var name:String?
    //区域
    var area:String?
    
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
    // 经度
    var longitude:Double?
    //维度
    var latitude:Double?
    //开放时间
    var begin_time:String?
    // 服务电话
    var tel:String?
    //使用标准名称
    var standard_name:String?
    //收费标准
    var fee_standard:String?
    /**详情*/
    var detail:String?
    /**建设单位*/
    var depart:String?
    
    required init() {}

}
