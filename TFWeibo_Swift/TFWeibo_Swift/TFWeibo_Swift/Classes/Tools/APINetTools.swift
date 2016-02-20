//
//  APINetTools.swift
//  TFWeibo_Swift
//
//  Created by Tengfei on 16/2/20.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit
import Alamofire

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
        
        if let paramss = params{//有参数
            Alamofire.request(.GET, urlStr, parameters: paramss, encoding: .JSON, headers: nil).responseJSON(completionHandler: {(_, _, dataResult) -> Void in
                if let result = dataResult.value{
                    success(json: result)
                }else{
                    fail(error:dataResult.value)
                }
            })
        }else{//无参数
            Alamofire.request(.GET, urlStr).responseJSON(completionHandler: { (_, _, dataResult) -> Void in
                if let result = dataResult.value{
                    success(json: result)
                }else{
                     fail(error:dataResult.value)
                }
            })
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
            Alamofire.request(.POST, urlStr,parameters:paramss,encoding: .JSON).response { request, response, data, error in
                if let dataJson = data {
                    success(json: dataJson)
                }else{
                    fail(error:error)
                }
            }
            
//            Alamofire.request(.POST, urlStr, parameters: paramss, encoding: .JSON, headers: nil).responseJSON(completionHandler: { (_, _, dataResult) -> Void in
//                
//                print(dataResult)
//                if let result = dataResult.value{
//                    success(json: result)
//                }else{
//                    fail(error:dataResult.value)
//                }
//            })
        }else{
            Alamofire.request(.POST, urlStr).response { request, response, data, error in
                if let dataJson = data {
                    success(json: dataJson)
                }else{
                    fail(error:error)
                }
            }
//            Alamofire.request(.POST, urlStr).responseJSON(completionHandler: { (_, _, dataResult) -> Void in
//                if let result = dataResult.value{
//                    success(json: result)
//                }else{
//                    fail(error:dataResult.value)
//                }
//            })
        }
    }
    
    
    

}
