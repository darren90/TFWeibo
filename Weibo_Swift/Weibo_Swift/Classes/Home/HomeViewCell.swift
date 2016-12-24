//
//  HomeViewCell.swift
//  Weibo_Swift
//
//  Created by Tengfei on 2016/12/24.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

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
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var picViewH: NSLayoutConstraint!
    @IBOutlet weak var picViewW: NSLayoutConstraint!
    @IBOutlet weak var picView: PicCollectionView!
    
    
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
            contentLabel.text = viewModel.status?.text
            
            nickNameLabel.textColor = viewModel.vipImage == nil ? UIColor.black : UIColor.orange
            
            //计算配置Views宽高
            let picViewSize = calculatePicViewSize(count: viewModel.picUrls.count)
            picViewH.constant = picViewSize.height
            picViewW.constant = picViewSize.width
            
            picView.picUrls = viewModel.picUrls
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        //设置微博正文的宽度约束
        contentLabelW.constant = UIScreen.main.bounds.width - 2 * edgeMargin
        
        let layout = picView.collectionViewLayout as! UICollectionViewFlowLayout
        let imageViewWH = (UIScreen.main.bounds.width - 2 * edgeMargin - 2*itemMargin) / 3
        layout.itemSize = CGSize(width: imageViewWH, height: imageViewWH)
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
            return CGSize(width: 0, height: 0)
        }
        
        //计算
        let imageViewWH = (UIScreen.main.bounds.width - 2 * edgeMargin - 2*itemMargin) / 3
        
        if count == 4 {
            let picViewH = imageViewWH * 2 + itemMargin
            return CGSize(width: picViewH, height: picViewH)
        }
        
        //计算横竖
         let rows = CGFloat((count - 1) / 3 + 1)
        
        let picViewH = rows * imageViewWH + (rows-1)*itemMargin
        
        let picViewW = UIScreen.main.bounds.width - 2 * edgeMargin
        return CGSize(width: picViewW, height: picViewH)
    }
}























