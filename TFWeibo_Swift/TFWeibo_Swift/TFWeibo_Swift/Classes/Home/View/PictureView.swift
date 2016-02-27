//
//  PictureView.swift
//  TFWeibo_Swift
//
//  Created by Tengfei on 16/2/27.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit
import SDWebImage

class PictureView: UICollectionView {
    var status:Status?{
        didSet {
            reloadData()
        }
    }
    
    
    private var picLayout : UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    init(){
        super.init(frame: CGRectZero, collectionViewLayout: self.picLayout)
        
        
        registerClass(pictureViewCell.self, forCellWithReuseIdentifier: PicsIdentifier)
        delegate = self
        dataSource = self
        picLayout.minimumInteritemSpacing = 10
        picLayout.minimumLineSpacing = 10
        backgroundColor = UIColor.lightGrayColor()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //计算配图的总尺寸，
    func calculateImageSize() -> CGSize{
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

    
}


extension PictureView :UICollectionViewDelegate,UICollectionViewDataSource{
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