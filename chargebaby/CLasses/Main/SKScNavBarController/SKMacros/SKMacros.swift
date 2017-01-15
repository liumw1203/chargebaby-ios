//
//  SKMacros.swift
//  SCNavController
//
//  Created by Sukun on 15/9/30.
//  Copyright © 2015年 Sukun. All rights reserved.
//

import UIKit
//获取屏幕大小
let kScreenWidth = UIScreen.main.bounds.size.width
let kScreenHeight = UIScreen.main.bounds.size.height

//获取屏幕大小（不包括状态栏高度）
let viewWidth = UIScreen.main.applicationFrame.size.width
let viewHeight = UIScreen.main.applicationFrame.size.height
/**
 *每个选项的高度
 */
let chargeItemHight:CGFloat = 85

/**
* 屏幕状态栏的高度
*/
let kStateBarHeight:CGFloat = 20
/**
* 系统导航控制器的高度
*/
let kNavBarHeight:CGFloat = 44
/**
* 展开扩展菜单按钮的宽度
*/
let kArrowButtonWidth:CGFloat = 44     //可以在这改变导航栏的高度
/**
* 自定义滑动导航栏的高度
*/
let kScNavBarHeight = kArrowButtonWidth
/**
* 自定义导航栏的颜色
*/
let kNavColor = UIColor.white   //这个是在不设置自定义导航栏的颜色时的默认颜色

class SKMacros: NSObject {

}
