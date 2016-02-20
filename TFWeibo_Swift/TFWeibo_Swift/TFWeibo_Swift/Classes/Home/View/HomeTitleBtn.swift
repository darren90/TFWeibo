//
//  HomeTitleBtn.swift
//  TFWeibo_Swift
//
//  Created by Tengfei on 16/2/19.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class HomeTitleBtn: UIButton {

    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
//        titleLabel?.frame.offsetInPlace(dx: -imageView!.bounds.width / 2, dy: 0)
//        imageView?.frame.offsetInPlace(dx: titleLabel!.bounds.width / 2, dy: 0)
        
        titleLabel?.frame.origin.x = 0
        imageView!.frame.origin.x = titleLabel!.frame.size.width
        
    }
    
    
}
