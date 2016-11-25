//
//  UIBarButtonItem-Extension.swift
//  Weibo_Swift
//
//  Created by Tengfei on 16/11/25.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit


extension UIBarButtonItem {
    
//    convenience init(imageName:String) {
//        self.init()
//        
//        let btn = UIButton()
//        btn.setImage(UIImage(named:imageName), for: .normal)
//        btn.setImage(UIImage(named:imageName + "_highlighted"), for: .highlighted)
//        btn.sizeToFit()
//        self.customView = btn
//    }
    
    convenience init(imageName:String) {
        let btn = UIButton()
        btn.setImage(UIImage(named:imageName), for: .normal)
        btn.setImage(UIImage(named:imageName + "_highlighted"), for: .highlighted)
        btn.sizeToFit()
        self.init(customView:btn)
    }
    
    
}
