//
//  TopView.swift
//  TFWeibo_Swift
//
//  Created by Tengfei on 16/2/27.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class TopView: UIView {
    
    var status:Status?{
        didSet {
            if let iconUrl = status?.user?.profile_image_url
            {
                iconView.sd_setImageWithURL(NSURL(string: iconUrl), placeholderImage: UIImage(named: "avatar_default_big"))
            }
            
            verifiedView.image = status?.user?.verifiedImage
            vip.image = status?.user?.mbrankImage
            nameLabel.text = status?.user?.name
            
            timeLabel.text = status?.created_at
            sourceLabel.text = status?.source
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(iconView)
        iconView.xmg_AlignInner(type: XMG_AlignType.TopLeft, referView:self, size: CGSize(width: 50, height: 50), offset: CGPoint(x: 10, y: 10))
        
        addSubview(verifiedView)
        verifiedView.xmg_AlignInner(type: XMG_AlignType.BottomRight, referView: iconView, size: CGSize(width: 15, height: 15), offset: CGPoint(x: 5, y: 5))
        
        addSubview(nameLabel)
        nameLabel.xmg_AlignHorizontal(type: XMG_AlignType.TopRight, referView: iconView, size: nil, offset: CGPoint(x:10, y: 0))
        
        addSubview(vip)
        vip.xmg_AlignHorizontal(type: XMG_AlignType.TopRight, referView: nameLabel, size: CGSize(width: 12, height: 12), offset: CGPoint(x: 8, y: 0))
        
        addSubview(timeLabel)
        timeLabel.xmg_AlignHorizontal(type: XMG_AlignType.BottomRight, referView: iconView, size: nil, offset: CGPoint(x: 10, y: 0))
        
        addSubview(sourceLabel)
        sourceLabel.xmg_AlignHorizontal(type: XMG_AlignType.BottomRight, referView: timeLabel, size: nil, offset: CGPoint(x: 10, y: 0))
     }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    
    private lazy var iconView: UIImageView = {
        let imgView = UIImageView(image: UIImage(named: "avatar_default_big"))
        
        return imgView
    }()
    
    private lazy var nameLabel:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkGrayColor()
        label.font = UIFont.systemFontOfSize(14)
        return label
    }()
    
    
    private lazy var verifiedView:UIImageView = UIImageView(image: UIImage(named:"avatar_enterprise_vip"))
    
    
    private lazy var vip:UIImageView = UIImageView(image: UIImage(named: "common_icon_membership_level1"))
    
    private lazy var timeLabel:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkGrayColor()
        label.font = UIFont.systemFontOfSize(14)
        return label
    }()
    
    private lazy var sourceLabel:UILabel =
    {
        let label = UILabel()
        label.textColor = UIColor.darkGrayColor()
        label.font = UIFont.systemFontOfSize(14)
        return label
    }()

    
}
