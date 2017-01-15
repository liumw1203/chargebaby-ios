//
//  LMWFavoriteModel.swift
//  chargebaby
//
//  Created by 刘明伟 on 2016/12/5.
//  Copyright © 2016年 刘明伟. All rights reserved.
//

import Foundation
import HandyJSON

class Favorite: HandyJSON {
    var id: Int64?
    /**创建时间*/
    var createTime: String?
    /**修改时间*/
    var updateTime: String?
    /**用户id*/
    var userId: String?
    /**充电桩编码*/
    var chargeNo: String?
    /**充电桩名称*/
    var name: String?
    /**充电桩区域*/
    var area: String?
    /**充电桩地址*/
    var address: String?
    
     required init() {}
}
