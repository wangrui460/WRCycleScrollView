//
//  AppDelegate.swift
//  WRCycleScrollViewDemo
//
//  Created by wangrui on 2017/5/12.
//  Copyright © 2017年 wangrui. All rights reserved.
//
//  Github地址：https://github.com/wangrui460/WRCycleScrollView

import UIKit

let MainNavBarColor = UIColor.init(red: 0/255.0, green: 175/255.0, blue: 240/255.0, alpha: 1)
let kScreenWidth = UIScreen.main.bounds.width
let kScreenHeight = UIScreen.main.bounds.height
let kTabBarHeight = 49
let kNavBarBottom = 64
let kNavBarHeight = 44

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool
    {
        
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        
        let nav = BaseNavigationController.init(rootViewController: DemoListController())
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        
        setNavBarAppearence()
        
        return true
    }

    func setNavBarAppearence()
    {
        UIColor.defaultStatusBarStyle = .lightContent
        UIColor.defaultNavBarTintColor = UIColor.white
        UIColor.defaultNavBarBarTintColor = MainNavBarColor
        UIColor.defaultNavBarTitleColor = UIColor.white
    }
}

class BaseNavigationController: UINavigationController
{
    override func pushViewController(_ viewController: UIViewController, animated: Bool)
    {
        if childViewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
}
