//
//  UIButton-Extension.swift
//  Weibo_Swift
//
//  Created by Tengfei on 16/11/24.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit


//给UIButton进行扩展，和OC中的分类 类似
extension UIButton{

    //Swift中的类方法，以class开头，类似于OC中+方法
    
    class func creeateButton(imageName:String , bgImageName:String) -> UIButton{
        //
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(named: bgImageName), for: .normal)
        btn.setBackgroundImage(UIImage(named: bgImageName + "_highlighted"), for: .highlighted)
        btn.setImage(UIImage(named: imageName), for: .normal)
        btn.setImage(UIImage(named: imageName + "_highlighted"), for: .highlighted)
        btn.sizeToFit()
        return btn
    }
    
    //构造函数 - 便利
    //convenience ： 使用这个词修辞的函数，叫做便利构造函数，用于对系统的构造函数扩充使用
    /*
        特点：
        1：便利构造函数通常都是写在extension里面
        2：便利构造函数init前面需要嘉善关键字：convenience
        3：在便利构造函数中需要明确调用self.init()
     */
    convenience init(imageName:String , bgImageName:String){
        self.init()
        
        //调用的当前的对象的某一个 函数
        setBackgroundImage(UIImage(named: bgImageName), for: .normal)
        setBackgroundImage(UIImage(named: bgImageName + "_highlighted"), for: .highlighted)
        setImage(UIImage(named: imageName), for: .normal)
        setImage(UIImage(named: imageName + "_highlighted"), for: .highlighted)
        sizeToFit()

    }
}











