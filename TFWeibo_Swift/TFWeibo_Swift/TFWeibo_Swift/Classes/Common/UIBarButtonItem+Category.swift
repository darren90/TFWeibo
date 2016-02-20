//
//  UIBarButtonItem+Category.swift
//  TFWeibo_Swift
//
//  Created by Tengfei on 16/2/19.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

extension UIBarButtonItem{

    //如果在func在class，就相当于oc中的+
    class func createNavItem(image:String,target:AnyObject?, action: Selector) -> UIBarButtonItem
    {
        let rigntBtn = UIButton()
        rigntBtn.setImage(UIImage(named: image), forState: .Normal)
        rigntBtn.setImage(UIImage(named: image + "_highlighted"), forState: .Highlighted)
        rigntBtn.addTarget(target, action: action, forControlEvents: .TouchUpInside)
        rigntBtn.sizeToFit()
        return UIBarButtonItem(customView: rigntBtn)
    }
}


