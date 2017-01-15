//
//  LMWNavigationController.swift
//  chargebaby
//
//  Created by 刘明伟 on 2016/11/10.
//  Copyright © 2016年 刘明伟. All rights reserved.
//

import UIKit

class LMWNavigationController: UINavigationController {

    override class func initialize() {
        super.initialize()
        let navBar = UINavigationBar.appearance()
        navBar.barTintColor = UIColor.white
        navBar.tintColor = LMWColor(0, g: 0, b: 0, a: 0.7)
        navBar.titleTextAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 20)]
//        navBar.backItem?.leftBarButtonItem?.title
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "Lefterbackicon_Titlebar_28x28_"), style: .plain, target: self, action: #selector(navigationBack))
        }
        super.pushViewController(viewController, animated: true)
    }
    
    func navigationBack() {
        popViewController(animated: true)
    }
}



