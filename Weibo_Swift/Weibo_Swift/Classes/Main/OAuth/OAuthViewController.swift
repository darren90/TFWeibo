//
//  OAuthViewController.swift
//  Weibo_Swift
//
//  Created by Tengfei on 16/11/29.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit


class OAuthViewController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupNavBar()
        
        loadPage()
    }
}

extension OAuthViewController {
    func setupNavBar() {
        //设置返回按钮
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: .done, target: self, action: #selector(OAuthViewController.close))
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "填充", style: .done, target: self, action: #selector(OAuthViewController.fillAccount))
        
        title = "授权页面"
    }
    
    func close() {
        dismiss(animated: true, completion: nil)
    }
    func fillAccount(){
        print("---fillAccount---")
    }
    
    func loadPage()  {
        
        webView.loadRequest(URLRequest(url: (URL(string: "https://api.weibo.com/oauth2/authorize?client_id=\(app_key)&redirect_uri=\(redirect_url)")!)))
    }
    
}


//extension OAuthViewController , UIWebViewDelegate {
//    
//}











