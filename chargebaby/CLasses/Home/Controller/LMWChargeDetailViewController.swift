//
//  LMWChargeDetailViewController.swift
//  chargebaby
//
//  Created by 刘明伟 on 2016/12/30.
//  Copyright © 2016年 刘明伟. All rights reserved.
//

import UIKit

class LMWChargeDetailViewController: UIViewController {
    @IBOutlet weak var sliderView: UIView!
    var sliderImageView: UIImageView!
    
    @IBOutlet weak var chargeNameLabel: UILabel!
    @IBOutlet weak var chargeAddressLabel: UILabel!
 
    @IBOutlet weak var dianpingButton: UIButton!
    @IBOutlet weak var detailButton: UIButton!
    var pageViewController: UIPageViewController!
    var detailController: LMWDetailViewController!
    var commentController: LMWCommentViewController!
    var controllers = [UIViewController]()
    var lastPage = 0
    
    var charge_no:String!
    var charge :Charge!
    var isFavorite:Bool = false
    
    
    var favoriteButton:UIButton!
    
    //点击评论
    @IBAction func clickComment(_ sender: Any) {
        currentPage = 1
    }
    //点击详情
    @IBAction func clickDetail(_ sender: Any) {
        currentPage = 0
    }
    var currentPage: Int = 0 {
        didSet {
            //根据当前页面计算得到便宜量
            //一个微小的动画移动提示条
            let offset = self.view.frame.width / 2.0 * CGFloat(currentPage)
            UIView.animate(withDuration: 0.2, animations: { () -> Void in
                self.sliderImageView.frame.origin = CGPoint(x: offset, y: -1)
            })
            
            if currentPage > lastPage {
                self.pageViewController.setViewControllers([controllers[currentPage]], direction: .forward, animated: true, completion: nil)
            }
            else {
                self.pageViewController.setViewControllers([controllers[currentPage]], direction: .reverse, animated: true, completion: nil)
            }
            
            lastPage = currentPage
        }
    }
   
    //按钮功能
    @IBAction func changeCurrentPage(_ sender: UIButton) {
        //button的tag分别为100，101，减去100之后就对应页面的索引
        print(sender.tag)
        currentPage = sender.tag - 100

    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        //防止两个按钮同时点击
        detailButton.isExclusiveTouch = true
        dianpingButton.isExclusiveTouch = true
//        favoriteButton.isExclusiveTouch = true
        //获取是否已经收藏
        isFavorite = GetDataFromRemote.isFavorite(chargeNo: charge_no!, favorites: (LMWGlobalUserInfo?.favoriteList)!)
        
        favoriteButton = UIButton(frame:CGRect(x:0, y:0, width:30, height:30))
        if (self.isFavorite) {
            favoriteButton.setImage(FAVORITE_RED_IMG, for: .normal)
        }else{
            favoriteButton.setImage(FAVORITE_WHITE_IMG, for: .normal)
        }
        favoriteButton.addTarget(self,action: #selector(LMWChargeDetailViewController.favorite),for:.touchUpInside)
        
        let rightBarBI = UIBarButtonItem(customView: favoriteButton)
        self.navigationItem.rightBarButtonItem = rightBarBI
        

        let chargedic = LMWDataBaseTools.getChargeByNo(chargeNo: charge_no)
        charge = LMWDataBaseTools.chargedicTransCharge(chargedic: chargedic)

        chargeNameLabel.text = charge.name
        chargeAddressLabel.text = charge.address
        //获取到嵌入的UIPageViewController
        pageViewController = self.childViewControllers.first as! UIPageViewController
        
        //根据Storyboard ID来创建一个View Controller
        detailController = storyboard?.instantiateViewController(withIdentifier: "detailStoryboard") as! LMWDetailViewController
        detailController.charge = charge
        commentController = storyboard?.instantiateViewController(withIdentifier: "commentStoryboard") as! LMWCommentViewController
        commentController.chargeNo = charge_no
        
        //设置pageViewController的数据源代理为当前Controller
        pageViewController.dataSource = self
        
        //手动为pageViewController提供提一个页面
        pageViewController.setViewControllers([detailController], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)
        
        //添加提示条到页面中
        sliderImageView = UIImageView(frame: CGRect(x: 0, y: -1, width: self.view.frame.width / 2.0, height: 2.0))
        sliderImageView.image = UIImage(named: "slider")
        sliderView.addSubview(sliderImageView)
        
        //把页面添加到数组中
        controllers.append(detailController)
        controllers.append(commentController)
        
        //接收页面改变的通知
        NotificationCenter.default.addObserver(self, selector: #selector(LMWChargeDetailViewController.currentPageChanged(_:)), name: NSNotification.Name(rawValue: "currentPageChanged"), object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.hidesBottomBarWhenPushed = true
    }
    
    
    //通知响应方法
    func currentPageChanged(_ notification: Notification) {
        currentPage = notification.object as! Int
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //收藏
    @objc fileprivate func favorite(){
        //检查网络
        LMWTools.checkConnectNet(controller: self)
        
        if (self.isFavorite){
            //已经收藏，取消收藏
            
            // 启动线程执行下载任务
            
                print("开始执行异步任务")
                let result = GetDataFromRemote.removeFavorite(userId: (LMWGlobalUserInfo?.id!)!, chargeNo: self.charge_no)
                if(result){
                    self.favoriteButton.setImage(FAVORITE_WHITE_IMG, for: .normal)
                    self.isFavorite = false
                    let alertController = UIAlertController(title: "取消收藏成功",
                                                            message: nil, preferredStyle: .alert)
                    //显示提示框
                    self.present(alertController, animated: true, completion: nil)
                }else{
                    let alertController = UIAlertController(title: "取消收藏失败",
                                                            message: nil, preferredStyle: .alert)
                    //显示提示框
                    self.present(alertController, animated: true, completion: nil)
                }
//                Thread.sleep(forTimeInterval: 2)
                print("异步任务执行完毕")//一秒钟后自动消失
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    
                    
                    self.presentedViewController?.dismiss(animated: false, completion: nil)
                }
            
            
            
            
        }else {
            //还未收藏，添加收藏
            print("开始执行异步任务")
            let result = GetDataFromRemote.addFavorite(userId: (LMWGlobalUserInfo?.id!)!, chargeNo: charge_no)
            if(result){
                self.favoriteButton.setImage(FAVORITE_RED_IMG, for: .normal)
                self.isFavorite = true
                let alertController = UIAlertController(title: "添加收藏成功",
                                                        message: nil, preferredStyle: .alert)
                //显示提示框
                self.present(alertController, animated: true, completion: nil)
            }else{
                let alertController = UIAlertController(title: "添加收藏失败",
                                                        message: nil, preferredStyle: .alert)
                //显示提示框
                self.present(alertController, animated: true, completion: nil)
            }
//            Thread.sleep(forTimeInterval: 1)
            print("异步任务执行完毕")//一秒钟后自动消失
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                
                self.presentedViewController?.dismiss(animated: false, completion: nil)
            }
            
        }
        
        }
    
    }




extension LMWChargeDetailViewController: UIPageViewControllerDataSource {
    
    //返回当前页面的下一个页面
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        if viewController.isKind(of: LMWDetailViewController.self) {
            return commentController
        }
        return nil
    }
    
    //返回当前页面的上一个页面
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        if viewController.isKind(of: LMWCommentViewController.self) {
            return detailController
        }
        return nil
    }
}

