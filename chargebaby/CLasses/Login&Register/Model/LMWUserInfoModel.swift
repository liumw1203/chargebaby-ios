//
//  LMWUserInfoModel.swift
//  chargebaby
//
//  Created by 刘明伟 on 2016/12/4.
//  Copyright © 2016年 刘明伟. All rights reserved.
//

import Foundation
import HandyJSON

class UserInfo: HandyJSON {
    var id: Int64?
    /**创建时间*/
    var createTime: String?
    /**修改时间*/
    var updateTime: String?
    /**用户名*/
    var username: String?
    /**真实姓名*/
    var realName: String?
    /**手机*/
    var phone: String?
    /**email*/
    var email: String?
    /**头像*/
    var headUrl: String?
    /**收藏列表*/
    //    List<Favorite> favoriteList = new ArrayList<Favorite>();
    var favoriteList : Array<Favorite>?

    required init() {}
    
    
}
