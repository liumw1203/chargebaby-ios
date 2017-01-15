//
//  LMWPopBottomView.swift
//  chargebaby
//
//  Created by 刘明伟 on 2016/12/28.
//  Copyright © 2016年 刘明伟. All rights reserved.
//

import UIKit


@objc protocol LMWPopBottomViewDelegate{
    /**
     页面弹出来的时候
     */
    @objc optional func viewWillAppear()
    
    /**
     页面消失的时候
     */
    @objc optional func viewWillDisappear()
    
    //导航
    @objc optional func nav(name:String, latitude:Double, longitude:Double)
    
    //传值
    @objc optional func sendPopViewMessage(charge_no:String, name:String,address:String, price:String, ac:Int, dc:Int, distance:Double)
    
    //跳转到详情页面
    @objc optional func gotoChargeStoryboard(gotoCScharge_no:String)
    //处理收藏按钮
    @objc optional func favorite(chargeNo:String, isFavorite:Bool, popBottomView:LMWPopBottomView)

}


class LMWPopBottomView: UIView {

    var delegate:LMWPopBottomViewDelegate?
    var isFavorite:Bool = false

    /**charge中的数据*/
    //编码
    var charge_no:String?
    //充电点名称
    var name:String?
    //地址
    var address:String?
    //价格
    var price:String?
    //直流
    var ac:Int?
    //交流
    var dc:Int?
    //经度
    var longitude:Double?
    //纬度
    var latitude:Double?
    
    /**设置popView*/
    let bottomView = UIView.loadFromNibNamed("BottomView") as! BottomView
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
 
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    fileprivate func setupViews(){
        delegate?.viewWillAppear?()
    }
    
    fileprivate func displayViews(){
        delegate?.viewWillDisappear!()
    }
    
    func nav(){
         delegate?.nav!(name: name!, latitude: latitude!, longitude: longitude!)
        hideView()
    }
    func gotoChargeStoryboard() {
        delegate?.gotoChargeStoryboard!(gotoCScharge_no:charge_no!)
        hideView()
    }
    func favorite(){
//        isFavorite = GetDataFromRemote.isFavorite(chargeNo: charge_no!, favorites: (LMWGlobalUserInfo?.favoriteList)!)
        if (LMWGlobalIsLogin) {
            
            delegate?.favorite!(chargeNo:charge_no!, isFavorite: isFavorite, popBottomView:self)
        }else{
            LMWTools.showLoginAlert()
        }
    }
    
    func showInView(_ view:UIView){
        //将背景设为按钮，即下面popview外的区域
        var bgButton:UIButton?
        bgButton = UIButton(frame: self.bounds)
        bgButton!.tag = 300
        bgButton!.backgroundColor = UIColor.lightGray
        //设置alpha＝0就相当于设置了hidden ＝ YES
        bgButton!.alpha = 0.0
        bgButton!.addTarget(self, action: #selector(LMWPopBottomView.hideView), for: .touchUpInside)
        self.addSubview(bgButton!)
        setupViews()

       
        //配置导航
        bottomView.navView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(LMWPopBottomView.nav)))
        //配置详情
        bottomView.chargeDetailView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(LMWPopBottomView.gotoChargeStoryboard)))
        
        //配置点评
        bottomView.dianpingView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(LMWPopBottomView.gotoChargeStoryboard)))
        
        //配置收藏
        bottomView.myFavoriteView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(LMWPopBottomView.favorite)))
        
        if (isFavorite) {
            bottomView.myFavoriteIV.image = FAVORITE_RED_IMG
        }else{
            bottomView.myFavoriteIV.image = FAVORITE_WHITE_IMG
        }
        bottomView.tag = 200
        var frame  = self.bounds
        frame.size.height = 250.0
        bottomView.frame = frame
        bottomView.frame.origin.y = self.bounds.maxY
        bottomView.chargeNameTF.text = name
        bottomView.chargePriceTF.text = price
        bottomView.chargeAddressTV.text = address
        bottomView.chargeACTF.text = ac?.description
        bottomView.chargeDCTF.text = dc?.description
        
        self.addSubview(bottomView)
        
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            if let btn = bgButton {
                btn.alpha = 0.5
            }
            var frame = self.bottomView.frame
            frame.origin.y = self.frame.size.height - frame.height
            self.bottomView.frame = frame
        })
        
        view.addSubview(self)
    }
    
    /**
     隐藏View
     */
    func hideView(){
        self.displayViews()
        var btn = UIButton()
        var view = UIView()
        for v in self.subviews {
            if v.tag == 300 {
                btn = v as! UIButton
            }
            
            if v.tag == 200 {
                view = v
            }
            
        }
        
  
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            btn.alpha = 0
            var frame = view.frame
            frame.origin.y = self.bounds.maxY
            view.frame = frame
            
        }, completion: { (finished) -> Void in
            btn.removeFromSuperview()
            view.removeFromSuperview()
            self.removeFromSuperview()
        })
        }
    
   

}
