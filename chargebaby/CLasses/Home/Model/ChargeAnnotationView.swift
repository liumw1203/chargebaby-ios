//
//  ChargeAnnotationView.swift
//  chargebaby
//
//  Created by 刘明伟 on 2016/12/28.
//  Copyright © 2016年 刘明伟. All rights reserved.
//

import UIKit

class ChargeAnnotationView: MAAnnotationView {
    
    /**charge中的数据*/
    //编码
    var charge_no:String?
    //充电点名称
    var name:String?
    //地址
    var address:String?
    //距离
    var distance:Double?
    
    //距离的值
//    var distanceValue = 0.0

//    var popBottomView:LMWPopBottomView?
//    //标注物点击事件
//    override func setSelected( _ selected:Bool, animated:Bool) {
//        
//        //在此方法中进行,弹出气泡view(LMWPopBottomView)，以及在view中添加自己的view
//        print("点击泡" + selected.description)
//        print("self" + self.isSelected.description)
//        
//
//        if(self.isSelected == selected){
//            return;
//        }
//        
//        if (selected) {
//            if (self.popBottomView == nil) {
//                self.popBottomView =  LMWPopBottomView(frame: self.view.bounds)
//                popBottomView.delegate = self
//                popBottomView.showInView(self.view)
//            }
//        }
//        
//    }
    
}
