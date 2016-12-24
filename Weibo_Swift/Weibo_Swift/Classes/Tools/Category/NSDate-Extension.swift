//
//  NSDate-Extension.swift
//  08-时间处理
//
//  Created by Tengfei on 2016/12/24.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import Foundation


extension NSDate {
    class func createDateStr(created_at:String) -> String {
    
//        let created_at = "Tue May 31 17:46:55 +0800 2011"
        
        //时间格式化
        let fmt = DateFormatter()
        fmt.dateFormat = "EEE MM dd HH:mm:ss Z yyyy"
        fmt.locale = Locale(identifier: "en")
        
        guard let createDate = fmt.date(from: created_at) else {
            return ""
        }
        
        //创建当前时间
        let nowDate = Date()
        
        let interval = Int(nowDate.timeIntervalSince(createDate))
        
        //对时间间隔处理
        //1 - 显示刚刚
        if interval < 60 {
           
            return "刚刚"
        }
        
        //2 - 59分钟前
        if interval < 60*60 {
            return "\(interval / 60)分钟前"
        }
        
        //3 - 小时
        if interval < 60 * 60 * 24 {
           
            return "\(interval / (60*60))小时前"
        }
        
        //5 - 昨天
        
        //日历对象
        let calendar = Calendar.current
        if calendar.isDateInYesterday(createDate) {
            fmt.dateFormat = "昨天 HH:mm:ss"
            
            let timeStr = fmt.string(from: createDate)

            return timeStr
        }
        
        // 6 一年内
        let cmps = calendar.dateComponents([.year], from: createDate, to: nowDate)
        
        if cmps.year! < 1 {
            fmt.dateFormat = "MM-dd HH:mm"
            let timeStr = fmt.string(from: createDate)
            return timeStr
        }
        
        //7 - 超过一年
        fmt.dateFormat = "yyyy-MM-dd HH:mm"
        let timeStr = fmt.string(from: createDate)
        
        return timeStr
    }
}









