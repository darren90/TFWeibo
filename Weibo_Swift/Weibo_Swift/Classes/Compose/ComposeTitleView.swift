//
//  ComposeTitleView.swift
//  Weibo_Swift
//
//  Created by Tengfei on 2016/12/25.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit
import SnapKit

class ComposeTitleView: UIView {
    
    lazy var topLabel:UILabel = UILabel()
    lazy var nameLabel:UILabel = UILabel()
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addTitleSubView()
    }
    
    func addTitleSubView(){
        addSubview(topLabel)
        addSubview(nameLabel)
        
        
        //
        topLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(self)
        }
        
        nameLabel.snp.makeConstraints { (make) in
             make.centerX.equalTo(self)
            make.top.equalTo(topLabel.snp.bottom).offset(3)
        }
        
        topLabel.font = UIFont.systemFont(ofSize: 16)
        nameLabel.font = UIFont.systemFont(ofSize: 12)
        nameLabel.textColor = UIColor.lightGray
        topLabel.text = "发微博"
        nameLabel.text = UserAccountViewModel.shareInstance.account?.screen_name
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
