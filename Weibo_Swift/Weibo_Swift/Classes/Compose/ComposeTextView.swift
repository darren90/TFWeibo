//
//  ComposeTextView.swift
//  Weibo_Swift
//
//  Created by Tengfei on 2016/12/25.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class ComposeTextView: UITextView {
    
    lazy var placeHolderLabel:UILabel = UILabel()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setUpUI()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    
    
}


extension ComposeTextView {

    func setUpUI() {
        addSubview(placeHolderLabel)
        
        placeHolderLabel.snp.makeConstraints { (make) in
            make.top.equalTo(8)
            make.left.equalTo(10)
//            make.right
        }
        
        placeHolderLabel.textColor = UIColor.lightGray
        placeHolderLabel.font = font
        placeHolderLabel.text = "分享新鲜的事情，，，"
        
        
        //设置内容的内边距
        textContainerInset = UIEdgeInsetsMake(8,6, 0, 6)
    }
    
    
    
}










