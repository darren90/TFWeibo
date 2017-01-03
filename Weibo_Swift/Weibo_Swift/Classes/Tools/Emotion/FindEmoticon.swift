//
//  FindEmoticon.swift
//  01-正则表达式Swift
//
//  Created by Tengfei on 2017/1/3.
//  Copyright © 2017年 tengfei. All rights reserved.
//

import UIKit

class FindEmoticon: NSObject {
    
    static let shareInstance:FindEmoticon = FindEmoticon()
    
    lazy var manager:EmotionMananger = EmotionMananger()
    
    //查找属性字符串
    func findAttrStr(statusText:String,font :UIFont) -> NSMutableAttributedString? {
        
        //@.*?: 匹配到第一个：就结束
        //@.*? 匹配到到最后一个：才结束
        //        let pattern = "@.*?:"     //匹配出来@
        //        let pattern = "#.*?#"     //匹配出话题
        let pattern = "\\[.*?\\]"      //匹配表情
        //         let pattern = "http(s)?://([\\w-]+\\.)+[\\w-]+(/[\\w- ./?%&=]*)?"      //匹配网址
        
        guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else {
            return nil
        }
        
        let range = NSRange(location: 0, length: statusText.characters.count)
        let results = regex.matches(in: statusText, options: [], range: range)
        
        let attrMstr = NSMutableAttributedString(string: statusText)
        
        //        for var i = results.count - 1 ; i>=0; i = i-1{}
        for result in results.reversed(){
            //        for result in results {
            let range = result.range
            let chs = (statusText as NSString).substring(with: range)
            //            print((status as NSString).substring(with: range))
            //根据chs，获取图片路径
            guard let pngPath = findPngPath(chs: chs) else {
                return nil
            }
            
            let attach = NSTextAttachment()
            attach.image = UIImage(contentsOfFile: pngPath)
            attach.bounds = CGRect(x: 0, y: -3, width: font.lineHeight , height: font.lineHeight)
            let attImagStr = NSAttributedString(attachment: attach)
            
            //替换文字为属性字符串
            attrMstr.replaceCharacters(in: result.range, with: attImagStr)
        }

        return attrMstr
    }
    
    func findPngPath(chs:String) -> String?{
        for package in manager.packages {
            for emoji in package.emotions {
                if emoji.chs == chs {
                    return emoji.pngPath
                }
            }
        }
        return nil
    }
    
}
