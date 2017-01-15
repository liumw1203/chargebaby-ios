//
//  LMWBaseViewController.swift
//  chargebaby
//
//  Created by 刘明伟 on 2016/11/10.
//  Copyright © 2016年 刘明伟. All rights reserved.
//
import UIKit
import SVProgressHUD
import FDFullscreenPopGesture

class LMWBaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = LMWGlobalColor()
        navigationController?.fd_prefersNavigationBarHidden = true
        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.custom)
        SVProgressHUD.setMinimumDismissTimeInterval(1.0)
        SVProgressHUD.setBackgroundColor(UIColor(red: 0, green: 0, blue: 0, alpha: 0.5))
        SVProgressHUD.setForegroundColor(UIColor.white)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

