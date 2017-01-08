//
//  PhotoBrowserAnimator.swift
//  Weibo_Swift
//
//  Created by Tengfei on 2017/1/8.
//  Copyright © 2017年 tengfei. All rights reserved.
//

import UIKit

class PhotoBrowserAnimator: NSObject {
    var isPresented:Bool = false
}


extension PhotoBrowserAnimator : UIViewControllerTransitioningDelegate{
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresented  = true
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresented = false
        return self
    }
    
}

//MARK: -- 遵守了UIViewControllerAnimatedTransitioning协议，必须实现的两个方法
extension PhotoBrowserAnimator : UIViewControllerAnimatedTransitioning{
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning){
        isPresented ? animateForPresentedView(using: transitionContext) : animateForDismissdView(using: transitionContext)
    }
    
    func animateForPresentedView(using transitionContext: UIViewControllerContextTransitioning){
        //1:取出弹出的view
        let prensentedView = transitionContext.view(forKey: .to)!
        
        //2.将prensentedView添加到containView中
        transitionContext.containerView.addSubview(prensentedView)
        
        //3,执行动画
        prensentedView.alpha = 0.0
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {() -> Void in
        prensentedView.alpha = 1.0
        }) {(_) -> Void in
        transitionContext.completeTransition(true)
        }
    }
    
    func animateForDismissdView(using transitionContext: UIViewControllerContextTransitioning){
        //1:取出消失的view
        let dismissView = transitionContext.view(forKey: .from)!
        
        //2.将prensentedView添加到containView中
        transitionContext.containerView.addSubview(dismissView)
        
        //3,执行动画
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {() -> Void in
            dismissView.alpha = 0.0
        }) {(_) -> Void in
            dismissView.removeFromSuperview()
            transitionContext.completeTransition(true)
        }
    }

}




