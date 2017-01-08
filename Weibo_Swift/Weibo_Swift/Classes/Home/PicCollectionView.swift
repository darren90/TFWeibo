//
//  PicCollectionView.swift
//  Weibo_Swift
//
//  Created by Tengfei on 2016/12/24.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit
import SDWebImage

class PicCollectionView: UICollectionView {

    // MARK:-- 定义属性
    var picUrls:[URL] = [URL]() {
        didSet{
            self.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = UIColor.white
        
        dataSource = self
        delegate = self
    }
}


extension PicCollectionView : UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return picUrls.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "piccell", for: indexPath) as! PicCollectionViewCell
        cell.picUrl = picUrls[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print(indexPath.item)
        //获取通知需要传递的参数：
        let userInfo = ["indexPath":indexPath,"picUrls":picUrls] as [String : Any]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: ShowPhotoBroserNote), object: self, userInfo: userInfo)
    }
}


extension PicCollectionView : PhotoAnimatorPresentedDelegate {
    func startRect(indexPath:IndexPath) -> CGRect{
        let cell = self.cellForItem(at: indexPath)!
        
        //获取cell的frame
        //直接可以转化为相对于window的frame
        let startFrame = self.convert(cell.frame, to: UIApplication.shared.keyWindow)
        return startFrame
    }
    
    func endRect(indexPath:IndexPath) -> CGRect{
        //获取该位置的image对象
        let picUrl = picUrls[indexPath.item]
        let image = SDWebImageManager.shared().imageCache.imageFromDiskCache(forKey: picUrl.absoluteString)
        
        //计算结束后的frame
        let w = UIScreen.main.bounds.width
        let h = w / (image?.size.width)! * (image?.size.height)!
        var y:CGFloat = 0
        if h > UIScreen.main.bounds.height {
            y = 0
        }else{
            y = (UIScreen.main.bounds.height - h)*0.5
        }
        return CGRect(x: 0, y: y, width: w, height: h)
    }
    
    func imageView(indexPath:IndexPath) -> UIImageView{
        //1,创建imageView =
        let imageView = UIImageView()
        let picUrl = picUrls[indexPath.item]
        let image = SDWebImageManager.shared().imageCache.imageFromDiskCache(forKey: picUrl.absoluteString)
        
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }
}

class PicCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var iconView: UIImageView!
    
    
    var picUrl:URL?{
        didSet {
            guard let picUrl = picUrl else {
                return
            }
            
            iconView.sd_setImage(with: picUrl, placeholderImage: UIImage(named: "empty_picture"))
        }
    }
}








