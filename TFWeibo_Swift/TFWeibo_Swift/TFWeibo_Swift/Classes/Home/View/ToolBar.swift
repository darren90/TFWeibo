//
//  ToolBar.swift
//  TFWeibo_Swift
//
//  Created by Tengfei on 16/2/27.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class ToolBar: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(retweetBtn)
        addSubview(commonBtn)
        addSubview(likeBtn)
        
        xmg_HorizontalTile([retweetBtn,commonBtn,likeBtn], insets: UIEdgeInsetsZero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private lazy var retweetBtn:UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "timeline_icon_retweet"), forState: .Normal)
        btn.setTitle("转发", forState: .Normal)
        btn.titleLabel?.font = UIFont.systemFontOfSize(10)
        btn.setBackgroundImage(UIImage(named: "timeline_card_bottom_background"), forState: .Normal)
        btn.setTitleColor(UIColor.darkGrayColor(), forState: .Normal)
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        return btn
    }()
    
    private lazy var commonBtn:UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(named: "timeline_card_bottom_background"), forState: .Normal)
        btn.setImage(UIImage(named: "timeline_icon_comment"), forState: .Normal)
        btn.setTitle("评论", forState: .Normal)
        btn.titleLabel?.font = UIFont.systemFontOfSize(10)
        btn.setTitleColor(UIColor.darkGrayColor(), forState: .Normal)
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        
        return btn
    }()
    
    private lazy var likeBtn:UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(named: "timeline_card_bottom_background"), forState: .Normal)
        btn.setImage(UIImage(named: "timeline_icon_unlike"), forState: .Normal)
        btn.setTitle("赞", forState: .Normal)
        btn.titleLabel?.font = UIFont.systemFontOfSize(10)
        btn.setTitleColor(UIColor.darkGrayColor(), forState: .Normal)
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        
        return btn
    }()

}
