//
//  TFPresentationController.swift
//  Weibo_Swift
//
//  Created by Tengfei on 16/11/27.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class TFPresentationController: UIPresentationController {

    //重写方法，设置弹出view的大小，位置
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        
        //设置弹出view的尺寸
        presentedView?.frame = CGRect(x: 100, y: 60, width: 180, height: 250)
        
        //添加蒙版
        
        setUpCoverView()
    }

    override func containerViewDidLayoutSubviews() {
        
    }
    
    private lazy var coverView:UIView = UIView()
    
    func setUpCoverView()  {
//        containerView?.addSubview(coverView)
        containerView?.insertSubview(coverView, at: 0)
        
        //设置蒙版属性
        coverView.backgroundColor = UIColor(white: 0.8, alpha: 0.2)
        coverView.frame = containerView!.bounds
     
        //添加手势
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.remove))
        coverView.addGestureRecognizer(tap)
    }
    
    func remove() {
        print("-------")
        presentedViewController.dismiss(animated: true, completion: nil)
    }
}


//设置界面相关 -- UI
extension TFPresentationController {

}











