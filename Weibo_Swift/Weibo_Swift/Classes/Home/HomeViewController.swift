//
//  HomeViewController.swift
//  Weibo_Swift
//
//  Created by Tengfei on 16/11/22.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {

    // MARK:-- 属性
//    var isPresendted = false
    
    ///注意在闭包中，如果使用当前属性，或者调用方法，也需要调用self
//    有两个地方需要用到self。1》 如果在一个函数中出现歧意，2》在比保重使用了当前对象的属性和方法也需要加self
    lazy var popoverAnimator : PopoverAnimator = PopoverAnimator{ [weak self] (isPresendted) -> () in
        self?.titleBtn.isSelected = isPresendted
    }
    
    // MARK:-- 懒加载属性
    lazy var titleBtn:UIButton = TitleButton()
    
    lazy var statuses : [Status] = [Status]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        visitorView.rotationAnim()
        if !isLogin {
            return
        }
        
        //设置导航栏的内容
        setupNavBar()
        
        //请求数据
        loadStatus()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
//        titleBtn.isSelected = !titleBtn.isSelected
        
        //自定义专场
        let vc = PopoverViewController()
        
        //设置modar样式
        //设置为custom样式，底下的控制器，就不被移除，正常情况下，底下的控制器，会被移除
        vc.modalPresentationStyle = .custom
        
        //自定义转场动画
        
        //设置转场代理
        vc.transitioningDelegate = popoverAnimator;
        //封装后，设置弹出view的frame
        popoverAnimator.presentedFrame = CGRect(x: 100, y: 60, width: 180, height: 250)
        
        present(vc, animated: true, completion: nil)
    }    
    
}

//MARK: -- 请求数据
extension HomeViewController {
    func loadStatus() {
        NetWorkTools.shareInstance.loadStatus{(result,error) -> () in
            if error != nil {
                print(error ?? "")
                return
            }
            
            guard let resultArray = result else {
                return
            }
            
            //遍历字典
            for statusDict in resultArray {
                let status = Status(dict: statusDict)
                self.statuses.append(status)
                
            }
            self.tableView.reloadData()
        }
    }
}

extension HomeViewController{
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

 
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//    }
}























