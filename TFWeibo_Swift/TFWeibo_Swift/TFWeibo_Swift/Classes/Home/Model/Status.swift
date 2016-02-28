//
//  Status.swift
//  TFWeibo_Swift
//
//  Created by Tengfei on 16/2/24.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit
import  SDWebImage

class Status: NSObject {
    
    // 微博创建时间
    var created_at: String?{
        didSet{
            let cerateData = NSDate.dataWithStr(created_at!)
            created_at = cerateData.descDate
        }
    }
    //  微博ID
    var id: Int = 0
    // 微博信息内容
    var text: String?
    // 微博来源
    var source: String?{
        didSet{
            if let str = source {
                if source!.containsString(">") {
                    let starLocation = (str as NSString).rangeOfString(">").location + 1
                    let length = (str as NSString).rangeOfString("<", options: .BackwardsSearch).location - starLocation
                    source = "来自:" + (str as NSString).substringWithRange(NSMakeRange(starLocation, length))
                }else {
                    source = ""
                }
            }
        }
    }
    
    // 配图数组
    var pic_urls: [[String: AnyObject]]?{
        didSet {
            storedPicUrls = [NSURL]()
            for dict in pic_urls!{
                //将字符串，转为UEL保存到数组中
                if let urlStr = dict["thumbnail_pic"]{
                    storedPicUrls?.append(NSURL(string: urlStr as! String)!)
                }
            }
        }
    }
    
    var storedPicUrls:[NSURL]?
    
    //用户信息
    var user:User?

    //为了字典转模型
    init(dict:[String:AnyObject]){
        super.init()//用需要调用 super
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forKey key: String) {
//        print("key=:\(value),key=:\(key)")
        
        if "user" == key {
            
            user = User(dict: value as! [String:AnyObject] )
            return
        }
        
        super.setValue(value, forKey: key)
     }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
    
    class func getStatus(since_id:Int,max_id:Int ,finished:(models:[Status]?,error:Any?)->()){
        let path = "2/statuses/friends_timeline.json"
        
//        access_token	true	string	采用OAuth授权方式为必填参数，OAuth授权后获得。
//        since_id	false	int64	若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
//        max_id	false	int64	若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
//        count	false	int	单页返回的记录条数，最大不超过100，默认为20。
//        page	false	int	返回结果的页码，默认为1。
        
        var params = ["access_token":UserAccount.getAccount()!.access_token!]
        //下拉刷新
        if since_id > 0 {
            params["since_id"] = "\(since_id)"
        }
        
        if max_id > 0 {
             params["max_id"] = "\(max_id - 1)"
        }
        
        APINetTools.get(path, params: params, success: { (json) -> Void in
//            print(json)
              let models = dict2Model(json["statuses"] as! [[String:AnyObject]])
//                print(models)
            
            //缓存微博配图
            cacheStatusImages(models,finished: finished)
            
//            finished(models: models, error: nil)
            }) { (error) -> Void in
                finished(models: nil, error: error)
        }
    }
    
    
    class func cacheStatusImages(list:[Status],finished:(models:[Status]?,error:Any?)->()){
        
        if list.count == 0 {
            finished(models: list, error: nil)
            return
        }
        
        //创建一个组
        let group = dispatch_group_create()
        
        for status in list {
    
            //Swift中的新语法，
            guard let urls = status.storedPicUrls else{
                continue
            }
            
            if let UUrl = status.storedPicUrls {
                for url in UUrl{
                    //将当前的下载操作添加到组中
                    dispatch_group_enter(group)
                    
                    //开始缓存图片
                    SDWebImageManager.sharedManager().downloadImageWithURL(url, options: SDWebImageOptions(rawValue: 0), progress: nil, completed: { (_, _, _, _, _) -> Void in
                        //离开当前组
                        dispatch_group_leave(group)
                    })
                }
            }
        }
        
        dispatch_group_notify(group, dispatch_get_main_queue()) { () -> Void in
            //所有的图片都下载完毕，通过闭包，通知调用者
            finished(models: list, error: nil)
        }
    }
    
    class func dict2Model(list:[[String:AnyObject]]) -> [Status]{
        var models = [Status]()
        for dict in list {
            models.append(Status(dict: dict))
        }
        return models
    }
    
    
    let properties = ["created_at","id","text","source","pic_urls"]
    override var description: String {
        let dict = dictionaryWithValuesForKeys(properties)
        return "\(dict)"
    }
    
    
}
