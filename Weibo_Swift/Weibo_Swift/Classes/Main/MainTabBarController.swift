//
//  MainTabBarController.swift
//  Weibo_Swift
//
//  Created by Tengfei on 16/11/22.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //默认的颜色
        tabBar.tintColor = UIColor.orange
        
        //创建子控制器
        addChildViewController(vc: HomeViewController(), title: "首页", imgaeName: "tabbar_home")
        addChildViewController(vc: MesssageViewController(), title: "消息", imgaeName: "tabbar_message_center")
        addChildViewController(vc: DiscoverViewController(), title: "发现", imgaeName: "tabbar_discover")
        addChildViewController(vc: HomeViewController(), title: "我", imgaeName: "tabbar_profile")
    }
    
    //Swift支持方法的重载
    //方法的重载：方法名相同，---》1：参数类型不同，2：参数的个数不同
    //private 私有的方法，只能在当前文件中访问
    private func addChildViewController(vc: UIViewController ,title:String,imgaeName:String) {
        //创建子控制器
        vc.title = title
        vc.tabBarItem.image = UIImage(named: imgaeName)
        vc.tabBarItem.selectedImage = UIImage(named: "\(imgaeName)_highlighted")
        let vcNav = UINavigationController(rootViewController: vc)
        addChildViewController(vcNav)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
