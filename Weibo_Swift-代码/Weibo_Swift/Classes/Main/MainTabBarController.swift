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
//        addChildViewController(vc: HomeViewController(), title: "首页", imgaeName: "tabbar_home")
//        addChildViewController(vc: MessageViewController(), title: "消息", imgaeName: "tabbar_message_center")
//        addChildViewController(vc: DiscoverViewController(), title: "发现", imgaeName: "tabbar_discover")
//        addChildViewController(vc: HomeViewController(), title: "我", imgaeName: "tabbar_profile")
        
        
        //从json文件中读取控制器
        guard let jsonPath = Bundle.main.path(forResource: "MainVCSettings.json", ofType: nil) else {
            print("没有对象的文件路径")
            return;
        }
        
        //有json，读取json文件中的内容
        guard let jsonData = NSData(contentsOfFile: jsonPath) else{
            print("json文件中的数据为空")
            return
        }
        
        //如果调用某一个方法的时候，最后又throws，说明该方法，会抛出异常，如果一个方法会抛出异常，那么需要对该异常就行处理
        /*
            在Swift中提供了三种的异常处理方式
            方式一：try方式：程序猿手动处理异常 ，返回的是固定类型,-- 不常用
         */
        do {
            try JSONSerialization.jsonObject(with: jsonData as Data, options: .mutableContainers)
        }catch{//这里的error中包含了异常
            print(error)
        }
        
        /*
            方式二：try？方式，系统帮助我们处理异常，如果出现异常，则返回nil，如果没有异常，则返回对应的对象。 比较常用，返回的是可选类型 -- 比较常用
         */
        
         try? JSONSerialization.jsonObject(with: jsonData as Data, options: .mutableContainers)
        
        
        /*
            方式三：try！直接告诉系统，该方法没有异常，但是如果该方法出现了异常，那么长须会报错，--- 不常用
        */
        
        
        //将数据转成数组
        guard let anyObj = try? JSONSerialization.jsonObject(with: jsonData as Data, options: .mutableContainers) else{
            return
        }
        
        guard let dictArray = anyObj as? [[String :AnyObject]] else{
            return
        }
        
        //遍历字段，获取对应的信息，
        for dict in dictArray {
            //获取控制器对应的字符串
//            print(dict)
            guard let vcName = dict["vcName"] as? String else{
                continue
            }
            
            //获取控制器的title
            guard let title = dict["title"] as? String else{
                continue
            }
            
            //获取控制器显示的图标
            guard let imageName = dict["imageName"] as? String else{
                continue
            }
            
            addChildViewController(vcName: vcName, title: title, imgaeName: imageName)
        }
        
    }
    
    
    //Swift支持方法的重载
    //方法的重载：方法名相同，---》1：参数类型不同，2：参数的个数不同
    //private 私有的方法，只能在当前文件中访问
    private func addChildViewController(vcName: String ,title:String,imgaeName:String) {
        //根据字符串获取对应的class，在Swift中不能直接使用
        
        //Swift中命名空间的概念
        //
        guard let nameSpage = Bundle.main.infoDictionary!["CFBundleExecutable"] as? String else {
            print("没有命名空间")
            return
        }
        
        guard let childVcClass = NSClassFromString(nameSpage + "." + vcName) else {
            print("没有获取到对应的class")
            return
        }
        
        guard let childVcType = childVcClass as? UIViewController.Type else {
            print("没有得到对应控制器的类型")
            return
        }
        
        //根据类型创建对应的对象
        let vc = childVcType.init()
        
        //创建子控制器
        vc.title = title
        vc.tabBarItem.image = UIImage(named: imgaeName)
        vc.tabBarItem.selectedImage = UIImage(named: "\(imgaeName)_highlighted")
        let vcNav = UINavigationController(rootViewController: vc)
        addChildViewController(vcNav)
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
