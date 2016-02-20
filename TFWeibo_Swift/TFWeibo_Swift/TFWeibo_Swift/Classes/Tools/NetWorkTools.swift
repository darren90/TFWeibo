//
//  NetWorkTools.swift
//  TFWeibo_Swift
//
//  Created by Tengfei on 16/2/20.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit
import AFNetworking

class NetWorkTools: AFHTTPSessionManager {
 
    static let tools :NetWorkTools = {
        let t = NetWorkTools(baseURL: NSURL(string: "https://api.weibo.com/"))
        //设置afn能够接收的数据类型
        t.responseSerializer.acceptableContentTypes = NSSet(objects: "application/json", "text/json", "text/javascript", "text/plain") as! Set<String>
        return t
    }()
    
    class func shareNetWorkTools() -> NetWorkTools{
        return tools
    }
   
    
}
