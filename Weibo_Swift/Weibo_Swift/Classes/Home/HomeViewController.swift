//
//  HomeViewController.swift
//  Weibo_Swift
//
//  Created by Tengfei on 16/11/22.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit
import SDWebImage
import MJRefresh

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
    
    lazy var viewModels : [StatusViewModel] = [StatusViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        visitorView.rotationAnim()
        if !isLogin {
            return
        }
        
        //设置导航栏的内容
        setupNavBar()
        
        //请求数据
//        loadStatus()
        
        //最底部的空间，设置距离底部的间距（autolayout），然后再设置这两个属性，就可以自动计算高度
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        
//        refreshControl = UIRefreshControl()
        //头部空间
        setUpHeaderView()
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
    
    
    func setUpHeaderView() {
        let header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(self.loadNewStatus))
        //设置属性
        header?.setTitle("下拉刷新...", for: .idle)
        header?.setTitle("释放刷新...", for: .pulling)
        header?.setTitle("加载中...", for: .refreshing)
        tableView.mj_header = header
        tableView.mj_header.beginRefreshing()
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
                let viewMoel = StatusViewModel(status:status)
                self.viewModels.append(viewMoel)
                
            }
            
            //先缓存图片，获取图片的宽高，在刷新
            self.cacheImages(viewModels: self.viewModels)
//            self.tableView.reloadData()
        }
    }
    
    func cacheImages(viewModels:[StatusViewModel]) {
        //创建group
        let group = DispatchGroup()
        
        for viewModel in viewModels {
            for picUrl in viewModel.picUrls {
                group.enter()
                SDWebImageManager.shared().downloadImage(with: picUrl, options: [], progress: nil, completed: { (_, _, _, _, _) in
//                    print("下载了一张图片")
                    group.leave()
                })
            }
        }
        
        group.notify(queue: .main){() -> () in
            print("down-all-image-OK")
            //刷新表格
            self.tableView.reloadData()
            self.tableView.mj_header.endRefreshing()
        }
    }
    
    func loadNewStatus(){
//        print("--loadNewStatus--")
        loadStatus()
    }
    
}

extension HomeViewController{
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }

 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell") as! HomeViewCell
        let viewModel = viewModels[indexPath.row]
        cell.viewModel = viewModel
        return cell
    }
    
}























