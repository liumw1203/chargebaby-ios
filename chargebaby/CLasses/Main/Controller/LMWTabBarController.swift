//
//  LMWTabBarController.swift
//  chargebaby
//
//  Created by 刘明伟 on 2016/11/10.
//  Copyright © 2016年 刘明伟. All rights reserved.
//

import UIKit

@available(iOS 9.0, *)
class LMWTabBarController: UITabBarController {
    
    var homeVC: LMWHomeViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = UIColor(red: 245 / 255, green: 80 / 255, blue: 83 / 255, alpha: 1.0)
        
//        initViewController()
        addChildViewControllers()
    }
    
    
    /**
     *初始化内容区
     */
    func initViewController() {
        //附近
//     let homeController = LMWHomeViewController()
//        homeController.tabBarItem.image = UIImage(named: "TabBar_Home_23x23_")
//        homeController.tabBarItem.selectedImage = UIImage(named: "TabBar_Home_23x23_selected")
//        homeController.title = "附近"
//        let homeController = UIStoryboard.init(name: "LMWHomeViewStoryboard", bundle: nil).instantiateInitialViewController() as! UINavigationController
        
        let homeController = UIStoryboard.init(name: "LMWHomeViewStoryboard", bundle: nil).instantiateInitialViewController() as! UINavigationController
        homeVC = homeController.childViewControllers[0] as? LMWHomeViewController
        homeController.tabBarItem.image = originalWithImage(imageName: "TabBar_Home_23x23_")
        
                homeController.tabBarItem.selectedImage = originalWithImage(imageName: "TabBar_Home_23x23_selected")
        
//        我的
        let mineViewController = UIStoryboard.init(name: "LMWMineViewStoryboard", bundle: nil).instantiateInitialViewController() as! UINavigationController

        mineViewController.tabBarItem.image = originalWithImage(imageName: "TabBar_Mine_23x23_")
        mineViewController.tabBarItem.selectedImage = originalWithImage(imageName: "TabBar_Mine_23x23_selected")
        
//        let mineViewController = LMWMineViewController()
        
//        mineViewController.tabBarItem.image = UIImage(named: "TabBar_Mine_23x23_")
//        mineViewController.tabBarItem.selectedImage = UIImage(named: "TabBar_Mine_23x23_selected")
//        mineViewController.title = "我的"
//        
        let tabBarControllers = [homeController, mineViewController]
        
        self.setViewControllers(tabBarControllers, animated: true)
    }
  
//    
//    func addChildViewController(_ childController: UIViewController, title: String, imageName: String, selectedImageName: String) {
//
//        childController.tabBarItem.image = originalWithImage(imageName: imageName)
//        childController.tabBarItem.selectedImage = originalWithImage(imageName: selectedImageName)
//        childController.title = title
//        let nav = LMWNavigationController(rootViewController: childController)
//        addChildViewController(nav)
//    }
    
    //传入一张图片的名称返回一张未被渲染的图片
    func originalWithImage(imageName: String) -> UIImage {
        let imageN = UIImage(named: imageName)
        return imageN!.withRenderingMode(UIImageRenderingMode.alwaysOriginal);
    }
    
    
    
    /// 添加所有子控制器
    private func addChildViewControllers() {
        setChildrenController(title: "附近", image: UIImage(named: "TabBar_Home_23x23_")!, selectedImage: UIImage(named: "TabBar_Home_23x23_selected")!, storyboard: UIStoryboard(name: "LMWHomeViewStoryboard", bundle: nil))
        
        setChildrenController(title: "我的", image: UIImage(named: "TabBar_Mine_23x23_")!, selectedImage: UIImage(named: "TabBar_Mine_23x23_selected")!, storyboard: UIStoryboard(name: "LMWMineViewStoryboard", bundle: nil))
        
    }
    
    /// 添加一个子控制器
    private func setChildrenController(title:String, image:UIImage,selectedImage:UIImage, storyboard:UIStoryboard) {
        let controller = storyboard.instantiateInitialViewController()!
        controller.tabBarItem.title = title
        controller.tabBarItem.image = image
        controller.tabBarItem.selectedImage = selectedImage
        addChildViewController(controller)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
