//
//  LMWMineViewController.swift
//  chargebaby
//
//  Created by 刘明伟 on 2016/11/10.
//  Copyright © 2016年 刘明伟. All rights reserved.
//

import UIKit



@available(iOS 9.0, *)
class LMWMineViewController: UIViewController{
 

    //分享按钮
    @IBAction func showShare(_ sender: Any) {
    }
    //我的采集按钮
    @IBAction func gotoMyCollect(_ sender: Any) {
        
        
    }
    
    //我的收藏按钮
    @IBAction func gotoMyFavorite(_ sender: Any) {
        //判断是否登录
        if (!LMWGlobalIsLogin) {
            LMWTools.showLoginAlert()
            return 
        }
        
        
        let storyBoard = UIStoryboard(name: "LMWMineViewStoryboard", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "favoriteStoryboard") as! LMWFavoriteTableViewController
        
        
        self.navigationController?.pushViewController(vc, animated: true)
        
        self.tabBarController?.tabBar.isHidden = true

        
    }
    
    @IBOutlet weak var mineLoginView: UIView!
    @IBOutlet weak var mineArrowIV: UIImageView!
    @IBOutlet weak var mineInfoLable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if LMWGlobalIsLogin {
        mineInfoLable.text = "已经登陆"
        mineArrowIV.isHidden = true
        mineLoginView.isUserInteractionEnabled = false
        }else {
        mineInfoLable.text = "点我登陆"
        mineArrowIV.isHidden = false
        mineLoginView.isUserInteractionEnabled = true
        }

    }

    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        self.tabBarController?.hidesBottomBarWhenPushed = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

  
    @IBAction func gotoLoginStoryboard(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "LMWLoginStoryboard", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "LoginStoryboard") as! LMWLoginViewController
        vc.delegate = self
        
        self.navigationController?.pushViewController(vc, animated: true)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    /**
     *  跳转到设置页面
     *
     */
    @IBAction func gotoSettingStoryboard(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name: "LMWSettingViewStoryboard", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "settingStoryboard") as!LMWSettingViewController
        vc.settingDelegate = self
        
        self.navigationController?.pushViewController(vc, animated: true)
        self.tabBarController?.tabBar.isHidden = true
        
    }
  


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


extension LMWMineViewController:SendLoginMessageDelegate{
    func onLoginControllerResult(requestCode : Int, resultCode:Int){
        //登录或者注册成功
        if (requestCode == LOGIN_REGISTER_REQUEST_CODE && resultCode == LOGIN_SUCCESS_RESULT_CODE) {
            mineInfoLable.text = "已经登陆"
            mineArrowIV.isHidden = true
            mineLoginView.isUserInteractionEnabled = false
            return
        }
        self.tabBarController?.tabBar.isHidden = false

        
    }
}

extension LMWMineViewController:SendSettingMessageDelegate{
    func onSettingControllerResult(requestCode : Int, resultCode:Int){

        
        //已经登出
        if (requestCode == SETTING_LOGOUT_REQUEST_CODE && resultCode == LOGOUT_SUCCESS_RESULT_CODE) {
            mineInfoLable.text = "点我登陆"
            mineArrowIV.isHidden = false
            mineLoginView.isUserInteractionEnabled = true
            return
        }
         self.tabBarController?.tabBar.isHidden = false
    }
}
