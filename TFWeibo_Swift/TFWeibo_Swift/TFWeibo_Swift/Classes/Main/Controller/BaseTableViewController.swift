//
//  BaseTableViewController.swift
//  TFWeibo_Swift
//
//  Created by Tengfei on 16/2/18.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController,NotLoginViewDelegate {

    //保存用户是否登陆
    var userLogin = UserAccount.useLogin()
    //保存未登录的界面
    var notLoginView:NotLoginView?
    
    
    override func loadView() {
        userLogin ? super.loadView() : initNotLoginView()
    
    }
    
    //NotLoginView delegate
    func loginBtnClick() {
       
    }
    //NotLoginView delegate
    func registerBtnClick() {
        let vc = OAuthViewController()
        let nav = UINavigationController(rootViewController: vc)
        presentViewController(nav  , animated: true, completion: nil)
    }
    
    private func initNotLoginView(){
        let customview = NotLoginView()
        view = customview
        customview.delegate = self
        notLoginView = customview
        
//        navigationController?.navigationBar.tintColor = UIColor.orangeColor()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: .Plain, target: self, action: "loginBtnClick")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登陆", style: .Plain, target: self, action: "registerBtnClick")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
