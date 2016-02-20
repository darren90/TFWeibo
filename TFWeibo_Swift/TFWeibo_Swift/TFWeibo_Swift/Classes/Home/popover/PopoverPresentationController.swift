//
//  PopoverPresentationController.swift
//  TFWeibo_Swift
//
//  Created by Tengfei on 16/2/20.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class PopoverPresentationController: UIPresentationController {
    
    //初始化方法，负责用于转场动画的对象
    override init(presentedViewController: UIViewController, presentingViewController: UIViewController) {
        
        super.init(presentedViewController: presentedViewController, presentingViewController: presentingViewController)
    }
    
    override func containerViewDidLayoutSubviews() {
//        super.containerViewDidLayoutSubviews()
        //修改弹出视图的大小，
        containerView//容器视图
        presentedView()//被展现的视图
        presentedView()?.frame = CGRect(x: 100, y: 56, width: 200, height: 200)
        
        containerView?.insertSubview(coverView, atIndex: 0)
        //在容器视图上，添加蒙版，插入到展现视图的下面
    }
    
    private lazy var coverView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.0, alpha: 0.2)
        view.frame = UIScreen.mainScreen().bounds
        let tap = UITapGestureRecognizer(target: self, action: "close")
        view.addGestureRecognizer(tap)
        return view
    }()
    
    func close(){
        presentedViewController.dismissViewControllerAnimated(true, completion: nil)
    }
}
