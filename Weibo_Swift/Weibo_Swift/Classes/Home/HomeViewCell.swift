//
//  HomeViewCell.swift
//  Weibo_Swift
//
//  Created by Tengfei on 2016/12/24.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

private let edgeMargin:CGFloat = 15

class HomeViewCell: UITableViewCell {
    @IBOutlet weak var contentLabelW: NSLayoutConstraint!
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var verfiedView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var vipView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
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
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        //设置微博正文的宽度约束
        contentLabelW.constant = UIScreen.main.bounds.width - 2 * edgeMargin
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
