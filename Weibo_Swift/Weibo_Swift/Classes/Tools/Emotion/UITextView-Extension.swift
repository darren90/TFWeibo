//
//  UITextView-Extension.swift
//  01-表情键盘
//
//  Created by Tengfei on 2017/1/3.
//  Copyright © 2017年 tengfei. All rights reserved.
//

import UIKit

extension UITextView{
    
    func getEmotionStr() -> String {
        //            print("content:\(textView.text)")
        let attStr = NSMutableAttributedString(attributedString: attributedText)
        
        //遍历属性字符串
        let range = NSRange(location: 0, length: attStr.length)
        attStr.enumerateAttributes(in: range, options: []) {(dict:[String : Any],range:NSRange, _) -> Void in
            //            print(dict)
            //            print("---:\(range.location)-\(range.length)")
            if let attachment = dict["NSAttachment"] as? EmojiTextAttachment {
                attStr.replaceCharacters(in: range, with: attachment.chs!)
            }
        }
        
        //获取字符串，
        print("real String:\(attStr.string)")
        return attStr.string
    }
    
    // MARK:-- TextView插入表情
    func insetEmotion(emoticon:Emoticon){
        if emoticon.isEmpty {
            return
        }
        
        //删除按钮
        if emoticon.isRemove {
            deleteBackward()
            return
        }
        
        //emoji表情
        if emoticon.emojiCode != nil {
            //替换emoji表情
            let textRange = selectedTextRange!
            replace(textRange, withText: emoticon.emojiCode!)
            return
        }
        
        //普通表情
        let attach = EmojiTextAttachment()
        attach.image = UIImage(contentsOfFile: emoticon.pngPath!)
        attach.chs = emoticon.chs
        let font = self.font!
        attach.bounds = CGRect(x: 0, y: -3, width: font.lineHeight, height: font.lineHeight)
        let attrImage = NSAttributedString(attachment: attach)
        
        //创建可变属性字符串
        let attStr = NSMutableAttributedString(attributedString: attributedText)
        //        attStr.append(attrImage)
        //获取光标所在的位置
        let range = selectedRange
        attStr.replaceCharacters(in: range, with: attrImage)
        attributedText = attStr
        
        //将文字大小重置回去，
        self.font = font
        //将光标设置为原来的位置+1
        selectedRange = NSRange(location: range.location+1, length: 0)
    }

    
}
