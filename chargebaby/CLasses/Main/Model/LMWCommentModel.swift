//
//  LMWCommentModel.swift
//  chargebaby
//
//  Created by 刘明伟 on 2017/1/3.
//  Copyright © 2017年 刘明伟. All rights reserved.
//

import Foundation
import HandyJSON

class Comment: HandyJSON {
    var id:Int64?
    /**头像*/
    var portraitId:Int64?
    /**创建时间*/
    var createTime:String?
    /**修改时间*/
    var updateTime:String?
    /**评论内容*/
    var info:String?
    /**作者用户名*/
    var author:String?
    /**作者ID*/
    var authorId:Int64?
    /**充电桩编码*/
    var chargeNo:String?
    /**回复数量，针对本条评论的回复数,当为null时，即为给评论的回复*/
    var replyNum:Int?
    
    /**回复列表*/
    var replyVoList:[String]?
    
   
    
//    required init(author:String, info:String, createTime:Date){
//        self.author = author
//        self.info = info
//        self.createTime = createTime
//    }

    required init(){}
}
