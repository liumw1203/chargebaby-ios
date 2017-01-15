//
//  LMWDetailViewController.swift
//  chargebaby
//
//  Created by 刘明伟 on 2017/1/5.
//  Copyright © 2017年 刘明伟. All rights reserved.
//

import UIKit

class LMWDetailViewController: UIViewController {
    
    var charge:Charge!
    
    @IBOutlet weak var detaillView: UIView!
    @IBOutlet weak var detailNavView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("点击详情--")
        let chargeDetail = UIView.loadFromNibNamed("LMWChargeDetailView") as! LMWChargeDetailView
//        detaillView. =
        
//        detaillView.addSubview(chargeDetail.chargeDetailView)
        detaillView.addSubview(chargeDetail)
        
        configChargeDetail(chargeDetail: chargeDetail)
        
        //配置导航
        detailNavView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(LMWDetailViewController.nav)))
        
        // Do any additional setup after loading the view.
    }
    
    
    //导航
    func nav() {
        print("测试导航按钮" + "name =" + charge.name!   )
        print("测试导航按钮" + "latitude =" + String( charge.latitude!)   )
        
        LMWTools().nav(controller: self, name: charge.name!, latitude: charge.latitude!, longitude: charge.longitude!)
    }
    
    //赋值
    func configChargeDetail(chargeDetail: LMWChargeDetailView) {
        if (charge.dc_builded != nil) {
            let dc = String(stringInterpolationSegment: charge.dc_builded!)
            chargeDetail.chargeDCBuildedTF.text = dc
        }
        if (charge.dc_building != nil) {
            chargeDetail.chargeDCBuildingTF.text = String(stringInterpolationSegment:charge.dc_building!)
        }
        if (charge.ac_builded != nil) {
            chargeDetail.chargeACBuildedTF.text = String(stringInterpolationSegment:charge.ac_builded!)
        }
        if (charge.ac_building != nil) {
            
            chargeDetail.chargeACBuildingTF.text = String(stringInterpolationSegment:charge.ac_building!)
        }
        if (charge.begin_time != nil) {
            
            chargeDetail.chargeBeginTimeLabel.text = charge.begin_time
        }
        if (charge.tel != nil) {
             chargeDetail.chargeTelLabel.text = charge.tel
        }
        if (charge.standard_name != nil) {
            
            chargeDetail.chargeStandardNameLabel.text = charge.standard_name
        }
        if (charge.fee_standard != nil) {
            chargeDetail.chargeFeeStandardLabel.text = charge.fee_standard
            
        }
        if (charge.detail != nil) {
            chargeDetail.chargeDetailLabel.text = charge.detail
        }
        if (charge.depart != nil){
            
            chargeDetail.chargeDepartLabel.text = charge.depart
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //发送一个名字为currentPageChanged，附带object的值代表当前页面的索引
        NotificationCenter.default.post(name: Notification.Name(rawValue: "currentPageChanged"), object: 0)
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
