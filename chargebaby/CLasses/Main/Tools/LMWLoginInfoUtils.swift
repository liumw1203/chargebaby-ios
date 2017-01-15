//
//  LMWLoginInfoUtils.swift
//  chargebaby
//
//  Created by 刘明伟 on 2016/12/4.
//  Copyright © 2016年 刘明伟. All rights reserved.
//

import Foundation
import HandyJSON

class LMWLoginInfoUtils: NSObject {
    
    //单例
    static let shareLoginInfoUtils = LMWLoginInfoUtils()
    
    
    /**
     * 获取登录信息
     * @param context
     * @return
     */
    func getLoginInfo(){
        let userDefaults = UserDefaults.standard
        let userInfoStr = userDefaults.string(forKey: LONIN_INFO)
        if (userInfoStr != nil) {
            
            LMWGlobalUserInfo = JSONDeserializer<UserInfo>.deserializeFrom(json: userInfoStr)
            LMWGlobalIsLogin = true
        }else{
            LMWGlobalIsLogin = false
        }
    }
    
    
    /**
     * 设置登录信息
     * @param context
     * @param value
     * @return
     */
    func setLoginInfo(userInfoStr: String){
        let userDefaults = UserDefaults.standard
        userDefaults.set(userInfoStr, forKey: LONIN_INFO)
//        userDefaults.set(true, forKey: IS_LOGIN)
        
        userDefaults.synchronize()
    }
    
    
    /**
     * 移除登录信息
     * @param context
     * @return
     */
    func removeLoginInfo() -> Bool? {
        let userDefaults = UserDefaults.standard
        userDefaults.removeObject(forKey: LONIN_INFO)
//        userDefaults.set(false, forKey: IS_LOGIN)
        
        let userInfo = userDefaults.string(forKey: LONIN_INFO)
        if userInfo == nil{
            
            return true
        }else{
            return false
        }
        
    }
    
    /**
     * 移除登录信息
     * @param context
     * @return
     */
    func updateLoginInfo(userInfoStr: String) {
        
        let userDefaults = UserDefaults.standard
        
        userDefaults.removeObject(forKey: LONIN_INFO)
        userDefaults.set(userInfoStr, forKey: LONIN_INFO)
        //        userDefaults.set(true, forKey: IS_LOGIN)
        
        userDefaults.synchronize()
    }
    
    
    
}
