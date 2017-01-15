//
//  LMWTools.swift
//  chargebaby
//
//  Created by 刘明伟 on 2016/12/5.
//  Copyright © 2016年 刘明伟. All rights reserved.
//

import Foundation
import MapKit

class LMWTools {
    
    
    func stringToUtf8(received: NSData) -> String {
        return String(data:received as Data, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
      
        
    }
    
    /////now -> string yyyy-MM-dd     2016-12-09
    static func dateNowAsString(nowDate:Date) -> String {
        
        let timeZone = TimeZone.init(identifier: "UTC")
        let formatter = DateFormatter()
        formatter.timeZone = timeZone
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        let date = formatter.string(from: nowDate)
        return date.components(separatedBy: " ").first!
    }
    
    //监测网络是否可用，并弹窗提示
    static func checkConnectNet(controller: UIViewController){
        if (!(Reachability.init()?.isReachable)!) {
            //不可用弹框
            let alertController = UIAlertController(title: "系统提示",
                                                    message: "网络不可用", preferredStyle: .alert)
            //            let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            let okAction = UIAlertAction(title: "确定", style: .default, handler: {
                action in
                print("点击了确定")
            })
            
            alertController.addAction(okAction)
            controller.present(alertController, animated: true, completion: nil)
        }
        
    }
    
    //成功弹窗
    static func showSuccessAlert() {
        let alertView = UIAlertView(
            title: "成功",
            message: "成功",
            delegate: nil,
            cancelButtonTitle: "OK"
        )
        
        alertView.show()
    }
    
    //登录弹窗
    static func showLoginAlert() {
        let alertView = UIAlertView(
            title: "系统提示",
            message: "请先登录",
            delegate: nil,
            cancelButtonTitle: "OK"
        )
        
        alertView.show()
    }
    
    //导航
    func nav(controller:UIViewController, name:String, latitude:Double, longitude:Double) {
        print("测试导航按钮" + "name =" + name   )
        
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        // 腾讯地图有问题，无法获取到定位地址
        //        if(SHARE_APPLICATION.canOpenURL(NSURL(string:"qqmap://")! as URL) == true){
        //            let qqAction = UIAlertAction(title: "腾讯地图", style: .default, handler: {
        //                (alert: UIAlertAction!) -> Void in
        //                let urlString = "qqmap://map/routeplan?type=drive&fromcoord=\(self.currentLatitude),\(self.currentLongitude)&tocoord=\(latitude),\(longitude)&policy=1"
        ////                                let urlString = "qqmap://map/routeplan?from=我的位置&type=drive&tocoord=\(latitude),\(longitude)&to=\(name)&coord_type=1&policy=0"
        ////                let urlString = "qqmap://map/routeplan?from=我的位置&type=drive&tocoord=\(latitude),\(longitude)&to=\(name)&coord_type=1&policy=0"
        ////                let urlString = "http://apis.map.qq.com/uri/v1/routeplan?type=drive&to=\(name)&tocoord=\(latitude),\(longitude)&policy=0&referer=myapp"
        //                let url = NSURL(string:urlString)
        //                SHARE_APPLICATION.openURL(url! as URL)
        //
        //            })
        //            optionMenu.addAction(qqAction)
        //        }
        //
        if(SHARE_APPLICATION.canOpenURL(NSURL(string:"iosamap://")! as URL) == true){
            let gaodeAction = UIAlertAction(title: "高德地图", style: .default, handler: {
                (alert: UIAlertAction!) -> Void in
                let urlString = "iosamap://navi?sourceApplication=chargebaby&backScheme=iosamap://&lat=\(latitude)&lon=\(longitude)&dev=0&style=2"
                
                let url = NSURL(string:urlString)
                SHARE_APPLICATION.openURL(url! as URL)
                
                
            })
            optionMenu.addAction(gaodeAction)
        }
        
        if(SHARE_APPLICATION.canOpenURL(NSURL(string:"comgooglemaps://")! as URL) == true){
            let googleAction = UIAlertAction(title: "Google地图", style: .default, handler: {
                (alert: UIAlertAction!) -> Void in
                let urlString = "comgooglemaps://?x-source=chargebaby&x-success=comgooglemaps://&saddr=&daddr=\(latitude),\(longitude)&directionsmode=driving"
                //                let url = NSURL(string:urlString.stringByAddingPercentEscapesUsingEncoding(String.Encoding.utf8)!)
                let url = NSURL(string:urlString)
                SHARE_APPLICATION.openURL(url! as URL)
                
            })
            optionMenu.addAction(googleAction)
        }
        
        let appleAction = UIAlertAction(title: "苹果地图", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            let loc = CLLocationCoordinate2DMake(latitude, longitude)
            let currentLocation = MKMapItem.forCurrentLocation()
            let toLocation = MKMapItem(placemark:MKPlacemark(coordinate:loc,addressDictionary:nil))
            toLocation.name = name
            MKMapItem.openMaps(with: [currentLocation,toLocation], launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,MKLaunchOptionsShowsTrafficKey: NSNumber(value: true)])
            
        })
        optionMenu.addAction(appleAction)
        
        if(SHARE_APPLICATION.canOpenURL(NSURL(string:"baidumap://")! as URL) == true){
            let baiduAction = UIAlertAction(title: "百度地图", style: .default, handler: {
                (alert: UIAlertAction!) -> Void in
                //                let urlString = "baidumap://map/direction?origin={{我的位置}}&destination=latlng:\(30.306906),\(120.107265)|name=\("星星充电")&mode=driving&coord_type=gcj02"
                let urlString = "baidumap://map/navi?location=\(latitude),\(longitude)&src=push&type=BLK&src=webapp.line.liumw.chargebaby"
                let url = NSURL(string:urlString)
                SHARE_APPLICATION.openURL(url! as URL)
                
            })
            optionMenu.addAction(baiduAction)
        }
        
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
        })
        optionMenu.addAction(cancelAction)
        
//        self.present(optionMenu, animated: true, completion: nil)
        controller.present(optionMenu, animated: true, completion: nil)
    }
    
//    //s收藏
//    static func favorite(controller:UIViewController, chargeNo:String, isFavorite:Bool) -> Bool{
//        if (isFavorite){
//            // 启动线程执行下 已经收藏，取消收藏
//            DispatchQueue.global().async {
//                print("开始执行异步任务")
//                let result = GetDataFromRemote.removeFavorite(userId: (LMWGlobalUserInfo?.id!)!, chargeNo: chargeNo)
//                if(result){
//                    
//                    
//                    let alertController = UIAlertController(title: "取消收藏成功",
//                                                            message: nil, preferredStyle: .alert)
//                    //显示提示框
//                    controller.present(alertController, animated: true, completion: nil)
//                }else{
//                    let alertController = UIAlertController(title: "取消收藏失败",
//                                                            message: nil, preferredStyle: .alert)
//                    //显示提示框
//                    controller.present(alertController, animated: true, completion: nil)
//                }
//                //                Thread.sleep(forTimeInterval: 2)
//                print("异步任务执行完毕")//一秒钟后自动消失
//                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
//                    
//                    
//                    controller.presentedViewController?.dismiss(animated: false, completion: nil)
//                }
//            }
//        }else {
//            //还未收藏，添加收藏
//            print("开始执行异步任务")
//            let result = GetDataFromRemote.addFavorite(userId: (LMWGlobalUserInfo?.id!)!, chargeNo: chargeNo)
//            if(result){
//                
//                let alertController = UIAlertController(title: "添加收藏成功",
//                                                        message: nil, preferredStyle: .alert)
//                //显示提示框
//                controller.present(alertController, animated: true, completion: nil)
//            }else{
//                let alertController = UIAlertController(title: "添加收藏失败",
//                                                        message: nil, preferredStyle: .alert)
//                //显示提示框
//                controller.present(alertController, animated: true, completion: nil)
//            }
//            //            Thread.sleep(forTimeInterval: 1)
//            print("异步任务执行完毕")//一秒钟后自动消失
//            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
//                
//                controller.presentedViewController?.dismiss(animated: false, completion: nil)
//            }
//        }
//        }
    
    }


    
    

    

