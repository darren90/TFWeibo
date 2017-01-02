//
//  EmotionPackage.swift
//  01-表情键盘
//
//  Created by Tengfei on 2016/12/30.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class EmotionPackage: NSObject {

    var emotions:[Emoticon] = [Emoticon]()
    
    init(id:String){
        super.init()

        // 1 - 最近
        if id == "" {
            self.addEmptyEmoticon(true)
            return
        }
        
        //根据id，拼接info.plist的路径
        //这个方法只能加载Main.Bundle中的数据
//        Bundle.main.path(forResource: String?, ofType: String?)
        let plistPath = Bundle.main.path(forResource: "\(id)/info.plist", ofType: nil, inDirectory: "Emoticons.bundle")!
        
        // 3 - 根据plist路径，读取数据
        let array = NSArray(contentsOfFile: plistPath)! as! [[String : String]]
        
        var index = 0;
        for var dict in array {
            if let png = dict["png"] {
             dict["png"] = id + "/" + png//id为路径
            }
            emotions.append(Emoticon(dict:dict))
            
            //添加删除按钮
            index += 1
            if index == 20 {
                emotions.append(Emoticon(isRemove: true))
                index = 0
            }
            
        }
        
        // 5.添加空白表情
        self.addEmptyEmoticon(false)
        
        // 添加空白表情
//        let count = emotions.count % 21
//        if count == 0 {
//            return
//        }
//        
//        for _ in count..<20{
//            emotions.append(Emoticon(isEmpty:true))
//        }
//        emotions.append(<#T##newElement: Element##Element#>)
        
        
    }
    
    //fileprivate
    func addEmptyEmoticon(_ isRecently : Bool) {
        let count = emotions.count % 21
        if count == 0 && !isRecently {
            return
        }
        
        for _ in count..<20 {
            emotions.append(Emoticon(isEmpty: true))
        }
        
        emotions.append(Emoticon(isRemove: true))
    }
}










