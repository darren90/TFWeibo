//
//  StatusViewModel.swift
//  Weibo_Swift
//
//  Created by Tengfei on 2016/12/24.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class StatusViewModel: NSObject {
    // MARK:-- 属性
    var status:Status?
    
    // MARK:-- 处理 微博
    var sourceText:String?
    var createAtText:String?
    
    
    // MARK:-- 用户数据处理
    var verfiedImage:UIImage?
    var vipImage:UIImage?
    
    var profileUrl:URL? //用户头像
    var picUrls : [URL] = [URL]() //微博配图
    
    
    // MARK:-- 自定义构造函数
    init(status:Status) {
        self.status = status
        
        // 1 - 来源处理
         if let source = status.source , status.source != "" {
            //  "source": "<a href="http://weibo.com" rel="nofollow">新浪微博</a>",
            
            let startIndex = (source as NSString).range(of: ">").location + 1
            let length = (source as NSString).range(of: "</").location - startIndex
            
            sourceText = (source as NSString).substring(with: NSRange(location: startIndex, length: length))
        }
        
         // 2 - 来源处理
        if let createAt = status.created_at {
            createAtText = NSDate.createDateStr(created_at: createAt)
        }
        
        // 2 - 认证处理
        let verified_type = status.user?.verified_type ?? -1
        switch verified_type {
        case 0:
            verfiedImage = UIImage(named: "avatar_vip")
            break
        case 2,3,5:
            verfiedImage = UIImage(named: "avatar_enterprise_vip")
            break
        case 220:
            verfiedImage = UIImage(named: "avatar_grassroot")
            break
        default: break
            
        }
        // 2 - vip处理
        let mbrank = status.user?.mbrank ?? 0
        vipImage = UIImage(named: "common_icon_membership_level\(mbrank)")
        
        
        // 头像处理
        let profileUrlStr = status.user?.profile_image_url ?? ""
        profileUrl = URL(string: profileUrlStr)

        //配图数据
        if let picUrlDicts = status.pic_urls {
            for picUrlDict in picUrlDicts {
                guard let picUrlStr = picUrlDict["thumbnail_pic"] else {
                    continue
                }
                
                picUrls.append(URL(string:picUrlStr)!)
            }
        }
    }
}














