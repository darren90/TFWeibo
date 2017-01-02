//
//  EmotionViewController.swift
//  01-表情键盘
//
//  Created by Tengfei on 2016/12/29.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

let EmotionCell = "EmotionCell"

class EmotionViewController: UIViewController {
    
    // MARK:-- 属性
    
    lazy var collectionView:UICollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: EmotionViewLayout())
    
    lazy var toolBar:UIToolbar = UIToolbar()
    lazy var manager = EmotionMananger()
    
    var emoticonCallBack:(_ emoticon:Emoticon) -> ()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
        
    }
    
    
    // MARK:-- 自定义构造函数
    init(emoticonCallBack:@escaping (_ emoticon:Emoticon) -> ()){
        self.emoticonCallBack = emoticonCallBack
        
        super.init(nibName: nil, bundle: nil)
        
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK:-- 方法
    
 
}

 // MARK:-- 设置UI界面内容
extension EmotionViewController {
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setUpUIFrame()
    }
    
    func setUpUI() {
        view.addSubview(collectionView)
        view.addSubview(toolBar)
//        toolBar.backgroundColor = UIColor.brown
        collectionView.backgroundColor = UIColor.white
        //设置frame --VFL
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        toolBar.translatesAutoresizingMaskIntoConstraints = false
        
        prepareForCollectionView()
        prepareForToolBar()
    }
    
    func setUpUIFrame() {
        let w = UIScreen.main.bounds.width
        let h = self.view.frame.height
        
        collectionView.frame = CGRect(x: 0, y: 0, width: w, height: h-44)
        let toolBarY = collectionView.frame.maxY
        toolBar.frame = CGRect(x: 0, y:toolBarY, width: w, height: 44)
        
//        print( (toolBar.frame))
    }
    
    func prepareForCollectionView(){
        //注册cell
        collectionView.register(EmoticonCell.self, forCellWithReuseIdentifier: EmotionCell)
        collectionView.dataSource = self
        collectionView.delegate = self
//        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
    }
    
    
    func prepareForToolBar(){
       //定义title
        let titles = ["最近","默认","emoji","浪小花"]
        
        var tag = 0
        var items = [UIBarButtonItem]()
        for title in titles {
            let item = UIBarButtonItem(title: title, style: .plain, target: self, action: #selector(self.itemClick(item:)))
            item.tag = tag
            tag += 1
            
            items.append(item)
            items.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil))
        }
        items.removeLast()
        //把item装进toolbar
        toolBar.items = items
        toolBar.tintColor = UIColor.orange
    
    }
    
    func itemClick(item:UIBarButtonItem){
//        print(item.tag)
        let tag = item.tag
        let indexPath = IndexPath(item: 0, section: tag)
        //滚动到对应的位置
        collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
    }
    
}


extension EmotionViewController:UICollectionViewDataSource,UICollectionViewDelegate{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return manager.packages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let package =  manager.packages[section]
        return  package.emotions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmotionCell, for: indexPath) as! EmoticonCell
//        cell.backgroundColor = indexPath.item % 2  == 0 ? UIColor.cyan : UIColor.blue
        let package =  manager.packages[indexPath.section]
        let emotiocon = package.emotions[indexPath.item]
        cell.emoticon = emotiocon
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let package =  manager.packages[indexPath.section]
        let emotiocon = package.emotions[indexPath.item]
//        print(emotiocon)
        insetRecentEmotion(emoticon: emotiocon)
        //添加打破最新分组中
        
        //将表情回调给外界的控制器
        emoticonCallBack(emotiocon)
    }
    
    func insetRecentEmotion(emoticon:Emoticon){
        //如果是空白表情或者删除表情，不需要插入
        if emoticon.isRemove || emoticon.isEmpty {
            return
        }
        //删除表情
        if manager.packages.first!.emotions.contains(emoticon){
            let index = manager.packages.first?.emotions.index(of: emoticon)!
            manager.packages.first?.emotions.remove(at: index!)
        }else{

            manager.packages.first?.emotions.remove(at: 19)
        }
        manager.packages.first?.emotions.insert(emoticon, at: 0)
    }
}

class EmotionViewLayout:UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        
        let itemWH = UIScreen.main.bounds.width / 7
        itemSize = CGSize(width: itemWH, height: itemWH)
        
        scrollDirection = .horizontal
        
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        
        collectionView?.isPagingEnabled = true
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.showsHorizontalScrollIndicator = false
        let insetMargin = ((collectionView?.bounds.height)! - 3*itemWH) / 2
        collectionView?.contentInset = UIEdgeInsetsMake(insetMargin, 0, insetMargin, 0)
    }
}











