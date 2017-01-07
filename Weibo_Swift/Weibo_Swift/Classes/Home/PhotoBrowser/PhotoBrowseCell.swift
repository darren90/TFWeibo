//
//  PhotoBrowseCell.swift
//  Weibo_Swift
//
//  Created by Tengfei on 2017/1/4.
//  Copyright © 2017年 tengfei. All rights reserved.
//

import UIKit
import SDWebImage

protocol PhotoBrowseCellDelegate:NSObjectProtocol {
    func imgaeViewClick()
}

class PhotoBrowseCell: UICollectionViewCell {
    
    var picUrl:URL? {
        didSet{
           setUpContent(picUrl: picUrl)
        }
    }
    
    var delegate : PhotoBrowseCellDelegate?
    
    lazy var scrollView = UIScrollView()
    lazy var iconView = UIImageView()
    lazy var progressView:ProgressVioew = ProgressVioew()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpUI()
    }
    
    
    func setUpUI(){
        contentView.addSubview(scrollView)
        contentView.addSubview(iconView)
        contentView.addSubview(progressView)
        
        progressView.bounds = CGRect(x: 0, y: 0, width: 50, height: 50)
        progressView.center = CGPoint(x: UIScreen.main.bounds.width*0.5, y: UIScreen.main.bounds.height * 0.5)
        progressView.isHidden = true
        progressView.backgroundColor = UIColor.clear
        scrollView.frame = CGRect(x: 0, y: 0, width: contentView.bounds.width-kPhotoMargin, height: contentView.bounds.height)
        
        iconView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.disSlef))
        iconView.addGestureRecognizer(tap)
    }
    
    func disSlef(){
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
}

extension PhotoBrowseCell {
    func setUpContent(picUrl:URL?){
        guard let picUrl = picUrl else{
            return
        }
        
        let image = SDWebImageManager.shared().imageCache.imageFromDiskCache(forKey: picUrl.absoluteString)
        
        let x:CGFloat = 0
        let width = UIScreen.main.bounds.width
        let height = width / image!.size.width * image!.size.height
        
        var y:CGFloat = 0
        if height > UIScreen.main.bounds.height {
            y = 0
        }else{
            y = (UIScreen.main.bounds.height - height) * 0.5
        }
        
        iconView.frame = CGRect(x: x, y: y, width: width, height: height)
        
        //
//        iconView.sd_setImage(with: getBigUrl(smallUrl: picUrl), placeholderImage: nil, options: [], prog
        
        progressView.isHidden = false
        iconView.sd_setImage(with: getBigUrl(smallUrl: picUrl), placeholderImage: image, options: [], progress: { (current:Int, total:Int) in
                self.progressView.progress = CGFloat(current) / CGFloat(total)
        }){ (_, _, _, _) in
            self.progressView.isHidden = true
        }
        
        //设置ScrollView
        scrollView.contentSize = CGSize(width: 0, height: height)
    }
    
    
    func getBigUrl(smallUrl:URL) -> URL {
        
//        http://ww2.sinaimg.cn/thumbnail/65d1b78bgw1fbdrbj6hxgj20c00ghq3b.jpg
//        
//        http://ww2.sinaimg.cn/bmiddle/65d1b78bgw1fbdrbj6hxgj20c00ghq3b.jpg
//        
//        http://ww2.sinaimg.cn/large/65d1b78bgw1fbdrbj6hxgj20c00ghq3b.jpg

        
        let smallStr = smallUrl.absoluteString
        let bigUrlStr = smallStr.replacingOccurrences(of: "thumbnail", with: "bmiddle")
        
        return URL(string: bigUrlStr)!
    }
    
    
}














