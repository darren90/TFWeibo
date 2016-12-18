//
//  UserAccount.swift
//  Weibo_Swift
//
//  Created by Tengfei on 2016/12/16.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class UserAccount: NSObject {

//    "access_token": "ACCESS_TOKEN",
//    "expires_in": 1234,
//    "remind_in":"798114",
//    "uid":"12341234"
    ///授权后的Token
    var access_token : String?
    ///过期秒
    var expires_in : TimeInterval = 0.0 {
        didSet {
            expires_date = NSDate(timeIntervalSinceNow: expires_in)
        }
    }
    ///用户秒
    var uid : String?
    
    ///另外添加的属性 -- 过期时间
    var expires_date : NSDate?
    
    
    ///再次新加的属性 -- 用户信息
    var screen_name : String?
    var avatar_large : String?
    
    ///重写属性
    override var description: String {
        return dictionaryWithValues(forKeys: ["access_token","expires_date","uid","screen_name","avatar_large"]).description
    }
    
    override init() {
        super.init()
    }
    
    init(dict:[String:AnyObject]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    
    
}
