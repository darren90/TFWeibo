//
//  HomeTableViewController.swift
//  TFWeibo_Swift
//
//  Created by Tengfei on 16/2/16.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class HomeTableViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //没有登陆，就设置未登录的界面信息
        if !userLogin{
            notLoginView?.setUpInfo(true, imageName: "visitordiscover_feed_image_house", message: "关注一些人，回这里看看有什么惊喜")
        }else{
            setupNav()
        }
        
    }
    
    
    // 初始化导航条
    private func setupNav(){
        navigationItem.leftBarButtonItem = createNavItem("navigationbar_friendattention", target: self, action: "leftBtnClick")
        navigationItem.rightBarButtonItem = createNavItem("navigationbar_pop",target: self, action: "rightBtnClick")
        
        //初始化标题按钮
        let titleBtn = HomeTitleBtn()
        titleBtn.setTitle("飞哥 ", forState: .Normal)
        titleBtn.setTitleColor(UIColor.darkTextColor(), forState: .Normal)
        titleBtn.setImage(UIImage(named: "navigationbar_arrow_down"), forState: .Normal)
        titleBtn.setImage(UIImage(named: "navigationbar_arrow_up"), forState: .Selected)
        titleBtn.addTarget(self, action: "titleBtnClick:", forControlEvents: .TouchUpInside)
        titleBtn.sizeToFit()
        navigationItem.titleView = titleBtn
    }
    
    func titleBtnClick(btn:UIButton){
        btn.selected = !btn.selected
        
        //弹出菜单
        let sb = UIStoryboard(name: "PopoverViewController", bundle: nil)
        let vc = sb.instantiateInitialViewController()!
        //设置谁来负责专场，
        //默认情况下，modal会移除以前的控制器view，替换为当前弹出的view，但是如果自定义转场，就不会移除以前控制器的view
        vc.transitioningDelegate = self
        //设置转场样式
        vc.modalPresentationStyle = UIModalPresentationStyle.Custom
        presentViewController(vc, animated: true, completion: nil)
    }
    
    
    
    private func createNavItem(image:String,target:AnyObject?, action: Selector) -> UIBarButtonItem{
        let rigntBtn = UIButton()
        rigntBtn.setImage(UIImage(named: image), forState: .Normal)
        rigntBtn.setImage(UIImage(named: image + "_highlighted"), forState: .Highlighted)
        rigntBtn.addTarget(target, action: action, forControlEvents: .TouchUpInside)
        rigntBtn.sizeToFit()
        return UIBarButtonItem(customView: rigntBtn)
    }
    
    func leftBtnClick(){
        
    }
    func rightBtnClick(){
        let sb = UIStoryboard(name: "QRCodeViewController", bundle: nil)
        let vc = sb.instantiateInitialViewController()!
        presentViewController(vc, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
 
}
/// 记录当前是否是展开
var isPresent: Bool = false
//遵守的协议
extension HomeTableViewController:UIViewControllerTransitioningDelegate,UIViewControllerAnimatedTransitioning
{
    //实现代理，告诉系统谁来负责转场动画
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController?  {
    
        return PopoverPresentationController(presentedViewController: presented, presentingViewController: presenting)
    }
    
    /**
    *  告诉系统，谁来负责modal的展现
    */
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        isPresent = true

        return self
    }
    
    
    //告诉系统，谁来负责modal转场
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        isPresent = false

        return self
    }
    
    
    //UIViewControllerAnimatedTransitioning的代理
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval
    {
        return 0.5
    }
    // This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
    //告诉系统如何动画，无论展现还是消失，都会调用这个方法
    func animateTransition(transitionContext: UIViewControllerContextTransitioning)
    {
        //1.拿到展现视图
//        let toVc = transitionContext.viewControllerForKey("UITransitionContextToViewControllerKey")
//        let fromVc = transitionContext.viewControllerForKey("UITransitionContextFromViewControllerKey")
        
        if isPresent
        {
            // 展开
            print("展开")
            let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
            toView.transform = CGAffineTransformMakeScale(1.0, 0.0);
            
            // 注意: 一定要将视图添加到容器上
            transitionContext.containerView()?.addSubview(toView)
            
            // 设置锚点
            toView.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
            
            // 2.执行动画
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                // 2.1清空transform
                toView.transform = CGAffineTransformIdentity
                }) { (_) -> Void in
                    // 2.2动画执行完毕, 一定要告诉系统
                    // 如果不写, 可能导致一些未知错误
                    transitionContext.completeTransition(true)
            }
        }else
        {
            // 关闭
            print("关闭")
            let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)
            
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                // 注意:由于CGFloat是不准确的, 所以如果写0.0会没有动画
                // 压扁
                fromView?.transform = CGAffineTransformMakeScale(1.0, 0.0)
                }, completion: { (_) -> Void in
                    // 如果不写, 可能导致一些未知错误
                    transitionContext.completeTransition(true)
            })
        }


    }
    

    
}
