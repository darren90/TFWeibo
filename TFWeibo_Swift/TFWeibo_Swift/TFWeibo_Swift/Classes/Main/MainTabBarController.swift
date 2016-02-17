//
//  MainTabBarController.swift
//  TFWeibo_Swift
//
//  Created by Tengfei on 16/2/16.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //设置控制器tabbar的颜色,：在iOS7以前如果设置了tintcolor只会是文字变，图片不会变
        tabBar.tintColor = UIColor.orangeColor()
                
        addChildViewController("HomeTableViewController", title: "首页", imageName: "tabbar_home")
        addChildViewController("MessageTableViewController", title: "消息", imageName: "tabbar_message_center")
        addChildViewController("DiscoverTableViewController", title: "广场", imageName: "tabbar_discover")
        addChildViewController("MeTableViewController", title: "我", imageName: "tabbar_profile")
//        addChildViewController(HomeTableViewController(), title: "首页", imageName: "")
    }
    
    /**
     初始化子控制器
     
     :param: childController <#childController description#>
     :param: title           <#title description#>
     :param: imageName       <#imageName description#>
     */
//    private func addChildViewController(childController: UIViewController,title:String,imageName:String) 
    private func addChildViewController(childControllerName: String,title:String,imageName:String) {
//        print(childController)
        //1:创建首页
        //<TFWeibo_Swift.HomeTableViewController: 0x7fa5cb50d3c0>
        //命名空间默认情况下是项目的名称，但是命名空间的名称可以修改
        
        //获取命名空间
        let ns = NSBundle.mainBundle().infoDictionary!["CFBundleExecutable"] as! String
        
        let cls:AnyClass? = NSClassFromString(ns + "." + childControllerName)
        
        let clsVc  = cls as! UIViewController.Type
        let childController = clsVc.init()
        
        childController.tabBarItem.image = UIImage(named: imageName)
        childController.tabBarItem.selectedImage = UIImage(named: imageName+"_highlighted")
        childController.title = title
        let nav = UINavigationController(rootViewController: childController)
        addChildViewController(nav)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 

}
