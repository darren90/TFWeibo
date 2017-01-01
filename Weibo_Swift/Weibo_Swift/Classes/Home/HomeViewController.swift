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
    
    lazy var tipLabel:UILabel = UILabel()
    
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
        setUpFooterView()
        
        setUpTiplabel()
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
    
    func setUpFooterView(){
        tableView.mj_footer = MJRefreshAutoFooter(refreshingTarget: self, refreshingAction: #selector(self.loadMoreStatus))
    }
    
    func setUpTiplabel() {
        navigationController?.navigationBar.insertSubview(tipLabel, at: 0)
//        navigationController?.navigationBar.addSubview(tipLabel)
        tipLabel.frame = CGRect(x: 0, y: 10, width: UIScreen.main.bounds.width, height: 32)
        tipLabel.backgroundColor = UIColor.orange
        tipLabel.textColor = UIColor.white.withAlphaComponent(0.6)
        tipLabel.font = UIFont.systemFont(ofSize: 14)
        tipLabel.isHidden = true
        tipLabel.textAlignment = .center
    }
    
    func showTipLabel(count:Int){
        tipLabel.isHidden = false
        tipLabel.text = count == 0 ? "没有新数据" : "\(count)条数据"
        
        UIView.animate(withDuration: 1.0, animations: {() -> Void in
           self.tipLabel.frame.origin.y = 44
        }) {(_) -> Void in
            UIView.animate(withDuration: 1.0, delay: 0.5, options: [], animations: { 
                self.tipLabel.frame.origin.y = 10
            }, completion: { (_) in
                self.tipLabel.isHidden = true
            })
        }
    }
    
}

//MARK: -- 请求数据
extension HomeViewController {
    func loadStatus(isNewData:Bool) {
        
        //获取since_id/max_id
        var since_id = 0
        var max_id = 0
        if isNewData {
            since_id = viewModels.first?.status?.mid ?? 0
        }else{
            max_id = viewModels.last?.status?.mid ?? 0
            max_id = max_id == 0 ? 0 :(max_id - 1)
        }

        NetWorkTools.shareInstance.loadStatus(since_id:since_id,max_id: max_id) {(result,error) -> () in
            if error != nil {
                print(error ?? "")
                return
            }
            
            guard let resultArray = result else {
                return
            }
            
            var tempViewModel = [StatusViewModel]()
            //遍历字典
            for statusDict in resultArray {
                let status = Status(dict: statusDict)
                let viewMoel = StatusViewModel(status:status)
//                self.viewModels.append(viewMoel)
                tempViewModel.append(viewMoel)
            }
            
            if isNewData{
                self.viewModels = tempViewModel + self.viewModels
            }else{
                self.viewModels = self.viewModels + tempViewModel
            }
            
            
            //先缓存图片，获取图片的宽高，在刷新
            self.cacheImages(viewModels: tempViewModel)
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
            self.tableView.mj_footer.endRefreshing()
            
            //显示提示Lable
            self.showTipLabel(count: self.viewModels.count)
        }
    }
    
    
    func loadNewStatus(){
        loadStatus(isNewData: true)
    }
    
    func loadMoreStatus(){
        loadStatus(isNewData: false)
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

/* *
 https://api.weibo.com/2/statuses/update.json
 
 
 access_token	true	string	采用OAuth授权方式为必填参数，OAuth授权后获得。
 status	true	string	要发布的微博文本内容，必须做URLencode，内容不超过140个汉字。
 visible	false	int	微博的可见性，0：所有人能看，1：仅自己可见，2：密友可见，3：指定分组可见，默认为0。
 list_id	false	string	微博的保护投递指定分组ID，只有当visible参数为3时生效且必选。
 lat	false	float	纬度，有效范围：-90.0到+90.0，+表示北纬，默认为0.0。
 long	false	float	经度，有效范围：-180.0到+180.0，+表示东经，默认为0.0。
 annotations	false	string	元数据，主要是为了方便第三方应用记录一些适合于自己使用的信息，每条微博可以包含一个或者多个元数据，必须以json字串的形式提交，字串长度不超过512个字符，具体内容可以自定。
 rip	false	string	开发者上报的操作用户真实IP，形如：211.156.0.1。
 注意事项
 */






















