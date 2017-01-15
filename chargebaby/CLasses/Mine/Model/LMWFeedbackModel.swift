//
//  LMWFeedbackModel.swift
//  chargebaby
//
//  Created by 刘明伟 on 2016/12/13.
//  Copyright © 2016年 刘明伟. All rights reserved.
//

import Foundation
import HandyJSON

class Feedback: HandyJSON {
    var id: Int64?
    /**创建时间*/
    var createTime: String?
    /**用户名*/
    var username: String? = "匿名"
    /**内容*/
    var info: String?
    
    required init() {}
}
