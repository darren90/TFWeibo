//
//  BaseViewController.swift
//  Weibo_Swift
//
//  Created by Tengfei on 16/11/24.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class BaseViewController: UITableViewController {

    // MARK：-- 懒加载
    lazy var visitorView = VisitorView.visitorView()
    
    //MARK: -- 定义变量
    
    var isLogin:Bool = false
    
    override func loadView() {
        isLogin ? super.loadView() : setupVisitorView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavItems()
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


extension BaseViewController{
    // MARK:-- 设置访客视图
    func setupVisitorView(){
//        visitorView.backgroundColor = UIColor.brown
        view = visitorView
        
        visitorView.rigisterBtn.addTarget(self, action: #selector(BaseViewController.registerClick), for: .touchUpInside)
        visitorView.loginBtn.addTarget(self, action: #selector(BaseViewController.loginClick), for: .touchUpInside)

    }
    
    // MARK:--
    
    func setupNavItems()  {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: .plain, target: self, action: #selector(BaseViewController.registerClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登陆", style: .plain, target: self, action: #selector(BaseViewController.loginClick))

    }
    
    func registerClick()  {
        print("---registerClick---")
    }
    
    func loginClick()  {
        print("---loginClick---")
        
        //授权
        let oauthVc = OAuthViewController()
        
        //包装导航控制器
        let oauthNav = UINavigationController(rootViewController: oauthVc)
        
        self.navigationController?.present(oauthNav, animated: true, completion: nil)
        
    }
}






















