//
//  UserAccount.swift
//  TFWeibo_Swift
//
//  Created by Tengfei on 16/2/20.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class UserAccount: NSObject {
//    "access_token": "ACCESS_TOKEN",
//    "expires_in": 1234,
//    "remind_in":"798114",
//        "uid":"12341234"
    
    var access_token:String?
    var expires_in:String?
    var uid:String?
    
    init(dict:[String:AnyObject]){
        
    }
    
    override var description:String{
        return access_token! + expires_in! + uid!
    }
}
