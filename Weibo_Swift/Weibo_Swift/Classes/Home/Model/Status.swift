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
    var created_at :String? ///创建时间
    var source:String?      ///创建来源
    var text:String?        ///微博正文
    var mid:String?         ///id

    
    // MARK:-- 自定义构造函数
    init(dict:[String : AnyObject]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    
    
}
