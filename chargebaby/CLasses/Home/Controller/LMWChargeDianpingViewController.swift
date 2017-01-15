//
//  LMWChargeDianpingViewController.swift
//  chargebaby
//
//  Created by 刘明伟 on 2016/12/30.
//  Copyright © 2016年 刘明伟. All rights reserved.
//

import UIKit

class LMWChargeDianpingViewController: UIViewController {

    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var createTimeLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    
    @IBOutlet weak var commentTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commentTable.estimatedRowHeight = 44.0
        commentTable.rowHeight = UITableViewAutomaticDimension
        print("点评")
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
