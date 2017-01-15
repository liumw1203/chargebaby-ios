//
//  LMWCollectViewController.swift
//  chargebaby
//
//  Created by 刘明伟 on 2017/1/2.
//  Copyright © 2017年 刘明伟. All rights reserved.
//

import UIKit
import HandyJSON

class LMWCollectViewController: UIViewController {

    @IBOutlet weak var myCollectTV: UITextView!
    //提交电桩采集
    @IBAction func collectConfirm(_ sender: Any) {
        
        var username = LMWGlobalUserInfo?.username!
        if (username == nil) {
            username = "匿名"
        }
        
        let info = myCollectTV.text!
        
        if (GetDataFromRemote.addCollect(controller:self, username:username!, info:info)) {
            LMWTools.showSuccessAlert()
            
            self.navigationController?.popViewController(animated: true)
        }
        
            }
    override func viewDidLoad() {
        super.viewDidLoad()

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
