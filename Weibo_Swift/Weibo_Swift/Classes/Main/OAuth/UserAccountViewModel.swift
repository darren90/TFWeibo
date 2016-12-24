//
//  UserAccountTool.swift
//  Weibo_Swift
//
//  Created by Tengfei on 2016/12/21.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit


//MARK: --- 视图模型，

class UserAccountViewModel {
    
    // MARK:-- 类--》单类
    
    static let shareInstance : UserAccountViewModel = UserAccountViewModel()

    // MARK:-- 计算属性
    var accountPath :String {
        var accountPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        accountPath = (accountPath as NSString).appendingPathComponent("account.plist")
        
        return accountPath
    }
    
    var account:UserAccount?
    
    var isLogin : Bool {
        if account == nil {
            return false
        }
        
        guard let expireDate = account?.expires_date else {
            return false
        }
        return  expireDate.compare(Date()) == .orderedDescending
    }
    
    //保证创建出来的对象，就从沙盒中读取了信息
    init() {
        
        account = NSKeyedUnarchiver.unarchiveObject(withFile: accountPath) as? UserAccount
        print("access_token:\(account?.access_token))")
    }

    // MARK:-- 判断是否登陆了
//    func isLogin() -> Bool {
//    }
}
