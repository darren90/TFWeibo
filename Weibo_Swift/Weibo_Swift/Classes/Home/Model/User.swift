//
//  User.swift
//  Weibo_Swift
//
//  Created by Tengfei on 2016/12/24.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class User: NSObject {

    var profile_image_url:String?           ///头像
    var screen_name:String?                        ///昵称
    var verified_type:Int = -1              ///认证类型
    var mbrank = 0                      ///会员等级
 

    
    init(dict:[String:AnyObject]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    
    //数据处理
    
}
