//
//  PhotoBrowseController.swift
//  Weibo_Swift
//
//  Created by Tengfei on 2017/1/4.
//  Copyright © 2017年 tengfei. All rights reserved.
//

import UIKit

private let KPhotoCell = "KPhotoCell"

class PhotoBrowseController: UIViewController {
    // MARK:-- 定义属性
    var indexPath:IndexPath
    var picUrls : [URL]
    
    lazy var collectionView:UICollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: PhotoBrowseCollectionLayout())
    
    lazy var closeBtn = UIButton()
    lazy var saveBtn = UIButton()
    
    // MARK:-- 自定义构造函数
    init(indexPath:IndexPath,picUrls:[URL]){
        self.indexPath = indexPath
        self.picUrls = picUrls
        super.init(nibName: nil, bundle: nil)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.cyan
        
        setUpUI()

    }

  

 

}

//MARK: --- 设置UI界面
extension PhotoBrowseController{
    
    func setUpUI(){
        
        //1，添加子控件
        view.addSubview(collectionView)
        view.addSubview(closeBtn)
        view.addSubview(saveBtn)
        
//        collectionView
        collectionView.frame = view.bounds
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PhotoBrowseCell.self, forCellWithReuseIdentifier: KPhotoCell)
        
        closeBtn.setTitle("关闭", for: .normal)
        saveBtn.setTitle("保存", for: .normal)
        closeBtn.backgroundColor = UIColor.darkGray
        saveBtn.backgroundColor = UIColor.darkGray
        closeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        saveBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
 
        closeBtn.addTarget(self, action: #selector(self.closeAction), for: .touchUpInside)
        saveBtn.addTarget(self, action: #selector(self.saveAction), for: .touchUpInside)

        
        //2, 设置frame
 
        closeBtn.snp.makeConstraints { (make) in
            make.left.equalTo(30)
            make.bottom.equalTo(-20)
            make.size.equalTo(CGSize(width: 90, height: 32))
        }
        saveBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-30)
            make.bottom.equalTo(closeBtn.snp.bottom)
            make.size.equalTo(closeBtn.snp.size)
        }
        

    }
    
    func closeAction(){
        dismiss(animated: true, completion: nil)
    }
    
    func saveAction(){
        
    }
    
}


extension PhotoBrowseController:UICollectionViewDataSource,UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return picUrls.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KPhotoCell, for: indexPath) as! PhotoBrowseCell
//        cell.backgroundColor = indexPath.item % 2 == 0 ? UIColor.brown : UIColor.cyan
        cell.picUrl = picUrls[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}



class PhotoBrowseCollectionLayout : UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        
        scrollDirection = .horizontal
        itemSize = (collectionView?.frame.size)!
        
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        
        collectionView?.isPagingEnabled = true
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.showsHorizontalScrollIndicator = false
    }

}



























