//
//  LMWLoginViewController.swift
//  chargebaby
//
//  Created by 刘明伟 on 2016/11/27.
//  Copyright © 2016年 刘明伟. All rights reserved.
//

import UIKit
import HandyJSON
import RxSwift
import RxCocoa

protocol SendLoginMessageDelegate{
    func onLoginControllerResult(requestCode : Int, resultCode:Int)
}
    let disposBag = DisposeBag()
class LMWLoginViewController: UIViewController {

  
    
    //忘记密码
    @IBOutlet weak var forgetPasswordLabel: UILabel!
    //登录按钮
    @IBOutlet weak var loginButton: UIButton!
    //密码输入框
    @IBOutlet weak var passwordTF: UITextField!
    //用户名输入框
    @IBOutlet weak var usernameTF: UITextField!
    
    var delegate : SendLoginMessageDelegate?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        let leftBarBtn = UIBarButtonItem()
////        leftBarBtn.action = #selector(LMWLoginViewController.backToPrevious)
//        leftBarBtn.target = self
//        leftBarBtn.action = backToPrevious()
       let leftBarBtn = UIBarButtonItem(title: "个人中心", style: .plain, target: self,
                                         action: #selector(LMWLoginViewController.backToPrevious))
        self.navigationItem.leftBarButtonItem = leftBarBtn

        
        
        let rightBarBtn = UIBarButtonItem(title: "注册", style: .plain, target: self,
                                          action: #selector(LMWLoginViewController.goToRegisterStoryboard))
        self.navigationItem.rightBarButtonItem = rightBarBtn
        
        usernameTF.placeholder = "手机号／用户ID"
        passwordTF.placeholder = "请输入登录密码"
        

        
        let usernameValid = usernameTF.rx.text
            .map{($0?.characters.count)! >= MIN_USERNAME_LENGTH && ($0?.characters.count)! <= MAX_USERNAME_LENGTH }  //map函数 对text进行处理
            .shareReplay(1)     //
        
        let passwordValid = passwordTF.rx.text
            .map{($0?.characters.count)! >= MIN_PASSWORD_LENGTH && ($0?.characters.count)! < MAX_PASSWORD_LENGTH }  //map函数 对text进行处理
            .shareReplay(1)
        
        let everythingValid = Observable.combineLatest(usernameValid, passwordValid) { $0 && $1 }
            .shareReplay(1)
        
        usernameValid
            .bindTo(passwordTF.rx.isEnabled)  //username通过验证，passwordTF才可以输入
            .addDisposableTo(disposBag)
        
//        usernameValid
//            .bindTo(hintLabel.rx.isHidden)   //username通过验证，usernameLB警告消失
//            .addDisposableTo(disposBag)
//        
//        passwordValid
//            .bindTo(passwordHintLabel.rx.isHidden)  //password通过验证，usernameLB警告消失
//            .addDisposableTo(disposBag)
        
        everythingValid
            .bindTo(loginButton.rx.isEnabled)   // 用户名密码都通过验证，才可以点击按钮
            .addDisposableTo(disposBag)
        
        everythingValid.bindTo(loginButton.ex_validState).addDisposableTo(disposBag)
        


    }
    
    
    @IBAction func login(_ sender: Any) {
        
        // 判断网络是否可用
        LMWTools.checkConnectNet(controller: self)
        
        let username = usernameTF.text!
        let password = passwordTF.text!.md5!
        
        if(GetDataFromRemote.login(controller:self, username:username, password:password)){
            
            LMWTools.showSuccessAlert()
            self.delegate?.onLoginControllerResult(requestCode: LOGIN_REGISTER_REQUEST_CODE, resultCode: LOGIN_SUCCESS_RESULT_CODE)
            self.navigationController?.popViewController(animated: true)
            self.tabBarController?.tabBar.isHidden = false
        }
    }



    func gotoLoginInfoStoryboard()  {
        let storyBoard = UIStoryboard(name: "LMWMineViewStoryboard", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "mineViewStoryboard")

//        vc.navigationItem.hidesBackButton=true
        self.navigationController?.pushViewController(vc, animated: true)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //跳转注册
    func goToRegisterStoryboard()  {
        let storyBoard = UIStoryboard(name: "LMWRegisterStoryboard", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "registerStoryboard") as! LMWRegisterViewController
        vc.registerDelegate = self
        self.navigationController?.pushViewController(vc, animated: true)
        self.tabBarController?.tabBar.isHidden = true
    }

    //跳转忘记密码
    @IBAction func gotoForgetPasswordStoryboard(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "LMWForgetPasswordStoryboard", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "forgetPasswordStoryboard") as!LMWForgetPasswordViewController
        vc.forgetPasswordDelegate = self

//        vc.navigationItem.hidesBackButton=true
        self.navigationController?.pushViewController(vc, animated: true)
        self.tabBarController?.tabBar.isHidden = true
    }
    //返回按钮点击响应
    func backToPrevious(){
        self.navigationController?.popViewController(animated: true)
        self.tabBarController?.tabBar.isHidden = false
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

extension LMWLoginViewController:SendRegisterMessageDelegate{
    func onRegisterControllerResult(requestCode : Int, resultCode:Int){
        //注册成功
        if (requestCode == LOGIN_REGISTER_REQUEST_CODE && resultCode == LOGIN_SUCCESS_RESULT_CODE) {
            self.delegate?.onLoginControllerResult(requestCode: LOGIN_REGISTER_REQUEST_CODE, resultCode: LOGIN_SUCCESS_RESULT_CODE)
            self.navigationController?.popViewController(animated: true)
            self.tabBarController?.tabBar.isHidden = false
            return
        }
        
        //修改密码成功
     
        
    }
}

extension LMWLoginViewController: SendForgetPasswordMessageDelegate{
    func onForgetPasswordControllerResult(requestCode : Int, resultCode:Int){
        //修改密码
        if (requestCode == LOGIN_REGISTER_REQUEST_CODE && resultCode == LOGIN_SUCCESS_RESULT_CODE) {
            self.delegate?.onLoginControllerResult(requestCode: LOGIN_REGISTER_REQUEST_CODE, resultCode: LOGIN_SUCCESS_RESULT_CODE)
            self.navigationController?.popViewController(animated: true)
            self.tabBarController?.tabBar.isHidden = false
            return
        }
    }
}

extension UIButton{
    var ex_validState:AnyObserver<Bool>{
        
        return UIBindingObserver(UIElement: self) { button, valid in
            button.isEnabled = valid
            button.backgroundColor = valid ? UIColor.orange : UIColor.lightGray
            }.asObserver()
    }
}

extension UITextField{
    var ex_validState:AnyObserver<Bool>{
        return UIBindingObserver(UIElement: self) { textfield, valid in
            textfield.backgroundColor = valid ? UIColor.clear:UIColor.lightGray
            }.asObserver()
    }
}

