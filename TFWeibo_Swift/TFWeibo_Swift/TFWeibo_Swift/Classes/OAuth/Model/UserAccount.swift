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
    var expires_in:NSNumber?
    var uid:String?
    
    init(dict:[String:AnyObject]){
        self.access_token = dict["access_token"] as? String
        self.expires_in = dict["expires_in"] as? NSNumber
        self.uid = dict["uid"] as? String
    }
    
    override var description:String{
        return access_token! + String(expires_in!) + uid!
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
        print("filePath:\(filePath)")
        
        account = NSKeyedUnarchiver.unarchiveObjectWithFile(filePath) as? UserAccount
        return account
    }
    
    /**
     返回用户是否已经登陆了
    */
    class func useLogin() -> Bool{
        return UserAccount.getAccount() != nil
    }
    
    
    //MARK -  归档，解档
    
    //将对象写入到文件中
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(access_token, forKey: "access_token")
        aCoder.encodeObject(expires_in, forKey: "access_token")
        aCoder.encodeObject(uid, forKey: "uid")
    }
    
    //从文件读取对象
    required init?(coder aDecoder: NSCoder) {
        access_token = aDecoder.decodeObjectForKey("access_token") as? String
        expires_in = aDecoder.decodeObjectForKey("expires_in") as? NSNumber
        uid = aDecoder.decodeObjectForKey("uid") as? String

    }
}
