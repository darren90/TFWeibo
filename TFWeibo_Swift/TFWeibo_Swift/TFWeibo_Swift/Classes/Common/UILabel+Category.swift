//
//  UILabel+Category.swift
//  TFWeibo_Swift
//
//  Created by Tengfei on 16/2/27.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit





extension UILabel{
    //快速创建UIlabel
    class func createLabel(color:UIColor,font:CGFloat) -> UILabel{
        let label = UILabel()
        label.textColor = UIColor.darkGrayColor()
        label.font = UIFont.systemFontOfSize(font)
        return label
    }
}

