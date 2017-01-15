//
//  LMWForgetPasswordViewController.swift
//  chargebaby
//
//  Created by 刘明伟 on 2016/12/10.
//  Copyright © 2016年 刘明伟. All rights reserved.
//

import UIKit
import HandyJSON
import RxSwift
import RxCocoa

protocol SendForgetPasswordMessageDelegate{
    func onForgetPasswordControllerResult(requestCode : Int, resultCode:Int)
}
class LMWForgetPasswordViewController: UIViewController {

    
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var forgetPasswordPassword1TF: UITextField!
    @IBOutlet weak var forgetPasswordUsernameTF: UITextField!
    
    var forgetPasswordDelegate : SendForgetPasswordMessageDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        forgetPasswordUsernameTF.placeholder = "请输入您的用户名"
        forgetPasswordPassword1TF.placeholder = "请设置您的密码（长度6-20）"
        
        
        let usernameValid = forgetPasswordUsernameTF.rx.text
            .map{($0?.characters.count)! >= MIN_USERNAME_LENGTH && ($0?.characters.count)! <= MAX_USERNAME_LENGTH }  //map函数 对text进行处理
            .shareReplay(1)     //
        
        let passwordValid = forgetPasswordPassword1TF.rx.text
            .map{($0?.characters.count)! >= MIN_PASSWORD_LENGTH && ($0?.characters.count)! < MAX_PASSWORD_LENGTH }  //map函数 对text进行处理
            .shareReplay(1)
        
        let everythingValid = Observable.combineLatest(usernameValid, passwordValid) { $0 && $1 }
            .shareReplay(1)
        
        usernameValid.bindTo(forgetPasswordUsernameTF.ex_validState).addDisposableTo(disposBag)
        passwordValid.bindTo(forgetPasswordPassword1TF.ex_validState).addDisposableTo(disposBag)
        
        usernameValid
            .bindTo(forgetPasswordPassword1TF.rx.isEnabled)  //username通过验证，passwordTF才可以输入
            .addDisposableTo(disposBag)
        
        everythingValid
            .bindTo(confirmButton.rx.isEnabled)   // 用户名密码都通过验证，才可以点击按钮
            .addDisposableTo(disposBag)
        
        everythingValid.bindTo(confirmButton.ex_validState).addDisposableTo(disposBag)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func forgetPasswordBT(_ sender: Any) {
        // 判断网络是否可用
        LMWTools.checkConnectNet(controller: self)
        
        let username:String = forgetPasswordUsernameTF.text!
        let password:String = forgetPasswordPassword1TF.text!.md5!
        
        if(GetDataFromRemote.forgetPassword(controller:self, username:username, password:password)){
            
            LMWTools.showSuccessAlert()
            
            self.forgetPasswordDelegate?.onForgetPasswordControllerResult(requestCode: LOGIN_REGISTER_REQUEST_CODE, resultCode: LOGIN_SUCCESS_RESULT_CODE)
            self.navigationController?.popViewController(animated: true)
            self.tabBarController?.tabBar.isHidden = false
        }
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
