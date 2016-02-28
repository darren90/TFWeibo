//
//  StatusForwardCell.swift
//  TFWeibo_Swift
//
//  Created by Tengfei on 16/2/27.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class StatusForwardCell: StatusCell {

    override func addSelfSubViews() {
        super.addSelfSubViews()
        
//        contentView.addSubview(forwardBg)
        contentView.insertSubview(forwardBg, belowSubview: pictureView)
        contentView.insertSubview(forwardLabel, aboveSubview: forwardBg)
        
        forwardBg.xmg_AlignVertical(type: XMG_AlignType.BottomLeft, referView: contentLabel, size: nil, offset: CGPoint(x: -10, y: 10))
        forwardBg.xmg_AlignVertical(type: XMG_AlignType.TopRight, referView: toolBar, size: nil)
        
        forwardLabel.text = "sfsdfsdfsfsfasf;asl"
        forwardLabel.xmg_AlignInner(type: XMG_AlignType.TopLeft, referView: forwardBg, size: nil, offset: CGPoint(x: 10, y: 10))
        //调整位置
        let cons = pictureView.xmg_AlignVertical(type: XMG_AlignType.BottomLeft, referView: forwardLabel, size: CGSizeZero, offset: CGPoint(x: 0, y: 10))
        picHeightCons = pictureView.xmg_Constraint(cons, attribute: NSLayoutAttribute.Height)
        picWidthCons = pictureView.xmg_Constraint(cons, attribute: NSLayoutAttribute.Width)
    }
    
    //懒加载子控件
    private lazy var forwardLabel:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkGrayColor()
        label.font = UIFont.systemFontOfSize(15)
        label.numberOfLines = 0
        label.preferredMaxLayoutWidth = UIScreen.mainScreen().bounds.width - 20
        return label
    }()
    
    private var forwardBg:UIButton = {
       let btn = UIButton()
        btn.backgroundColor  = UIColor(white: 0.9, alpha: 1.0)
        return btn
    }()
}
