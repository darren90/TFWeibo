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


//MARK: --- 请求用户信息
extension NetWorkTools {
    func loadUserInfo(access_token:String,uid:String,fininshed : @escaping ( _ result:[String:AnyObject]?,_ error:NSError?) -> ()) {
         //获取请求的url
        let urlStr = "https://api.weibo.com/2/users/show.json"
        let params = ["access_token" : access_token , "uid" : uid]
        
        request(methodType: .GET, urlString: urlStr, parameters: params as [String : AnyObject]) {(result : Any?, error : Error?) -> () in
            fininshed(result as! [String : AnyObject]?,error as NSError?)
        }
    }
}


//MARK: --- 请求首页数据
extension NetWorkTools {
    func loadStatus(since_id:Int,max_id:Int,fininshed : @escaping ( _ result:[[String:AnyObject]]?,_ error:NSError?) -> ()) {
        //获取请求的url
        let urlStr = "https://api.weibo.com/2/statuses/home_timeline.json"
        let params = ["access_token" : (UserAccountViewModel.shareInstance.account?.access_token)!,"since_id" : "\(since_id)","max_id" : "\(max_id)"] as [String : String]
        
        request(methodType: .GET, urlString: urlStr, parameters: params as [String : AnyObject]) {(result : Any?, error : Error?) -> () in
            
            guard let resdic = result as? [String : AnyObject] else{
                fininshed(nil,error as NSError?)
                return
            }
            
            //
            fininshed(resdic["statuses"] as! [[String : AnyObject]]?,error as NSError?)
        }
    }
}


//MARK: --- 发送文字微博
extension NetWorkTools {
    func sendStatus(statusText:String,isSuccess : @escaping ( _ isSuccess:Bool) -> ()) {
        //获取请求的url
        let urlStr = "https://api.weibo.com/2/statuses/update.json"
        let params = ["access_token" : (UserAccountViewModel.shareInstance.account?.access_token)!,"status" : statusText] as [String : String]
        
        request(methodType: .POST, urlString: urlStr, parameters: params as [String : AnyObject]) {(result : Any?, error : Error?) -> () in
            
            if result != nil{
                isSuccess(true)
            }else{
                isSuccess(false)

            }
        }
    }
}

//MARK: --- 发送带有图片的微博
extension NetWorkTools {
    func sendStatus(statusText:String,image:UIImage,isSuccess : @escaping ( _ isSuccess:Bool) -> ()) {
        //获取请求的url
        let urlStr = "https://api.weibo.com/2/statuses/upload.json"
        let params = ["access_token" : (UserAccountViewModel.shareInstance.account?.access_token)!,"status" : statusText] as [String : String]
        
        
        post(urlStr, parameters: params, constructingBodyWith: {(formateData:AFMultipartFormData) -> Void in
            
            if let imageData = UIImageJPEGRepresentation(image, 0.5){
                formateData.appendPart(withFileData: imageData, name: "pic", fileName: "qingqing.png", mimeType: "image/png")
            }
            
            }, progress: nil, success: {(_, _) -> Void in
                  isSuccess(true)
            }){(_, error) -> Void in
                print("上传失败:\(error)")
                  isSuccess(false)
            }
        }
}


































