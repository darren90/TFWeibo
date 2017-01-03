//
//  HomeViewCell.swift
//  Weibo_Swift
//
//  Created by Tengfei on 2016/12/24.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit
import SDWebImage

private let edgeMargin:CGFloat = 15
private let itemMargin:CGFloat = 10
//private let 

class HomeViewCell: UITableViewCell {
    @IBOutlet weak var contentLabelW: NSLayoutConstraint!
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var verfiedView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var vipView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var contentLabel: HYLabel!
    
    @IBOutlet weak var picViewH: NSLayoutConstraint!
    @IBOutlet weak var picViewW: NSLayoutConstraint!
    @IBOutlet weak var picView: PicCollectionView!
    
    @IBOutlet weak var retweetContentLavel: HYLabel!
    @IBOutlet weak var retweetBackView: UIView!
    @IBOutlet weak var picViewBottonCons: NSLayoutConstraint!
    @IBOutlet weak var retweetTopCons: NSLayoutConstraint!
    
    
    var viewModel:StatusViewModel?{
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            iconView.sd_setImage(with: viewModel.profileUrl, placeholderImage: UIImage(named:"avatar_default_small"))
            
            verfiedView.image = viewModel.verfiedImage
            
            nickNameLabel.text = viewModel.status?.user?.screen_name
            vipView.image = viewModel.vipImage
            timeLabel.text = viewModel.createAtText
            sourceLabel.text = viewModel.sourceText
//            contentLabel.text = viewModel.status?.text
            contentLabel.attributedText = FindEmoticon.shareInstance.findAttrStr(statusText: viewModel.status?.text, font: contentLabel.font)
            
            nickNameLabel.textColor = viewModel.vipImage == nil ? UIColor.black : UIColor.orange
            
            //计算配置Views宽高
            let picViewSize = calculatePicViewSize(count: viewModel.picUrls.count)
            picViewH.constant = picViewSize.height
            picViewW.constant = picViewSize.width
            
            picView.picUrls = viewModel.picUrls
            
            if viewModel.status?.retweeted_status != nil {
                //1- 设置转发微博的正文
                if let screenName = viewModel.status?.retweeted_status?.user?.screen_name ,let retContent = viewModel.status?.retweeted_status?.text  {
                    let retContent = "@" + "\(screenName) : " + retContent
//                    retweetContentLavel.text = retContent
                    retweetContentLavel.attributedText = FindEmoticon.shareInstance.findAttrStr(statusText: retContent, font: retweetContentLavel.font)
                    retweetTopCons.constant = 10//转发正文距离顶部的约束
                }
                retweetBackView.isHidden = false
            }else{
                retweetContentLavel.text = nil
                retweetBackView.isHidden = true
                retweetTopCons.constant = 0
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        //设置微博正文的宽度约束
        contentLabelW.constant = UIScreen.main.bounds.width - 2 * edgeMargin
        
//        let layout = picView.collectionViewLayout as! UICollectionViewFlowLayout
//        let imageViewWH = (UIScreen.main.bounds.width - 2 * edgeMargin - 2*itemMargin) / 3
//        layout.itemSize = CGSize(width: imageViewWH, height: imageViewWH)
        
        
        contentLabel.userTapHandler = { (label, user, range) in
            print(user)
            print(range)
        }
        
        // 监听链接的点击
        contentLabel.linkTapHandler = { (label, link, range) in
            print(link)
            print(range)
        }
        
        // 监听话题的点击
        contentLabel.topicTapHandler = { (label, topic, range) in
            print(topic)
            print(range)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
/*
    没有配图
    单张配图
    三张
    四张
    九张
 (count - 1) / 3 + 1 = rows:行数
 */
extension HomeViewCell {
    func calculatePicViewSize(count:Int) -> CGSize {
        if count == 0 {
            picViewBottonCons.constant = 0//配图距离底部的约束
            return CGSize(width: 0, height: 0)
        }
        
        picViewBottonCons.constant = 10
        
        let layout = picView.collectionViewLayout as! UICollectionViewFlowLayout
 
        if count == 1 {
            //从内存中取出图片
            let image = SDWebImageManager.shared().imageCache.imageFromDiskCache(forKey: viewModel?.picUrls.first?.absoluteString)
            
            
            //设置一张图片的layout的itemSize
            layout.itemSize = CGSize(width: (image?.size)!.width * 2, height: (image?.size)!.height * 2)
            return CGSize(width: (image?.size)!.width * 2, height: (image?.size)!.height * 2)
        }
        
        //计算
        let imageViewWH = (UIScreen.main.bounds.width - 2 * edgeMargin - 2*itemMargin) / 3
        
        //设置其他张图片layout的itemSize
        layout.itemSize = CGSize(width: imageViewWH, height: imageViewWH)
        
        
        if count == 4 {
            let picViewH = imageViewWH * 2 + itemMargin + 1//特殊处理 + 1
            return CGSize(width: picViewH, height: picViewH)
        }
        
        //计算横竖
         let rows = CGFloat((count - 1) / 3 + 1)
        
        let picViewH = rows * imageViewWH + (rows-1)*itemMargin
        
        let picViewW = UIScreen.main.bounds.width - 2 * edgeMargin
        return CGSize(width: picViewW, height: picViewH)
    }
}























