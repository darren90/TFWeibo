//
//  MainTabBarController.swift
//  TFWeibo_Swift
//
//  Created by Tengfei on 16/2/16.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
            addComposeBtn()
    }
    
    private func addComposeBtn(){
        tabBar.addSubview(composeBtn)
        
        let w = UIScreen.mainScreen().bounds.size.width / CGFloat((viewControllers?.count)!)
        let rect = CGRect(x: 0, y: 0, width: w, height: 49)
        composeBtn.frame = CGRectOffset(rect, w*2, 0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置控制器tabbar的颜色,：在iOS7以前如果设置了tintcolor只会是文字变，图片不会变
        tabBar.tintColor = UIColor.orangeColor()
        
        
        //冲json文件中动态加载tabbar
        let path = NSBundle.mainBundle().pathForResource("MainVCSettings.json", ofType: nil)
        if let jsonPath = path{
            let jsonData = NSData(contentsOfFile: jsonPath)
            
            do{//有可能发生异常的代码
                //try：发成异常，会跳到catch后继续执行
                //try!:发生异常，直接奔溃
                let dictArr = try NSJSONSerialization.JSONObjectWithData(jsonData!, options: .MutableContainers)
                
                //Swift中，遍历数据，必须明确数组的类型
                for dict in dictArr as![[String:String]] {
                    addChildViewController(dict["vcName"]!, title: dict["title"]!, imageName: dict["imageName"]!)
                }
                
            }catch{//发生异常之后会执行的代码
                print(error)

                addChildViewController("HomeTableViewController", title: "首页", imageName: "tabbar_home")
                addChildViewController("MessageTableViewController", title: "消息", imageName: "tabbar_message_center")
                addChildViewController("NullViewController", title: "", imageName: "")
                addChildViewController("DiscoverTableViewController", title: "广场", imageName: "tabbar_discover")
                addChildViewController("MeTableViewController", title: "我", imageName: "tabbar_profile")
                //        addChildViewController(HomeTableViewController(), title: "首页", imageName: "")

            }
            
        }
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
 

    
    
    //懒加载精简
    private lazy var composeBtn:UIButton = {
        let btn = UIButton()
        
        //
        btn.setImage(UIImage(named: "tabbar_compose_icon_add"), forState: .Normal)
        btn.setImage(UIImage(named: "tabbar_compose_icon_add_highlighted"), forState: .Highlighted)
        
        btn.setBackgroundImage(UIImage(named: "tabbar_compose_button"), forState: .Normal)
        btn.setBackgroundImage(UIImage(named: "tabbar_compose_button_highlighted"), forState: .Highlighted)
        btn.addTarget(self, action: "composeBtnDidClick", forControlEvents: .TouchUpInside)
        
        return btn
    }()
    
    //“+”按钮被点击
    //监听按钮点击的方法不能是私有的
    func composeBtnDidClick(){
        print(__FUNCTION__)
    }
}
