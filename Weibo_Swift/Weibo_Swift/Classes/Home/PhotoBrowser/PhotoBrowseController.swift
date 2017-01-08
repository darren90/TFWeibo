//
//  PhotoBrowseController.swift
//  Weibo_Swift
//
//  Created by Tengfei on 2017/1/4.
//  Copyright © 2017年 tengfei. All rights reserved.
//

import UIKit
import SVProgressHUD

private let KPhotoCell = "KPhotoCell"
let kPhotoMargin:CGFloat = 10

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
        
        //滚动到对应的位置
        collectionView.scrollToItem(at: indexPath, at: .left, animated: false)

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
        collectionView.frame = CGRect(x: 0, y: 0, width: view.bounds.width + kPhotoMargin, height: view.bounds.height)
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
    // MARK:-- 保存图片
    func saveAction(){
        //1 - 获取正在显示的image
         let cell = collectionView.visibleCells.first as! PhotoBrowseCell
        guard let image = cell.iconView.image else{
            return
        }
        
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(self.saveImagei(image:error:contentInfo:)), nil)
    }
    
//      - (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo;
//    void * --> AnyObject
    func saveImagei(image:UIImage,error:NSError?, contentInfo:AnyObject){
        var showInfo = ""
        if error != nil {
            showInfo = "保存失败"
        }else{
            showInfo = "保存成功"
        }
        
        SVProgressHUD.showInfo(withStatus: showInfo)
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
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}


extension PhotoBrowseController : PhotoBrowseCellDelegate {
    func imgaeViewClick() {
        closeAction()
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

//mark： --- animateDismiss协议
extension PhotoBrowseController : PhotoAnimatorDismissdDelegate{
    func indexPathForDismiss() -> IndexPath{
        //获取当前正在显示的indexpath
        let cell = collectionView.visibleCells.first!
        return collectionView.indexPath(for: cell)!
    }

    func imageViewForDismiss() -> UIImageView {
        let imageView = UIImageView()
        let cell = collectionView.visibleCells.first as! PhotoBrowseCell
        imageView.frame = cell.iconView.frame
        imageView.image = cell.iconView.image
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }

}
























