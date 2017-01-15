//
//  LMWSettingViewController.swift
//  chargebaby
//
//  Created by 刘明伟 on 2016/12/2.
//  Copyright © 2016年 刘明伟. All rights reserved.
//

import UIKit


protocol SendSettingMessageDelegate{
    func onSettingControllerResult(requestCode : Int, resultCode:Int)
}
class LMWSettingViewController: UIViewController {
    
    var settingDelegate :SendSettingMessageDelegate?
    
    
    @IBOutlet weak var logoutView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let leftBarBtn = UIBarButtonItem(title: "个人中心", style: .plain, target: self,
                                         action: #selector(LMWSettingViewController.backToPrevious))
//        let leftBarBtn = UIBarButtonItem(ini)
        
        self.navigationItem.leftBarButtonItem = leftBarBtn
        
        if !LMWGlobalIsLogin {
            logoutView.isHidden = true

        }

        
        // Do any additional setup after loading the view.
    }

    @IBAction func logout(_ sender: Any) {
        
        if (LMWLoginInfoUtils.shareLoginInfoUtils.removeLoginInfo())! {
            LMWGlobalIsLogin = false
            LMWGlobalUserInfo = nil
            print("注销成功")
            self.settingDelegate?.onSettingControllerResult(requestCode: SETTING_LOGOUT_REQUEST_CODE, resultCode: LOGOUT_SUCCESS_RESULT_CODE)
            self.navigationController?.popViewController(animated: true)
            self.tabBarController?.tabBar.isHidden = false
        }else{
            print("注销失败")
            let alertController = UIAlertController(title: "注销失败",
                                                    message: nil, preferredStyle: .alert)
            //显示提示框
            self.present(alertController, animated: true, completion: nil)
            //一秒钟后自动消失
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                self.presentedViewController?.dismiss(animated: false, completion: nil)
            }
        
        }
        
        

        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //返回按钮点击响应
    func backToPrevious(){
        self.navigationController?.popViewController(animated: true)
        self.tabBarController?.tabBar.isHidden = false

    }
  

    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//    }


}
