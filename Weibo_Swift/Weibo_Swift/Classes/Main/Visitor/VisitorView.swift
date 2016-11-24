//
//  VisitorView.swift
//  Weibo_Swift
//
//  Created by Tengfei on 16/11/25.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class VisitorView: UIView {
 
    // MARK：-- 提供快读通过xib创建的类方法
    class func visitorView() -> VisitorView{
        return Bundle.main.loadNibNamed("VisitorView", owner: nil, options: nil)?.first as! VisitorView
    }
    
}
