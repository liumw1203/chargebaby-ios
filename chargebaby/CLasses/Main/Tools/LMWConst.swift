//
//  LMWConst.swift
//  chargebaby
//
//  Created by 刘明伟 on 2016/11/10.
//  Copyright © 2016年 刘明伟. All rights reserved.
//

import UIKit

    let SHARE_APPLICATION = UIApplication.shared
    /// 设置全局变量，是否登录
    var LMWGlobalIsLogin:Bool = false
    /// 设置全局变量，登录信息
    var LMWGlobalUserInfo: UserInfo? = nil

    /**startActivityForResult方法使用的requestCode值*/
    /**  登录、注册、忘记密码，requestCode值*/
    var LOGIN_REGISTER_REQUEST_CODE :Int = 1
    /**  登录、注册、忘记密码，resultCode值*/
    var LOGIN_SUCCESS_RESULT_CODE  :Int = 1
    /**  注销，requestCode值*/
    var  SETTING_LOGOUT_REQUEST_CODE :Int = 2
    /** 注销成功，resultCode值*/
    var LOGOUT_SUCCESS_RESULT_CODE :Int = 2
    /************************************************/

    /**高德地图 key*/
    let APIKey = "ef50bd35ca411b2414475e186f021ff3"
    /**bugly appidy*/
    let BUGLY_APPID = "e19d8d675e"
    //shareSDK app key
    let SHARESDK_APPKEY = "1a9fb6876b0c9"

    /**服务器*/
    //let SERVER = "http://192.168.0.102:8080/chargebabyforplat/"
    let SERVER = "http://120.76.194.88:8080/chargebabyforplat/"
    /**远程登录方法接口*/
    let ACTION_LOGIN = "userController/login"
    /**远程注册方法接口*/
    let ACTION_REGIST = "userController/reg"
    /**远程确认修改密码方法接口*/
    let ACTION_CONFIRM = "userController/confirm"
    /**远程提交意见反馈*/
    let ACTION_FEEDBACK_CONFIRM = "feedbackController/feedbackConfirm"
    /**APK版本检测*/
    let ACTION_APK_CHECK = "apkVersion/checkApkVersion";
    /**用户添加收藏*/
    let ACTION_ADD_FAVORITE = "favorite/addFavorite";
    /**用户取消收藏*/
    let ACTION_REMOVE_FAVORITE = "favorite/removeFavorite";
    /**用户添加桩点信息*/
    let ACTION_ADD_COLLECT = "collect/addCollect";
    /**用户添加评论*/
    let ACTION_ADD_COMMENT = "comment/addComment";
    /**用户添加回复*/
    let ACTION_ADD_REPLY = "comment/addReply";
    /**用户获取所有评论*/
    let ACTION_FIND_ALL_COMMENT = "comment/findAllComment";

    /// 第一次启动
    let LMWFirstLaunch = "firstLaunch"


    /**SharedPreferences 登录信息*/
    let LONIN_INFO = "loginInfo"
    let IS_LOGIN = "isLogin"


    let MIN_USERNAME_LENGTH = 1
    let MAX_USERNAME_LENGTH = 15
    let MIN_PASSWORD_LENGTH = 6
    let MAX_PASSWORD_LENGTH = 20

    //
    let SQLITE_DB = SQLiteDB.sharedInstance

    /// 圆角
    let kCornerRadius: CGFloat = 5.0
    /// 屏幕的宽
    let SCREENW = UIScreen.main.bounds.size.width
    /// 屏幕的高
    let SCREENH = UIScreen.main.bounds.size.height

    //收藏图片--白色-未收藏
    let FAVORITE_WHITE_IMG:UIImage = UIImage(named: "my_favorite_write_60*60")!
    //收藏图片--红色--已收藏
    let FAVORITE_RED_IMG:UIImage = UIImage(named: "my_favorite_red_60*60")!

    /// RGBA的颜色设置
    func LMWColor(_ r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor {
        return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
    }

    /// 背景灰色
    func LMWGlobalColor() -> UIColor {
        return LMWColor(245, g: 245, b: 245, a: 1)
    }

    /// 红色
    func LMWGlobalRedColor() -> UIColor {
        return LMWColor(245, g: 80, b: 83, a: 1.0)
    }

