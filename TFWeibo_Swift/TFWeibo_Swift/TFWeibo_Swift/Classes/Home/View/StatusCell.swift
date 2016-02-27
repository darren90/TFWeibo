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
            if let iconUrl = status?.user?.profile_image_url
            {
                iconView.sd_setImageWithURL(NSURL(string: iconUrl), placeholderImage: UIImage(named: "avatar_default_big"))
            }
            
            verifiedView.image = status?.user?.verifiedImage
            vip.image = status?.user?.mbrankImage
            nameLabel.text = status?.user?.name
            
            timeLabel.text = status?.created_at
            sourceLabel.text = status?.source
            contentLabel.text = status?.text
            
            //设置配图的尺寸
            let size = calculateImageSize()
            picWidthCons?.constant = size.width
            picHeightCons?.constant = size.height
            pictureView.reloadData()
        }
        
    }
    
    //自定义一个类，需要的init方法是desingnate
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //初始化界面
        addSubViews()
        setupPictureView()
    }
    
    private func addSubViews(){
        contentView.addSubview(iconView)
        iconView.xmg_AlignInner(type: XMG_AlignType.TopLeft, referView:contentView, size: CGSize(width: 50, height: 50), offset: CGPoint(x: 10, y: 10))
        
        contentView.addSubview(verifiedView)
        verifiedView.xmg_AlignInner(type: XMG_AlignType.BottomRight, referView: iconView, size: CGSize(width: 15, height: 15), offset: CGPoint(x: 5, y: 5))
        
        contentView.addSubview(nameLabel)
        nameLabel.xmg_AlignHorizontal(type: XMG_AlignType.TopRight, referView: iconView, size: nil, offset: CGPoint(x:10, y: 0))
        
        contentView.addSubview(vip)
        vip.xmg_AlignHorizontal(type: XMG_AlignType.TopRight, referView: nameLabel, size: CGSize(width: 12, height: 12), offset: CGPoint(x: 8, y: 0))
        
        contentView.addSubview(timeLabel)
        timeLabel.xmg_AlignHorizontal(type: XMG_AlignType.BottomRight, referView: iconView, size: nil, offset: CGPoint(x: 10, y: 0))
        
        contentView.addSubview(sourceLabel)
        sourceLabel.xmg_AlignHorizontal(type: XMG_AlignType.BottomRight, referView: timeLabel, size: nil, offset: CGPoint(x: 10, y: 0))
        
        contentView.addSubview(contentLabel)
        contentLabel.xmg_AlignVertical(type: XMG_AlignType.BottomLeft, referView: iconView, size: nil , offset:CGPoint(x: 0, y: 10))
        
        contentView.addSubview(pictureView)
        let cons = pictureView.xmg_AlignVertical(type: XMG_AlignType.BottomLeft, referView: contentLabel, size: CGSizeZero, offset: CGPoint(x: 0, y: 10))
        picHeightCons = pictureView.xmg_Constraint(cons, attribute: NSLayoutAttribute.Height)
        picWidthCons = pictureView.xmg_Constraint(cons, attribute: NSLayoutAttribute.Width)
        
        
        contentView.addSubview(toolBar)
        let w = UIScreen.mainScreen().bounds.width
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
    
    //初始化配图的相关属性
    private func setupPictureView(){
        pictureView.registerClass(pictureViewCell.self, forCellWithReuseIdentifier: PicsIdentifier)
        pictureView.delegate = self
        pictureView.dataSource = self
        picLayout.minimumInteritemSpacing = 10
        picLayout.minimumLineSpacing = 10
//        picLayout.itemSize = CGSize(width: 100, height: 100)
        pictureView.backgroundColor = UIColor.lightGrayColor()
    }
    
    //计算配图的总尺寸，
    private func calculateImageSize() -> CGSize{
        //取出配图的个数
        let count = status?.storedPicUrls?.count
        
        if count == nil || count == 0{
            return CGSizeZero
        }
        
        if count == 1{
            //取出缓存图片，
            let key = status?.storedPicUrls?.first?.absoluteString
            let image = SDWebImageManager.sharedManager().imageCache.imageFromDiskCacheForKey(key)
            if image != nil {
                picLayout.itemSize = image.size
                return image.size
            }else {
                return CGSizeZero
            }
        }
        
        //四张图片，是田字格
        let w = 90
        let margin = 10
        picLayout.itemSize = CGSize(width: w, height: w)
        if count == 4{
            let viewW = w * 2 + margin
            return CGSize(width: viewW , height: viewW)
        }
        
        //其他图片。计算9宫格的大小
        let colNum = 3
        //计算行数
        let rowNum = (count! - 1) / 3 + 1
        //宽度
        let viewW = colNum * w + (colNum - 1) * margin
        let viewH = rowNum * w + (rowNum - 1) * margin
        return CGSize(width: viewW, height: viewH)
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
    private lazy var picLayout : UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    private lazy var pictureView :UICollectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: self.picLayout)
    
}


extension StatusCell :UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return status?.storedPicUrls?.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(PicsIdentifier, forIndexPath: indexPath) as! pictureViewCell
        cell.imageUrl = status?.storedPicUrls![indexPath.item]
        return cell
    }
}

class pictureViewCell:UICollectionViewCell{
    var imageUrl: NSURL?{
        didSet{
            iconImage.sd_setImageWithURL(imageUrl)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(iconImage)
        
        iconImage.xmg_Fill(contentView)
    }
    
    
    private lazy var iconImage:UIImageView = UIImageView()

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




















