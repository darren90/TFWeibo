//
//  UserAccountTool.swift
//  Weibo_Swift
//
//  Created by Tengfei on 2016/12/21.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class UserAccountTool {

    // MARK:-- 计算属性
    var accountPath :String {
        var accountPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        accountPath = (accountPath as NSString).appendingPathComponent("account.plist")
        
        return accountPath
    }
    
    
    //保证创建出来的对象，就从沙盒中读取了信息
    init() {
        
        let account = NSKeyedUnarchiver.unarchiveObject(withFile: accountPath) as? UserAccount
        
        if let account = account {
            if let expireDate = account.expires_date {
                isLogin = (expireDate.compare(Date()) == .orderedDescending)
            }
            
            isLogin = true
        }
        
    }
    
    
    
}
