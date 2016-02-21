//
//  APINetTools.swift
//  TFWeibo_Swift
//
//  Created by Tengfei on 16/2/20.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class APINetTools: NSObject {
   static let baseUrl = "https://api.weibo.com/"
    
    /**
     GET请求的方式
     
     - parameter url:     url
     - parameter params:  参数，字典类型
     - parameter success: 成功的回调
     - parameter fail:    失败
     */
    static func get(url:String,params:[String:AnyObject]?,success:(json:AnyObject) -> Void,fail:(error:Any) -> Void){
        let urlStr = baseUrl + url
        
        if let paramss = params{
            Alamofire.request(.GET,urlStr, parameters: paramss).responseJSON { (_, _, result) -> Void in
                switch result {
                case let .Success(json):
//                    print(json)
                    success(json: json)
                case let .Failure(_, error):
//                    print(error)
                    fail(error: error)
                }
            }
        }else{
            Alamofire.request(.GET,urlStr).responseJSON { (_, _, result) -> Void in
                switch result {
                case let .Success(json):
//                    print(json)
                    success(json: json)
                case let .Failure(_, error):
//                    print(error)
                     fail(error: error)
                }
            }
        }
    }
    
    /**
     POST请求的方式
     
     - parameter url:     url
     - parameter params:  参数，字典类型
     - parameter success: 成功的回调
     - parameter fail:    失败
     */
    static func post(url:String,params:[String:AnyObject]?,success:(json:AnyObject) -> Void,fail:(error:Any) -> Void){
        let urlStr = baseUrl + url

        if let paramss = params{
            Alamofire.request(.POST,urlStr, parameters: paramss).responseJSON { (_, _, result) -> Void in
                switch result {
                case let .Success(json):
//                    print(json)
                    success(json: json)
                case let .Failure(_, error):
//                    print(error)
                     fail(error: error)
                }
            }
        }else{
            Alamofire.request(.POST,urlStr).responseJSON { (request, response, result) -> Void in
                switch result {
                case let .Success(json):
//                    print(json)
                    success(json: json)
                case let .Failure(_, error):
//                    print(error)
                     fail(error: error)
                }
            }
        }
    }
}



//Alamofire.request(.POST, urlStr, parameters: paramss, encoding: .JSON, headers: nil).responseJSON(completionHandler: { (_, _, result) -> Void in
//    
//    switch result{
//    case .Success(_):
//        let result2 = result.value
//        print(result2)
//        success(json:result.value!)
//    case let .Failure(_, error):
//        fail(error: error)
//    }
//})
