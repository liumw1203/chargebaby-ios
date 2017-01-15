//
//  LMWFeedbackViewController.swift
//  chargebaby
//
//  Created by 刘明伟 on 2016/12/13.
//  Copyright © 2016年 刘明伟. All rights reserved.
//

import UIKit
import HandyJSON

class LMWFeedbackViewController: UIViewController {

    @IBOutlet weak var feedbackTV: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    @IBAction func feedbackConfirm(_ sender: Any) {
        var username = LMWGlobalUserInfo?.username!
        if (username == nil) {
            username = "匿名"
        }
        
        let info = feedbackTV.text!
        let urlString:String = SERVER + ACTION_FEEDBACK_CONFIRM
        
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
          
                self.navigationController?.popViewController(animated: true)
//                self.dismiss(animated: false, completion: nil)
            }
            
            
        }catch let error as NSError{
            //打印错误消息
            print(error.code)
            print(error.description)
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//        if(segue.identifier == "segueToFeedback")
//        {
//            let vc = segue.destination as! LMWSettingViewController;
//         
//        }
//
//    }
 

}
