//
//  RefreshView.swift
//  TFWeibo_Swift
//
//  Created by Tengfei on 16/2/28.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class RefreshViewControl: UIRefreshControl {

    override init() {
        super.init()
        
        setupUI()
    }
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        
//        setupUI()
//    }
    
    
    private func setupUI(){
        addSubview(refreshView)
        refreshView.xmg_AlignInner(type: XMG_AlignType.Center, referView: self, size: CGSize(width: 150, height: 60))
        
        
        /*
        1.当用户下拉到一定程度的时候需要旋转箭头
        2.当用户上推到一定程度的时候需要旋转箭头
        3.当下拉刷新控件触发刷新方法的时候, 需要显示刷新界面(转轮)
        
        通过观察:
        越往下拉: 值就越小 ,往负值减小
        越往上推: 值就越大
        */
        addObserver(self, forKeyPath: "frame", options: NSKeyValueObservingOptions.New, context: nil)
    }
    
    /// 定义变量记录是否需要旋转监听
    private var rotationArrowFlag = false
    /// 定义变量记录当前是否正在执行圈圈动画
    private var loadingViewAnimFlag = false
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
//        print(frame.origin.y)
        // 过滤掉不需要的数据
        if frame.origin.y >= 0 {
            return
        }
        
        // 判断是否已经触发刷新事件
        if refreshing && !loadingViewAnimFlag
        {
            print("圈圈动画")
            loadingViewAnimFlag = true
            // 显示圈圈, 并且让圈圈执行动画
            refreshView.startLoadingViewAnim()
            return
        }
        
        if frame.origin.y >= -50 && rotationArrowFlag
        {
            print("翻转回来")
            rotationArrowFlag = false
            refreshView.rotaionArrowIcon(rotationArrowFlag)
        }else if frame.origin.y < -50 && !rotationArrowFlag
        {
            print("翻转")
            rotationArrowFlag = true
            refreshView.rotaionArrowIcon(rotationArrowFlag)
        }

    }
    
    override func endRefreshing() {
        super.endRefreshing()
        
        // 关闭圈圈动画
        refreshView.stopLoadingViewAnim()
        
        // 复位圈圈动画标记
        loadingViewAnimFlag = false
    }
    
    private lazy var refreshView:RefreshView = RefreshView.refrefhView()
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit{
        removeObserver(self, forKeyPath: "frame")
    }

}

class RefreshView:UIView{
    @IBOutlet weak var arrowIcon: UIImageView!
    
    @IBOutlet weak var tipView: UIView!
    
    @IBOutlet weak var loadingView: UIImageView!
    
    class func refrefhView() -> RefreshView{
        return NSBundle.mainBundle().loadNibNamed("RefreshView", owner: nil, options: nil).last as! RefreshView
    }
    
    /**
     旋转箭头
     */
    func rotaionArrowIcon(flag: Bool)
    {
        var angle = M_PI
        angle += flag ? -0.01 : 0.01
        UIView.animateWithDuration(0.2) { () -> Void in
            self.arrowIcon.transform = CGAffineTransformRotate(self.arrowIcon.transform, CGFloat(angle))
        }
    }
    
    /**
     开始圈圈动画
     */
    func startLoadingViewAnim() {
        tipView.hidden = true
        
        // 1.创建动画
        let anim = CABasicAnimation(keyPath: "transform.rotation")
        // 2.设置动画属性
        anim.toValue = 2 * M_PI
        anim.duration = 1
        anim.repeatCount = MAXFLOAT
        
        // 该属性默认为YES, 代表动画只要执行完毕就移除
        anim.removedOnCompletion = false
        // 3.将动画添加到图层上
        loadingView.layer.addAnimation(anim, forKey: nil)
    }
    /**
     停止圈圈动画
     */
    func stopLoadingViewAnim() {
        tipView.hidden = false
        
        loadingView.layer.removeAllAnimations()
    }
    
}