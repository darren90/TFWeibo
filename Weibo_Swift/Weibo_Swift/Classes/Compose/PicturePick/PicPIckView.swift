//
//  PicPIckView.swift
//  Weibo_Swift
//
//  Created by Tengfei on 2016/12/28.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

private let edgeMargin:CGFloat = 10

class PicPIckView: UICollectionView {
    
    var images:[UIImage] = [UIImage](){
        didSet {
            reloadData()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        let itemWH = (UIScreen.main.bounds.width - 4*edgeMargin) / 3
        layout.itemSize = CGSize(width: itemWH, height: itemWH)
        layout.minimumLineSpacing = edgeMargin
        layout.minimumInteritemSpacing = edgeMargin
//        layout.ins
        
        self.contentInset = UIEdgeInsetsMake(edgeMargin, edgeMargin, 0, edgeMargin)
        
//        register(UICollectionViewCell.self, forCellWithReuseIdentifier: "picpick")
        let nib = UINib(nibName: "PicPIckCell", bundle: nil)
        register(nib, forCellWithReuseIdentifier: "picpick")
        dataSource = self
    }
    

}

extension PicPIckView : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1 + images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "picpick", for: indexPath) as! PicPIckCell
 
        cell.image = indexPath.item <= images.count - 1 ? images[indexPath.item] : nil ;
        return cell
    }
}









