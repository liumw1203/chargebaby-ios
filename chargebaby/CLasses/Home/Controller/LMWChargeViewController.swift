//
//  LMWChargeViewController.swift
//  chargebaby
//
//  Created by 刘明伟 on 2016/12/30.
//  Copyright © 2016年 刘明伟. All rights reserved.
//

import UIKit
import SnapKit
//import TwicketSegmentedControl

class LMWChargeViewController: UIViewController, YSSegmentedControlDelegate {
    @IBOutlet weak var chargeAddressTV: UITextView!
    @IBOutlet weak var chargeNameTF: UITextField!
    @IBOutlet weak var chargeTabView: UIView!
    @IBOutlet weak var segmentView: UIView!
    
    var charge_no:String!
    var charge:[String:Any]!
    var db = SQLiteDB.sharedInstance

//    let chargeDetail = UIView.loadFromNibNamed("LMWChargeDetailView") as! LMWChargeDetailView
//    var chargeDetailView = UIView()
    let chargeDianping = UIView.loadFromNibNamed("LMWChargeDianpingView") as! LMWChargeDianpingView
    
    var chargeDetailController = UIViewController()
    var chargeDianpingController = UIViewController()
    
    let chargeDetail = UIView.loadFromNibNamed("LMWChargeDetailView") as! LMWChargeDetailView
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initChargeData(chargeNoValue: charge_no)
        view.backgroundColor = UIColor (white: 240.0/255.0, alpha: 1)
        navigationItem.title = "充电点详情"
        
        chargeDetailController.title = "详情"
        chargeDetailController.view.backgroundColor = UIColor.blue
        chargeDianpingController.title = "点评"
        chargeDianpingController.view.backgroundColor = UIColor.red
        
        
        initChargeDetail()

        let skScNavc = LMWChargeTitleViewController(subViewControllers: [chargeDetailController, chargeDianpingController], charge: charge)
        skScNavc.showArrowButton = false
        skScNavc.addParentController(self)
//        skScNavc.titleChargeNo = charge_no
        
    }
    
    // MARK: YSSegmentedControlDelegate

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func initChargeDetail(){
        chargeDetailController.view.addSubview(chargeDetail.chargeDetailView)
        chargeDetailController.view.addSubview(chargeDetail.chargeNavView)

        chargeDetail.chargeDetailView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(chargeDetail.chargeDetailView.frame.height)
            make.width.equalToSuperview()
            
        }
        //
        
        chargeDetail.chargeNavView.snp.makeConstraints { (make) in
            
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalToSuperview()
            make.bottom.equalTo(chargeDetail.chargeDetailView)
            
        }
        
    }
    
    //初始化详情页数据
    func initChargeData(chargeNoValue: String)  {
        //根据编码获取详情
        charge = getChargeByNO(chargeNoValue: chargeNoValue)
        
        chargeNameTF.text = charge["name"] as! String?
        chargeAddressTV.text = charge["address"] as! String

        //幅值
        
        
    }
    
    
    fileprivate func getChargeByNO(chargeNoValue: String) -> [String:Any]{
        
      
        
        let data = db.query(sql: "select * from charge where charge_no = ?", parameters:[chargeNoValue])
        
        //        print(data)
        return data[0]
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
