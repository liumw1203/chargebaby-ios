//
//  LMWJsonModel.swift
//  chargebaby
//
//  Created by 刘明伟 on 2016/12/4.
//  Copyright © 2016年 刘明伟. All rights reserved.
//

import Foundation
import HandyJSON

class JsonUserInfo: HandyJSON {
    /**返回码*/
    var result_code: String?
    /**是否成功*/
    var success: Bool?
    /**返回信息*/
    var msg: String?
    /**返回对象*/
    var obj: UserInfo?
    
    required init() {}

}

class JsonFeedback: HandyJSON {
    /**返回码*/
    var result_code: String?
    /**是否成功*/
    var success: Bool?
    /**返回信息*/
    var msg: String?
    /**返回对象*/
    var obj: Feedback?
    
    required init() {}
}

class JsonResult: HandyJSON {
    /**返回码*/
    var result_code: String?
    /**是否成功*/
    var success: Bool?
    /**返回信息*/
    var msg: String?
    
    
    required init() {}
}


class JsonComment: HandyJSON {
    /**返回码*/
    var result_code: String?
    /**是否成功*/
    var success: Bool?
    /**返回信息*/
    var msg: String?
    /**返回对象*/
    var obj: [Comment]?
    
    required init() {}
}

class JsonFavorite: HandyJSON {
    /**返回码*/
    var result_code: String?
    /**是否成功*/
    var success: Bool?
    /**返回信息*/
    var msg: String?
    /**返回对象*/
    var obj: [Favorite]?
    
    required init() {}
}


