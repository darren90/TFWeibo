//
//  PicCollectionView.swift
//  Weibo_Swift
//
//  Created by Tengfei on 2016/12/24.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

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
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: ShowPhotoBroserNote), object: nil, userInfo: userInfo)
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








