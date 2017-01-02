//
//  Emotion.swift
//  01-表情键盘
//
//  Created by Tengfei on 2016/12/30.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit


class Emoticon: NSObject {
    
    var code:String? {   //emoji
        didSet{
            guard let code = code else{
                return
            }
            
            //处理code emoji表情
            //1-创建扫描器
            let scanner = Scanner(string: code)
            var value : UInt32 = 0
            scanner.scanHexInt32(&value)
            //将value转成字符
            let c = Character(UnicodeScalar(value)!)
            //将字符转成字符串
            emojiCode = String(c)
            
        }
    }
    var png:String? {    //普通表情对应的图片名称
        didSet{
            guard let png = png else{
                return
            }
            
            pngPath = Bundle.main.bundlePath + "/Emoticons.bundle/" + png
        }
    }
    var chs:String?    //普通表情对应的文字

    // MARK:-- 数据处理
    var pngPath:String?
    var emojiCode:String?
    var isRemove:Bool = false///是否是删除表情
    var isEmpty:Bool = false
    
    init(isRemove:Bool) {
//        super.init()
        self.isRemove = isRemove
    }
    init(isEmpty:Bool) {
        //        super.init()
        self.isEmpty = isEmpty
    }
    
//    var type:String?
    
    override var description:String{
        return dictionaryWithValues(forKeys: ["emojiCode","png","chs"]).description
    }
    
    init(dict:[String:String]){
        super.init()
        
       setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
