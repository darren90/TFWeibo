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
    var verified_type:Int = -1   {            ///认证类型
        didSet {
            switch verified_type {
            case 0:
                verfiedImage = UIImage(named: "avatar_vip")
                break
            case 2,3,5:
                 verfiedImage = UIImage(named: "avatar_enterprise_vip")
                break
            case 220:
                verfiedImage = UIImage(named: "avatar_grassroot")
                break
            default: break
                
            }
        }
    }
    var mbrank = 0   {                       ///会员等级
        didSet {
            if mbrank > 0 && mbrank < 7 {
                vipImage = UIImage(named: "common_icon_membership_level\(mbrank)")
            }
        }
    }
    
    
    // MARK:-- 用户数据处理
    var verfiedImage:UIImage?
    var vipImage:UIImage?
    
    init(dict:[String:AnyObject]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    
    //数据处理
    
}
