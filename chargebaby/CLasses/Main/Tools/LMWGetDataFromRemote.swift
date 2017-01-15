//
//  LMWGetDataFromRemote.swift
//  chargebaby
//
//  Created by 刘明伟 on 2017/1/5.
//  Copyright © 2017年 刘明伟. All rights reserved.
//

import Foundation
import HandyJSON

class GetDataFromRemote {
//    fileprivate func dismiss(){
//        print("支行了dismiss")
//        alert.dismissWithClickedButtonIndex(0, animated: false)
//    }
    
    static let SYS_ERROR = "系统错误"
    
    func alertErrorMsg(controller:UIViewController, message:String){
        
        let alertController = UIAlertController(title: message,
                                                message: nil, preferredStyle: .alert)
        //显示提示框
        controller.present(alertController, animated: true, completion: nil)
        //一秒钟后自动消失
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            controller.presentedViewController?.dismiss(animated: false, completion: nil)
        }
    }

    /**
     *登录
     * @param chargeNo
     */
    static func login(controller:UIViewController, username:String, password:String) -> Bool{
        let urlString:String = SERVER + ACTION_LOGIN
        
        var url:NSURL!
        url = NSURL(string:urlString)
        let request = NSMutableURLRequest(url:url as URL)
        let body = "username=\(username)&password=\(password)"
        //编码POST数据
        let postData = body.data(using: String.Encoding.utf8)
        //保用 POST 提交
        request.httpMethod = "POST"
        request.httpBody = postData
        
        //响应对象
        var response:URLResponse?
        
        do{
            //发出请求
            let received:NSData? = try NSURLConnection.sendSynchronousRequest(request as URLRequest,
                                                                              returning: &response) as NSData?
            let datastring = String(data:received! as Data, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
            
            let json = JSONDeserializer<JsonUserInfo>.deserializeFrom(json: datastring)

            if (json?.success)! {
                LMWGlobalIsLogin = true
                LMWGlobalUserInfo = json?.obj
                let userInfoStr = JSONSerializer.serialize(model: LMWGlobalUserInfo).toJSON()!
                LMWLoginInfoUtils.shareLoginInfoUtils.setLoginInfo(userInfoStr: userInfoStr)
                
                
                return true
            }
            else{
                let alertController = UIAlertController(title: json?.msg,
                                                        message: nil, preferredStyle: .alert)
                //显示提示框
                controller.present(alertController, animated: true, completion: nil)
                //一秒钟后自动消失
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    controller.presentedViewController?.dismiss(animated: false, completion: nil)
                }
                
            }
            
        }catch let error as NSError{
            //打印错误消息
            print(error.code)
            print(error.description)
            let alertController = UIAlertController(title: "系统错误",
                                                    message: nil, preferredStyle: .alert)
            //显示提示框
            controller.present(alertController, animated: true, completion: nil)
            //一秒钟后自动消失
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                controller.presentedViewController?.dismiss(animated: false, completion: nil)
            }
            return false
        }
        return false
    }
    
    /**
        *注册
        **/
    static func register(controller:UIViewController, username:String, password:String) ->Bool{
        let urlString:String = SERVER + ACTION_REGIST
        
        var url:NSURL!
        url = NSURL(string:urlString)
        let request = NSMutableURLRequest(url:url as URL)
        let body = "username=\(username)&password=\(password)"
        //编码POST数据
        let postData = body.data(using: String.Encoding.utf8)
        //保用 POST 提交
        request.httpMethod = "POST"
        request.httpBody = postData
        
        //响应对象
        var response:URLResponse?
        
        do{
            //发出请求
            let received:NSData? = try NSURLConnection.sendSynchronousRequest(request as URLRequest,
                                                                              returning: &response) as NSData?
            let datastring = String(data:received! as Data, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
            
            
            let json = JSONDeserializer<JsonUserInfo>.deserializeFrom(json: datastring)
            if (json?.success)! {
                print("注册成功")
                LMWGlobalIsLogin = true
                LMWGlobalUserInfo = json?.obj
                let userInfoStr = JSONSerializer.serialize(model: LMWGlobalUserInfo).toJSON()!
                LMWLoginInfoUtils.shareLoginInfoUtils.setLoginInfo(userInfoStr: userInfoStr)
                
                return true
            }else{
                let alertController = UIAlertController(title: json?.msg,
                                                        message: nil, preferredStyle: .alert)
                //显示提示框
                controller.present(alertController, animated: true, completion: nil)
                //一秒钟后自动消失
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    controller.presentedViewController?.dismiss(animated: false, completion: nil)
                }
            }
            
        }catch let error as NSError{
            //打印错误消息
            print(error.code)
            print(error.description)
            let alertController = UIAlertController(title: "系统错误",
                                                    message: nil, preferredStyle: .alert)
            //显示提示框
            controller.present(alertController, animated: true, completion: nil)
            //一秒钟后自动消失
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                controller.presentedViewController?.dismiss(animated: false, completion: nil)
            }
            return false
        }
        return false

    }
    
    
    /**
        *忘记密码
        */
    static func forgetPassword(controller:UIViewController, username:String, password:String) ->Bool{
        let urlString:String = SERVER + ACTION_CONFIRM
        
        var url:NSURL!
        url = NSURL(string:urlString)
        let request = NSMutableURLRequest(url:url as URL)
        let body = "username=\(username)&password=\(password)"
        //编码POST数据
        let postData = body.data(using: String.Encoding.utf8)
        //保用 POST 提交
        request.httpMethod = "POST"
        request.httpBody = postData
        
        //响应对象
        var response:URLResponse?
        
        do{
            //发出请求
            let received:NSData? = try NSURLConnection.sendSynchronousRequest(request as URLRequest,
                                                                              returning: &response) as NSData?
            let datastring = String(data:received! as Data, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
            
            
            let json = JSONDeserializer<JsonUserInfo>.deserializeFrom(json: datastring)
            if (json?.success)! {
                LMWGlobalIsLogin = true
                LMWGlobalUserInfo = json?.obj
                let userInfoStr = JSONSerializer.serialize(model: LMWGlobalUserInfo).toJSON()!
                LMWLoginInfoUtils.shareLoginInfoUtils.setLoginInfo(userInfoStr: userInfoStr)
              
                return true
            }else{
                let alertController = UIAlertController(title: json?.msg,
                                                        message: nil, preferredStyle: .alert)
                //显示提示框
                controller.present(alertController, animated: true, completion: nil)
                //一秒钟后自动消失
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    controller.presentedViewController?.dismiss(animated: false, completion: nil)
                }
            }
        }catch let error as NSError{
            //打印错误消息
            print(error.code)
            print(error.description)
            
            let alertController = UIAlertController(title: "系统错误",
                                                    message: nil, preferredStyle: .alert)
            //显示提示框
            controller.present(alertController, animated: true, completion: nil)
            //一秒钟后自动消失
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                controller.presentedViewController?.dismiss(animated: false, completion: nil)
            }
            return false
        }
            return false
    }
    
    /**
     *获取评论，根据chargeNo
     * @param chargeNo
     */
    static func getComments(chargeNo:String) -> CommentResults{
        let commentResults: CommentResults! = CommentResults()
        var url:NSURL!
        let urlString:String = SERVER + ACTION_FIND_ALL_COMMENT
        
        url = NSURL(string:urlString)
        let request = NSMutableURLRequest(url:url as URL)
        let body = "chargeNo=\(chargeNo)"
        //编码POST数据
        let postData = body.data(using: String.Encoding.utf8)
        //保用 POST 提交
        request.httpMethod = "POST"
        request.httpBody = postData
        
        
        
        //响应对象
        var response:URLResponse?
        
        do{
            //发出请求
            let received:NSData? = try NSURLConnection.sendSynchronousRequest(request as URLRequest,
                                                                              returning: &response) as NSData?
            let datastring = String(data:received! as Data, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
            
            
            let json = JSONDeserializer<JsonComment>.deserializeFrom(json: datastring)
            if (json?.success)! {
                commentResults.comments = (json?.obj)!
                
                return commentResults
                
            }
            
            
        }catch let error as NSError{
            //打印错误消息
            print(error.code)
            print(error.description)
        }
        return commentResults
    }
    
    
    /**
     * 添加评论
     * @param info
     */
    static func addCommet(authorId:Int64, chargeNo:String, info:String) -> CommentResults{
        
        let commentResults: CommentResults! = CommentResults()
        var url:NSURL!
        let urlString:String = SERVER + ACTION_ADD_COMMENT
        
        url = NSURL(string:urlString)
        let request = NSMutableURLRequest(url:url as URL)
        let body = "authorId=\(authorId)&chargeNo=\(chargeNo)&info=\(info)"
        //编码POST数据
        let postData = body.data(using: String.Encoding.utf8)
        //保用 POST 提交
        request.httpMethod = "POST"
        request.httpBody = postData
        
        //响应对象
        var response:URLResponse?
        
        do{
            //发出请求
            let received:NSData? = try NSURLConnection.sendSynchronousRequest(request as URLRequest,
                                                                              returning: &response) as NSData?
            let datastring = String(data:received! as Data, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
            
            
            let json = JSONDeserializer<JsonComment>.deserializeFrom(json: datastring)
            if (json?.success)! {
                commentResults.comments = (json?.obj)!
                
                return commentResults
                
            }
            
      }catch let error as NSError{
            //打印错误消息
            print(error.code)
            print(error.description)
        }
        return commentResults
    }
    
    
    /**
     * 添加收藏
     * @return
     */
    static func addFavorite(userId:Int64, chargeNo:String) -> Bool{
        var favorites: [Favorite]! = []
        
        var url:NSURL!
        let urlString:String = SERVER + ACTION_ADD_FAVORITE
        
        url = NSURL(string:urlString)
        let request = NSMutableURLRequest(url:url as URL)
        let body = "userId=\(userId)&chargeNo=\(chargeNo)"
        //编码POST数据
        let postData = body.data(using: String.Encoding.utf8)
        //保用 POST 提交
        request.httpMethod = "POST"
        request.httpBody = postData
        
        //响应对象
        var response:URLResponse?
        
        do{
            //发出请求
            let received:NSData? = try NSURLConnection.sendSynchronousRequest(request as URLRequest,
                                                                              returning: &response) as NSData?
            let datastring = String(data:received! as Data, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
            
            
            let json = JSONDeserializer<JsonFavorite>.deserializeFrom(json: datastring)
            if (json?.success)! {
                favorites = json?.obj
                
                LMWGlobalUserInfo?.favoriteList?.removeAll()
                LMWGlobalUserInfo?.favoriteList?.append(contentsOf: favorites)
                
                let userInfoStr = JSONSerializer.serialize(model: LMWGlobalUserInfo).toJSON()
                LMWLoginInfoUtils.shareLoginInfoUtils.updateLoginInfo(userInfoStr: userInfoStr!)
                
                return true
                
            }
            
        }catch let error as NSError{
            //打印错误消息
            print(error.code)
            print(error.description)
        }
        return false
    
    }

    /**
     * 去除收藏
     * @return
     */
    static func removeFavorite(userId:Int64, chargeNo:String) -> Bool{
        var favorites: [Favorite]! = []
        
        var url:NSURL!
        let urlString:String = SERVER + ACTION_REMOVE_FAVORITE
        
        url = NSURL(string:urlString)
        let request = NSMutableURLRequest(url:url as URL)
        let body = "userId=\(userId)&chargeNo=\(chargeNo)"
        //编码POST数据
        let postData = body.data(using: String.Encoding.utf8)
        //保用 POST 提交
        request.httpMethod = "POST"
        request.httpBody = postData
        
        //响应对象
        var response:URLResponse?
        
        do{
            //发出请求
            let received:NSData? = try NSURLConnection.sendSynchronousRequest(request as URLRequest,
                                                                              returning: &response) as NSData?
            let datastring = String(data:received! as Data, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
            
            
            let json = JSONDeserializer<JsonFavorite>.deserializeFrom(json: datastring)
            if (json?.success)! {
                favorites = json?.obj
                
                LMWGlobalUserInfo?.favoriteList?.removeAll()
                LMWGlobalUserInfo?.favoriteList?.append(contentsOf: favorites)
                
                let userInfoStr = JSONSerializer.serialize(model: LMWGlobalUserInfo).toJSON()
                LMWLoginInfoUtils.shareLoginInfoUtils.updateLoginInfo(userInfoStr: userInfoStr!)
                
               return true
            }
        }catch let error as NSError{
            //打印错误消息
            print(error.code)
            print(error.description)
        }
        return false
    }
    
    /**
     * 判断该充电桩，是否收藏
     * @param chargeNo
     * @param favoriteList
     * @return
     */
    static func isFavorite(chargeNo:String, favorites:[Favorite]) -> Bool{

        for favorite in favorites {
            if (chargeNo == favorite.chargeNo) {
                return true
            }
        }
        return false
    }
    
    
    /**
        *
        */
    static func addCollect(controller:UIViewController, username:String, info:String) -> Bool{
        let urlString:String = SERVER + ACTION_ADD_COLLECT
        
        var url:NSURL!
        url = NSURL(string:urlString)
        let request = NSMutableURLRequest(url:url as URL)
        let body = "username=\(username)&info=\(info)"
        //编码POST数据
        let postData = body.data(using: String.Encoding.utf8)
        //保用 POST 提交
        request.httpMethod = "POST"
        request.httpBody = postData
        
        //响应对象
        var response:URLResponse?
        
        do{
            //发出请求
            let received:NSData? = try NSURLConnection.sendSynchronousRequest(request as URLRequest,
                                                                              returning: &response) as NSData?
            let datastring = String(data:received! as Data, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
            
            
            let json = JSONDeserializer<JsonResult>.deserializeFrom(json: datastring)
            if (json?.success)! {
                
               return true
            }else{
                let alertController = UIAlertController(title: json?.msg,
                                                        message: nil, preferredStyle: .alert)
                //显示提示框
                controller.present(alertController, animated: true, completion: nil)
                //一秒钟后自动消失
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    controller.presentedViewController?.dismiss(animated: false, completion: nil)
                }
                return false
            }
            
            
        }catch let error as NSError{
            //打印错误消息
            print(error.code)
            print(error.description)
            let alertController = UIAlertController(title: "系统错误",
                                                    message: nil, preferredStyle: .alert)
            //显示提示框
            controller.present(alertController, animated: true, completion: nil)
            //一秒钟后自动消失
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                controller.presentedViewController?.dismiss(animated: false, completion: nil)
            }

            return false
        }
        return false
    
    }
}
