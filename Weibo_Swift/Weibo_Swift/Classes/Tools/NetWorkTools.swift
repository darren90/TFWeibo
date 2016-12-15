//
//  NetWorkTools.swift
//  AFNSwiftUse
//
//  Created by Tengfei on 2016/12/8.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import AFNetworking

enum RequestType :String {
    case GET = "GET"
    case POST = "POST"
}

class NetWorkTools: AFHTTPSessionManager {
    //let是线程安全的 ，这就是单例的
    static let shareInstance  : NetWorkTools = {
        let tools  = NetWorkTools()
        tools.responseSerializer.acceptableContentTypes?.insert("text/html")
        tools.responseSerializer.acceptableContentTypes?.insert("text/plain")
        return tools
    }()
    
    func request(methodType : RequestType, urlString : String, parameters : [String : AnyObject], finished : @escaping (_ result : Any?, _ error : Error?) -> ()) {
        
        // 1.定义成功的回调闭包
        let successCallBack = { (task : URLSessionDataTask, result : Any?) -> Void in
            finished(result, nil)
        }
        
        // 2.定义失败的回调闭包
        let failureCallBack = { (task : URLSessionDataTask?, error : Error) -> Void in
            finished(nil, error)
        }
        
        // 3.发送网络请求
        if methodType == .GET {
            get(urlString, parameters: parameters, progress: nil, success: successCallBack, failure: failureCallBack)
        } else {
            post(urlString, parameters: parameters, progress: nil, success: successCallBack, failure: failureCallBack)
        }
    }
    
}

//MARK: --- 请求AccessToken
extension NetWorkTools {

    func loadAccessToken(code:String,fininshed:@escaping (_ result:[String:AnyObject]?,_ error:NSError?)->()){
        let parms = ["client_id" : app_key,"client_secret" : app_Secret,"grant_type":"authorization_code","redirect_uri" : redirect_url,"code":code]
        request(methodType: .POST, urlString: "https://api.weibo.com/oauth2/access_token", parameters: parms as [String : AnyObject]) {(result:Any?, error : Error?) -> () in
            fininshed(result as! [String : AnyObject]?,error as NSError?)
        }
    }
}





