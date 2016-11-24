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
    func setupVisitorView(){
//        visitorView.backgroundColor = UIColor.brown
        view = visitorView
    }
}






















