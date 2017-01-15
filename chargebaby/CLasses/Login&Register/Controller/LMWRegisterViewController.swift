//
//  LMWRegisterViewController.swift
//  chargebaby
//
//  Created by 刘明伟 on 2016/12/6.
//  Copyright © 2016年 刘明伟. All rights reserved.
//

import UIKit
import HandyJSON
import RxCocoa
import RxSwift

class LMWRegisterViewController: UIViewController {
    @IBOutlet weak var registerUsernameTF: UITextField!
    
    @IBOutlet weak var registerPasswordTF: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    var registerDelegate : SendRegisterMessageDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerUsernameTF.placeholder = "请输入用户名"
        registerPasswordTF.placeholder = "请设置您的密码（长度6-20）"
        
        
        let usernameValid = registerUsernameTF.rx.text
            .map{($0?.characters.count)! >= MIN_USERNAME_LENGTH && ($0?.characters.count)! <= MAX_USERNAME_LENGTH }  //map函数 对text进行处理
            .shareReplay(1)     //
        
        let passwordValid = registerPasswordTF.rx.text
            .map{($0?.characters.count)! >= MIN_PASSWORD_LENGTH && ($0?.characters.count)! < MAX_PASSWORD_LENGTH }  //map函数 对text进行处理
            .shareReplay(1)
        

        
        
        let everythingValid = Observable.combineLatest(usernameValid, passwordValid) { $0 && $1 }
            .shareReplay(1)
        
       
        
        usernameValid.bindTo(registerUsernameTF.ex_validState).addDisposableTo(disposBag)
        passwordValid.bindTo(registerPasswordTF.ex_validState).addDisposableTo(disposBag)
    

        
        usernameValid
            .bindTo(registerPasswordTF.rx.isEnabled)  //username通过验证，passwordTF才可以输入
            .addDisposableTo(disposBag)
        
         //username通过验证，passwordTF才可以输入

        
        everythingValid
            .bindTo(registerButton.rx.isEnabled)   // 用户名密码都通过验证，才可以点击按钮
            .addDisposableTo(disposBag)
        
        everythingValid.bindTo(registerButton.ex_validState).addDisposableTo(disposBag)
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func registerBT(_ sender: Any) {
        // 判断网络是否可用
        LMWTools.checkConnectNet(controller: self)
        
        let username:String = registerUsernameTF.text!
        let password:String = registerPasswordTF.text!.md5!
        
        if(GetDataFromRemote.register(controller:self, username:username, password:password)){
            
            LMWTools.showSuccessAlert()
            
            self.registerDelegate?.onRegisterControllerResult(requestCode: LOGIN_REGISTER_REQUEST_CODE, resultCode: LOGIN_SUCCESS_RESULT_CODE)
            self.navigationController?.popViewController(animated: true)
            self.tabBarController?.tabBar.isHidden = false
        }
    }
    


}

protocol SendRegisterMessageDelegate{
    func onRegisterControllerResult(requestCode : Int, resultCode:Int)
}
