//
//  TitleButton.swift
//  Weibo_Swift
//
//  Created by Tengfei on 16/11/25.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class TitleButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setImage(UIImage(named: "navigationbar_arrow_down"), for: .normal)
        setImage(UIImage(named: "navigationbar_arrow_up"), for: .selected)
        setTitle("StringFeng", for: .normal)
        sizeToFit()
        setTitleColor(UIColor.black, for: .normal)
    }
    
    //Swift中，重写了init(frame)或者init方法，必须重写init?（coder）方法
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel!.frame.origin.x = 0//Swift中可以直接修改结构体属性，
        imageView!.frame.origin.x = (titleLabel?.frame.size.width)! + 6
    }
    
    
    
}
