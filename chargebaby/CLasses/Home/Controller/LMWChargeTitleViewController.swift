//
//  LMWChargeTitleViewController.swift
//  chargebaby
//
//  Created by 刘明伟 on 2016/12/31.
//  Copyright © 2016年 刘明伟. All rights reserved.
//

import UIKit

class LMWChargeTitleViewController: UIViewController , SKScNavBarDelegate, UIScrollViewDelegate, LMWChargeDetailViewDelegate {

    //MARK:必须设置的一些属性
    /**
     * @param scNaBarColor
     * @param showArrowButton
     * @param lineColor
     */
    //MARK: -- 公共设置属性
    /**
     * 是否显示扩展按钮
     */
    var showArrowButton:Bool!         // 默认值是true
    /**
     * 导航栏的颜色
     */
    var scNavBarColor:UIColor!        //默认值clearColor
    /**
     * 扩展按钮上的图片
     */
    var scNavBarArrowImage:UIImage!
    /**
     * 包含所有子视图控制器的数组
     */
    var subViewControllers:NSArray!
    /**
     * 线的颜色
     */
    var lineColor:UIColor!           //默认值redColor
    
    /**
     * 扩展菜单栏的高度
     */
    var launchMenuHeight:CGFloat!
    
    //MARK: -- 私有属性
    fileprivate var currentIndex:Int!       //当前显示的页面的下标
    fileprivate var titles:NSMutableArray!  //子视图控制器的title数组
    fileprivate var scNavBar:SKScNavBar!    //导航栏视图
    fileprivate var mainView:UIScrollView!  //主页面的ScrollView
    fileprivate var chargeNameView:UIView!  //名称
    fileprivate var chargeNameTF:UITextField!
    fileprivate var chargeAddressView:UIView! //地址

    var chargeDetail = UIView.loadFromNibNamed("LMWChargeDetailView") as! LMWChargeDetailView
    

    //charge详细信息
    var charge:[String:Any]!

    //MARK: ----- 方法 -----
    
    //MARK: -- 外界接口
    
    /**     * 初始化withShowArrowButton
     * @param showArrowButton 显示扩展菜单按钮
     */
    init(show:Bool){
        super.init(nibName: nil, bundle: nil)
        self.showArrowButton = show
    }
    
    /**
     * 初始化withSubViewControllers
     * @param subViewControllers 子视图控制器数组
     */
    init(subViewControllers:NSArray, charge: [String:Any]) {
        super.init(nibName: nil, bundle: nil)
        self.subViewControllers = subViewControllers
        self.charge = charge
    }
    
    /**
     * 初始化withParentViewController
     * @param parentViewController 父视图控制器
     */
    init(parentViewController:UIViewController) {
        super.init(nibName: nil, bundle: nil)
        self.addParentController(parentViewController)
    }
    
    /**
     * 初始化SKScNavBarController
     * @param subViewControllers   子视图控制器
     * @param parentViewController 父视图控制器
     * @param show 是否显示展开扩展菜单栏按钮
     */
    init(subViewControllers:NSArray, parentViewController:UIViewController, show:Bool) {
        super.init(nibName: nil, bundle: nil)
        self.subViewControllers = subViewControllers
        self.showArrowButton = show
        self.addParentController(parentViewController)
    }
    /**
     * 添加父视图控制器的方法
     * @param viewController 父视图控制器
     */
    func addParentController(_ viewcontroller:UIViewController) {
        if viewcontroller.responds(to: #selector(getter: UIViewController.edgesForExtendedLayout)) {
            viewcontroller.edgesForExtendedLayout = UIRectEdge()
        }
        
        viewcontroller.addChildViewController(self)
        viewcontroller.view.addSubview(self.view)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        chargeDetail = UIView.loadFromNibNamed("LMWChargeDetailView") as! LMWChargeDetailView
        chargeDetail.delegate = self


        //调用初始化属性的方法
        initParamConfig()
        //调用初始化、配置视图的方法
        viewParamConfig()
    }
    
    //导航
    func nav(name:String, latitude:Double, longitude:Double) {
        print("测试导航按钮" + "name =" + name   )
        
        LMWTools().nav(controller: self, name: name, latitude: latitude, longitude: longitude)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    //MARK: -- 私有方法
    
    //初始化一些属性
    fileprivate func initParamConfig() {
        //初始化一些变量
        currentIndex = 1
        scNavBarColor = scNavBarColor != nil ? scNavBarColor : kNavColor
        if scNavBarArrowImage == nil {
            scNavBarArrowImage = UIImage(named: "arrow.png")
        }
        if showArrowButton == nil {
            showArrowButton = true
        }
        if lineColor == nil {
            lineColor = UIColor.blue
        }
        //获取所有子视图控制器上的title
        titles = NSMutableArray(capacity: subViewControllers.count)
        for vc in subViewControllers {
            titles.add((vc as AnyObject).navigationItem.title!)
        }
    }
    
    //初始化视图
    fileprivate func initWithScNavBarAndMainView() {
        //        let chargeName = UIView.ini
        chargeNameView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: chargeItemHight))
//        chargeNameView.ad
        
//        let t = chargeNameView.frame.maxY
        scNavBar = SKScNavBar(frame: CGRect(x: 0, y: chargeNameView.frame.maxY, width: kScreenWidth, height: kScNavBarHeight), show: showArrowButton, image: scNavBarArrowImage)
        scNavBar.delegate = self
        scNavBar.backgroundColor = scNavBarColor
        scNavBar.itemsTitles = titles
        scNavBar.lineColor = lineColor
        scNavBar.setItemsData()
        
        
        mainView = UIScrollView(frame: CGRect(x: 0, y: scNavBar.frame.origin.y + scNavBar.frame.size.height, width: kScreenWidth, height: kScreenHeight - scNavBar.frame.origin.y - scNavBar.frame.size.height - 60))
        
        mainView.delegate = self
        mainView.isPagingEnabled = true // 分页显示效果
        mainView.bounces = false // 反弹效果，即在最顶端或最底端时，仍然可以滚动，且释放后有动画返回效果
        mainView.showsHorizontalScrollIndicator = false // 显示水平滚动条
        mainView.contentSize = CGSize(width: kScreenWidth * CGFloat(subViewControllers.count), height: 0)
        view.addSubview(mainView)
        view.addSubview(scNavBar)
        view.addSubview(chargeNameView)
    }
    
    //配置视图参数
    fileprivate func viewParamConfig() {
        
        initWithScNavBarAndMainView()
        
        //将子视图控制器的view添加到mainView上
        subViewControllers.enumerateObjects({ (_, index:Int, _) -> Void in
            let vc = self.subViewControllers[index] as! UIViewController
           
            
            if(index == 0){
                if(charge["ac_builded"] != nil){
                    chargeDetail.chargeACBuildedTF.text = String(charge["ac_builded"] as!Int)
                }
                
                if(charge["ac_building"] != nil){
                    chargeDetail.chargeACBuildingTF.text = String(charge["ac_building"] as! Int)
                }
                
                if(charge["dc_builded"] != nil){
                    chargeDetail.chargeDCBuildedTF.text = String(charge["dc_builded"] as! Int)
                }
                
                if(charge["dc_building"] != nil){
                    chargeDetail.chargeDCBuildingTF.text = String(charge["dc_building"] as! Int)
                }
                
                if(charge["begin_time"] != nil){
                
                    chargeDetail.chargeBeginTimeLabel.text = charge["begin_time"] as?String
                }
                
                if(charge["tel"] != nil){
                    
                    chargeDetail.chargeTelLabel.text = charge["tel"] as?String
                }
                
                if(charge["standard_name"] != nil){
                    
                    chargeDetail.chargeStandardNameLabel.text = charge["standard_name"] as?String
                }
                
                if(charge["detail"] != nil){
                    
                    chargeDetail.chargeDetailLabel.text = charge["detail"] as?String
                }
                
                if(charge["fee_standard"] != nil){
                    
                    chargeDetail.chargeFeeStandardLabel.text = charge["fee_standard"] as?String
                }
                
                if( charge["depart"] != nil){
                    chargeDetail.chargeDepartLabel.text = charge["depart"] as?String
                    
                }
                
                self.mainView.addSubview(chargeDetail.chargeDetailView)
//                self.mainView.addSubview(chargeDetail.chargeNavView)
                self.mainView.insertSubview(chargeDetail.chargeNavView, belowSubview: chargeDetail.chargeDetailView)
                
                chargeDetail.chargeDetailView.snp.makeConstraints { (make) in
                    make.top.equalToSuperview()
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
                    make.bottom.equalTo(self.mainView.frame.height)
                    
//                    let i = self.navigationController?.navigationBar.frame.height
                }
                
                
                
                
            }else if (index == 1){
//                initChargeDianping(vc)
//                vc.view.frame = CGRect(x: CGFloat(index) * kScreenWidth, y: 0, width: kScreenWidth, height: self.mainView.frame.size.height)
//                
//                self.mainView.addSubview(vc.view)
//                self.mainView.backgroundColor = UIColor.white
//                self.addChildViewController(vc)
                let tab = LMWChargeDianpingViewController()
                self.mainView.addSubview(tab.view)
//                self.maianaddChildViewController(tab)
//                chargeDetail.chargeNavView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(LMWChargeDetailView.nav)))
            }
        })
    }
    
    //
    fileprivate func initChargeDetail(){
    }
    
    
    fileprivate func initChargeDianping(){
    
    
    }
    
    //MARK: -- ScrollView Delegate 方法
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        currentIndex = Int(scrollView.contentOffset.x / kScreenWidth)
        scNavBar.setViewWithItemIndex = currentIndex
    }
    
    //MARK: -- SKScNavBarDelegate 中的方法
    func didSelectedWithIndex(_ index: Int) {
        mainView.setContentOffset(CGPoint(x: CGFloat(index) * kScreenWidth, y: 0), animated: true)
    }
    
    func isShowScNavBarItemMenu(_ show: Bool, height: CGFloat) {
        if show {
            UIView.animate(withDuration: 0.5, animations: { () -> Void in
                self.scNavBar.frame = CGRect(x: self.scNavBar.frame.origin.x, y: self.scNavBar.frame.origin.y, width: kScreenWidth, height: height)
            })
        }else{
            UIView.animate(withDuration: 0.5, animations: { () -> Void in
                self.scNavBar.frame = CGRect(x: self.scNavBar.frame.origin.x, y: self.scNavBar.frame.origin.y, width: kScreenWidth, height: kScNavBarHeight)
            })
        }
        scNavBar.refreshAll()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
