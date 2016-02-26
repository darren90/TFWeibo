//
//  Status.swift
//  TFWeibo_Swift
//
//  Created by Tengfei on 16/2/24.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class Status: NSObject {
    
    // 微博创建时间
    var created_at: String?
    //  微博ID
    var id: Int = 0
    // 微博信息内容
    var text: String?
    // 微博来源
    var source: String?
    // 配图数组
    var pic_urls: [[String: AnyObject]]?

    //为了字典转模型
    init(dict:[String:AnyObject]){
        super.init()//用需要调用 super
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
    
    class func getStatus(finished:(models:[Status]?,error:Any?)->()){
        let path = "2/statuses/friends_timeline.json"
        
//        access_token	true	string	采用OAuth授权方式为必填参数，OAuth授权后获得。
//        since_id	false	int64	若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
//        max_id	false	int64	若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
//        count	false	int	单页返回的记录条数，最大不超过100，默认为20。
//        page	false	int	返回结果的页码，默认为1。
        let params = ["access_token":UserAccount.getAccount()!.access_token!]
        
        APINetTools.get(path, params: params, success: { (json) -> Void in
//            print(json)
              let models = dict2Model(json["statuses"] as! [[String:AnyObject]])
//                print(models)
            finished(models: models, error: nil)
            }) { (error) -> Void in
//               print(error)
                finished(models: nil, error: error)
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
