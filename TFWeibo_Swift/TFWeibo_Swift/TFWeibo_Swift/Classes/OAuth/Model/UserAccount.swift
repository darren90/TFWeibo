//
//  UserAccount.swift
//  TFWeibo_Swift
//
//  Created by Tengfei on 16/2/20.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class UserAccount: NSObject,NSCoding {
//    "access_token": "ACCESS_TOKEN",
//    "expires_in": 1234,
//    "remind_in":"798114",
//        "uid":"12341234"
    
    var access_token:String?
    var expires_in:NSNumber?{
        didSet{
            expires_date = NSDate(timeIntervalSinceNow: (expires_in?.doubleValue)!)
            print(expires_date)
        }
    }
    
    var expires_date:NSDate?//保存用户的过期时间
    var uid:String?
    
    // 用户信息增加字段
    var screen_name:String?
    var avatar_large: String?
    
    override init() {
        
    }
    
    init(dict:[String:AnyObject]){
//        self.access_token = dict["access_token"] as? String
//        self.expires_in = dict["expires_in"] as? NSNumber
//        self.uid = dict["uid"] as? String
        
        super.init()
        /*
        access_token = dict["access_token"] as? String
        // 注意: 如果直接赋值, 不会调用didSet，如果在初始化的时候（构造方法）赋值，不会调用didSet方法
        expires_in = dict["expires_in"] as? NSNumber
        uid = dict["uid"] as? String
        */
        
        setValuesForKeysWithDictionary(dict)
    }
    //KVC:如果有些key不存在，则重写这个方法即可。
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        print("account-key:\(key),value:\(value)")
    }
    
    
    override var description:String{
//        return access_token! + String(expires_in!) + uid!
        // 1.定义属性数组
        let properties = ["access_token", "expires_in", "uid"]
        // 2.根据属性数组, 将属性转换为字典
        let dict =  self.dictionaryWithValuesForKeys(properties)
        // 3.将字典转换为字符串
        return "\(dict)"
    }
    
    //MARK - 保存和读取
    func saveAccount(){
        let path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, .UserDomainMask, true).last!
        let path1 = path as NSString
        let filePath = path1.stringByAppendingPathComponent("account.plist")
        print("filePath:\(filePath)")
        NSKeyedArchiver.archiveRootObject(self, toFile: filePath)
    }
    
    static var account:UserAccount?
    class func getAccount() -> UserAccount?{
        if account != nil {
            return account
        }
        
        let path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, .UserDomainMask, true).last!
        let path1 = path as NSString
        let filePath = path1.stringByAppendingPathComponent("account.plist")
        
        account = NSKeyedUnarchiver.unarchiveObjectWithFile(filePath) as? UserAccount
        
        // 3.判断授权信息是否过期
        // 2020-09-08 03:49:39                       2020-09-09 03:49:39
        if account?.expires_date?.compare(NSDate()) == NSComparisonResult.OrderedAscending
        {
            // 已经过期
            return nil
        }
        return account
    }
    
    /**
     返回用户是否已经登陆了
    */
    class func useLogin() -> Bool{
        return UserAccount.getAccount() != nil
    }
    
    
    
    /**
     MARK - 读取用户信息
     
     - parameter aCoder:
     */
     
    func getUserInfo(finished: (account: UserAccount?, error:NSError?)->()){
        let path = "2/users/show.json"
//        access_token	true	string	采用OAuth授权方式为必填参数，OAuth授权后获得。
//        uid	false	int64	需要查询的用户ID。
//        assert(access_token == nil ,"没有授权")
        let params = ["access_token":access_token!,"uid":uid!]
        
        APINetTools.get(path, params: params, success: { (json) -> Void in
            print(json)
            
            // 1.判断字典是否有值
            if let dict = json as? [String: AnyObject]
            {
                self.screen_name = dict["screen_name"] as? String
                self.avatar_large = dict["avatar_large"] as? String
                // 保存用户信息
                //                self.saveAccount()
                finished(account: self, error: nil)
                return
            }
            finished(account: nil, error: nil)

            }) { (error) -> Void in
                print(error)
                finished(account: nil, error: nil)
        }
        
    }
    
    
    //MARK -  归档，解档
    
    //将对象写入到文件中
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(access_token, forKey: "access_token")
        aCoder.encodeObject(expires_in, forKey: "expires_in")
        aCoder.encodeObject(uid, forKey: "uid")
        aCoder.encodeObject(expires_date, forKey: "expires_date")
        aCoder.encodeObject(screen_name, forKey: "screen_name")
        aCoder.encodeObject(avatar_large, forKey: "avatar_large")
    }
    
    //从文件读取对象
    required init?(coder aDecoder: NSCoder) {
        access_token = aDecoder.decodeObjectForKey("access_token") as? String
        expires_in = aDecoder.decodeObjectForKey("expires_in") as? NSNumber
        uid = aDecoder.decodeObjectForKey("uid") as? String
        expires_date = aDecoder.decodeObjectForKey("expires_date") as? NSDate
        screen_name = aDecoder.decodeObjectForKey("screen_name")  as? String
        avatar_large = aDecoder.decodeObjectForKey("avatar_large")  as? String

    }
}
