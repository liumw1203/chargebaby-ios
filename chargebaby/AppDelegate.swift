//
//  AppDelegate.swift
//  chargebaby
//
//  Created by 刘明伟 on 2016/11/10.
//  Copyright © 2016年 刘明伟. All rights reserved.
//

import UIKit
import HandyJSON

@available(iOS 9.0, *)
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    

    func configAPIKey(){
        AMapServices.shared().apiKey = APIKey
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
//        UIApplication.shared.statusBarStyle = UIStatusBarStyle.
        Bugly.start(withAppId: BUGLY_APPID)

        configAPIKey()
        
        UIButton.appearance().isExclusiveTouch = true
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
       
//        let userDefaults = UserDefaults.standard
////        let userInfoStr = userDefaults.string(forKey: LONIN_INFO)
////        let userInfo = userDefaults.object(forKey: LONIN_INFO)
//        let isLogin = userDefaults.bool(forKey: IS_LOGIN)
//        
//        LMWGlobalIsLogin = isLogin
        
        LMWLoginInfoUtils.shareLoginInfoUtils.getLoginInfo()
        
        if (LMWGlobalIsLogin) {
            
            let username = LMWGlobalUserInfo?.username
            NSLog( username! + "已经登陆")
        }else{
            
            NSLog("未登录")
        }
      

        Thread.sleep(forTimeInterval: 3)//欢迎页面，延长3秒
        self.window?.rootViewController = LMWTabBarController()
        self.window?.makeKeyAndVisible()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

