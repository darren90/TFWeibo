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
    var expires_in:NSNumber?
    var uid:String?
    
    init(dict:[String:AnyObject]){
        self.access_token = dict["access_token"] as? String
        self.expires_in = dict["expires_in"] as? NSNumber
        self.uid = dict["uid"] as? String
    }
    
    override var description:String{
        return access_token! + String(expires_in!) + uid!
    }
}
