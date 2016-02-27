//
//  StatusCell.swift
//  TFWeibo_Swift
//
//  Created by Tengfei on 16/2/27.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit
import SDWebImage

let PicsIdentifier = "PicsIdentifier"

class StatusCell: UITableViewCell {
    
    //保存配图的宽高约束
    var picWidthCons:NSLayoutConstraint?
    var picHeightCons:NSLayoutConstraint?
    
    var status:Status?{
        didSet {
            topView.status = status
            
            contentLabel.text = status?.text
            
            pictureView.status = status
            
            //设置配图的尺寸
            let size = pictureView.calculateImageSize()
            picWidthCons?.constant = size.width
            picHeightCons?.constant = size.height
        }
    }
    
    //自定义一个类，需要的init方法是desingnate
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //初始化界面
        addSubViews()
    }
    
    private func addSubViews(){
        let w = UIScreen.mainScreen().bounds.width

        contentView.addSubview(topView)
        topView.xmg_AlignInner(type: XMG_AlignType.TopLeft, referView: contentView, size: CGSize(width: w, height: 60))
        
        contentView.addSubview(contentLabel)
        contentLabel.xmg_AlignVertical(type: XMG_AlignType.BottomLeft, referView: topView, size: nil , offset:CGPoint(x: 10, y: 10))
        
        contentView.addSubview(pictureView)
        let cons = pictureView.xmg_AlignVertical(type: XMG_AlignType.BottomLeft, referView: contentLabel, size: CGSizeZero, offset: CGPoint(x: 0, y: 10))
        picHeightCons = pictureView.xmg_Constraint(cons, attribute: NSLayoutAttribute.Height)
        picWidthCons = pictureView.xmg_Constraint(cons, attribute: NSLayoutAttribute.Width)
        
        
        contentView.addSubview(toolBar)
        toolBar.xmg_AlignVertical(type: XMG_AlignType.BottomLeft, referView: pictureView, size: CGSize(width: w, height: 44), offset: CGPoint(x: -10, y: 10))
        toolBar.backgroundColor = UIColor.lightGrayColor()
        
        //添加底部约束
        //这里存在问题，不推荐这样做，
//        toolBar.xmg_AlignInner(type: XMG_AlignType.BottomRight, referView: contentView, size: nil, offset: CGPoint(x: -10, y: -10))
    }
    
    func rowHeight(status:Status) -> CGFloat{
        //1：为了调用didSet。计算配图的高度
        self.status = status
        
        //2：强制更新界面
        self.layoutIfNeeded()
        
        //3：返回底部视图的最大Y值
        return CGRectGetMaxY(toolBar.frame)
    }
 
    
   
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //懒加载，设置子控件
    private lazy var topView:TopView = TopView()
        
    private lazy var contentLabel:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkGrayColor()
        label.font = UIFont.systemFontOfSize(15)
        label.numberOfLines = 0
        label.preferredMaxLayoutWidth = UIScreen.mainScreen().bounds.width - 20
        return label
    }()
    
    private lazy var toolBar:ToolBar = ToolBar()
    
    //图片
    private lazy var pictureView :PictureView = PictureView()
    
}






















