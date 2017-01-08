//
//  PhotoBrowserAnimator.swift
//  Weibo_Swift
//
//  Created by Tengfei on 2017/1/8.
//  Copyright © 2017年 tengfei. All rights reserved.
//

import UIKit

//面向协议开发，，

protocol PhotoAnimatorPresentedDelegate : NSObjectProtocol {
    func startRect(indexPath:IndexPath) -> CGRect
    func endRect(indexPath:IndexPath) -> CGRect
    func imageView(indexPath:IndexPath) -> UIImageView
}

protocol PhotoAnimatorDismissdDelegate : NSObjectProtocol {
    func indexPathForDismiss() -> IndexPath
    func imageViewForDismiss() -> UIImageView
}



class PhotoBrowserAnimator: NSObject {
    var isPresented:Bool = false
    
    var dismissDelegate:PhotoAnimatorDismissdDelegate?
    var presentedDelegate:PhotoAnimatorPresentedDelegate?
    var indexPath : IndexPath?
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
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning){
        isPresented ? animateForPresentedView(using: transitionContext) : animateForDismissdView(using: transitionContext)
    }
    
    func animateForPresentedView(using transitionContext: UIViewControllerContextTransitioning){
        guard let presentedDelegate = presentedDelegate,let indexPath = indexPath else{
            return
        }
        
        //1:取出弹出的view
        let prensentedView = transitionContext.view(forKey: .to)!
        
        //2.将prensentedView添加到containView中
        transitionContext.containerView.addSubview(prensentedView)
        
        ///获取执行动画的imageView
        let startRect = presentedDelegate.startRect(indexPath: indexPath)
        
        let imageView = presentedDelegate.imageView(indexPath: indexPath)
        imageView.frame = startRect
        transitionContext.containerView.addSubview(imageView)
        
        //3,执行动画
        prensentedView.alpha = 0.0
        transitionContext.containerView.backgroundColor = UIColor.black
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {() -> Void in
            imageView.frame = presentedDelegate.endRect(indexPath: indexPath)
        }) {(_) -> Void in
            imageView.removeFromSuperview()
            transitionContext.containerView.backgroundColor = UIColor.clear
            prensentedView.alpha = 1.0
            transitionContext.completeTransition(true)
        }
    }
    
    func animateForDismissdView(using transitionContext: UIViewControllerContextTransitioning){
        
        guard let dismissDelegate = dismissDelegate,let presentedDelegate = presentedDelegate else{
            return
        }
        
        //1:取出消失的view
        let dismissView = transitionContext.view(forKey: .from)!
        dismissView.removeFromSuperview()
        //2.将prensentedView添加到containView中
//        transitionContext.containerView.addSubview(dismissView)
        
        let imageView = dismissDelegate.imageViewForDismiss()
        transitionContext.containerView.addSubview(imageView)
        let indexPath = dismissDelegate.indexPathForDismiss()
        //3,执行动画
        
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {() -> Void in
//            dismissView.alpha = 0.0
            imageView.frame = presentedDelegate.startRect(indexPath: indexPath)
        }) {(_) -> Void in
            
            transitionContext.completeTransition(true)
        }
    }

}




