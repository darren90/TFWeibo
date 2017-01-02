//
//  EmotionMananger.swift
//  01-表情键盘
//
//  Created by Tengfei on 2016/12/30.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class EmotionMananger: NSObject {

    var packages:[EmotionPackage] = [EmotionPackage]()
    
    override init() {
        super.init()
        
        // 1 - 最近表情
        packages.append(EmotionPackage(id: ""))
    
        // 1 - 默认 com.sina.default
        packages.append(EmotionPackage(id: "com.sina.default"))
            
        // 1 - emoji  com.apple.emoji
        packages.append(EmotionPackage(id: "com.apple.emoji"))
            
        // 1 - 浪小花 com.sina.lxh
        packages.append(EmotionPackage(id: "com.sina.lxh"))

    }
}
