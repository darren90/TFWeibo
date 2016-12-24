//
//  Status.swift
//  Weibo_Swift
//
//  Created by Tengfei on 2016/12/24.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class Status: NSObject {

    // MARK:-- 属性
    var created_at :String?  ///创建时间
    var source:String?     ///创建来源
    var text:String?        ///微博正文
    var mid:String?         ///id
    var pic_urls:[String:String]?  ///微博图片
    
    var user: User?     ///作者信息
    
    
    // MARK:-- 自定义构造函数
    init(dict:[String : AnyObject]) {
        super.init()
        
        setValuesForKeys(dict)
        
        ///将用户字典，转成用户模型
        if let userdict = dict["user"] as? [String:AnyObject] {
            user = User(dict:userdict)
        }
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    
    
}











