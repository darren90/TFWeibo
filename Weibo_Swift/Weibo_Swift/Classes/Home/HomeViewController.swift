//
//  HomeViewController.swift
//  Weibo_Swift
//
//  Created by Tengfei on 16/11/22.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {

    // MARK:-- 懒加载属性
    lazy var titleBtn:UIButton = TitleButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        visitorView.rotationAnim()
        if !isLogin {
            return
        }
        
        //设置导航栏的内容
        setupNavBar()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

}

extension HomeViewController {
    
    func setupNavBar() {
        //1：设置左边的
//        let leftBtn = UIButton()
//        leftBtn.setImage(UIImage(named: "navigationbar_friendattention"), for: .normal)
//        leftBtn.setImage(UIImage(named: "navigationbar_friendattention_highlighted"), for: .highlighted)
//        leftBtn.sizeToFit()
//        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBtn)
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "navigationbar_friendattention")
        
        //2：设置右边的item
//        let rightBtn = UIButton()
//        rightBtn.setImage(UIImage(named: "navigationbar_pop"), for: .normal)
//        rightBtn.setImage(UIImage(named: "navigationbar_pop_highlighted"), for: .highlighted)
//        rightBtn.sizeToFit()
//        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBtn)
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "navigationbar_pop")
        
        //3:设置titleView
 
        navigationItem.titleView = titleBtn
        titleBtn.addTarget(self, action: #selector(HomeViewController.titleBtnClick(titleBtn:)), for: .touchUpInside)
    }
    
    
    func titleBtnClick(titleBtn:TitleButton){
        titleBtn.isSelected = !titleBtn.isSelected
        
        //自定义专场
        let vc = PopoverViewController()
        
        //设置modar样式
        //设置为custom样式，底下的控制器，就不被移除，正常情况下，底下的控制器，会被移除
        vc.modalPresentationStyle = .custom
        
        //自定义转场动画
        
        //设置转场代理
        vc.transitioningDelegate = self;
        
        present(vc, animated: true, completion: nil)
    }
    
    
    
}

//转场代理
extension HomeViewController: UIViewControllerTransitioningDelegate{
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        
        
        return TFPresentationController(presentedViewController: presented, presenting : presenting)
    }
    
}

















