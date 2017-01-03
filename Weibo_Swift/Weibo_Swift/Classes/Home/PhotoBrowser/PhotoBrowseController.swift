//
//  PhotoBrowseController.swift
//  Weibo_Swift
//
//  Created by Tengfei on 2017/1/4.
//  Copyright © 2017年 tengfei. All rights reserved.
//

import UIKit

class PhotoBrowseController: UIViewController {
    // MARK:-- 定义属性
    var indexPath:IndexPath
    var picUrls : [URL]
    
    
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
    }

  

 

}
