//
//  AppDelegate.swift
//  TFWeibo_Swift
//
//  Created by Tengfei on 16/2/16.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

let SwitchRootViewControllerKey = "SwitchRootViewControllerKey"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        //注册通知
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "switchRootVC", name: SwitchRootViewControllerKey, object: nil)
        
        //设置导航条和工具条的主题
        UINavigationBar.appearance().tintColor = UIColor.orangeColor()
        UITabBar.appearance().tintColor = UIColor.orangeColor()
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.backgroundColor = UIColor.whiteColor()
        window?.rootViewController = defaultController();
        window?.makeKeyAndVisible()
        
        return true
    }
    
    func switchRootVC(){
        window?.rootViewController = MainTabBarController()
    }
    
    private func defaultController() -> UIViewController{
        if UserAccount.useLogin() {
            return isNewVersion() ? NewFeatureViewController() : WelcomeViewController()
        }
        return MainTabBarController()
    }
    
    
    private func isNewVersion() -> Bool{
        let key = "CFBundleShortVersionString"
        let currentVersion = NSBundle.mainBundle().infoDictionary![key] as! String
        let oldVersion = NSUserDefaults.standardUserDefaults().objectForKey(key) as? String ?? ""
        if currentVersion == oldVersion{
            return false
        }else {
            //iOS7以后，不用调用同步方法了
            NSUserDefaults.standardUserDefaults().setObject(currentVersion, forKey: key)
            return true
        }
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

}

