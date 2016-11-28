//
//  NetWorkTools.swift
//  Weibo_Swift
//
//  Created by Tengfei on 16/11/28.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

enum RequestType:String{
    case GET = "GET"
    case POST = "POST"
}

class NetWorkTools: NSObject {

    //单例
    static let share:NetWorkTools = {
        let tools = NetWorkTools()
//        tools.respon
        return tools
    }()
    
    func request(method : RequestType,urlStr : String,pams:[String : AnyObject] ,finsinsh : (_ result : AnyObject?, _ error : NSError?) -> () ){
        
        if method == .GET {
//                GET()
        }else{
        
        }
    }
    
}
