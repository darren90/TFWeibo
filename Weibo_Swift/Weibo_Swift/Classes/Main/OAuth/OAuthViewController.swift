//
//  OAuthViewController.swift
//  Weibo_Swift
//
//  Created by Tengfei on 16/11/29.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

import SVProgressHUD


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
//        print("---fillAccount---")
        //填充密码
        let jsCode = "document.getElementById('userId').value = 'fengtengfei90@163.com';document.getElementById('passwd').value = 'feng90';"
//        let jsCode = "document.getElementById('userId').value = '1005052145@qq.com';document.getElementById('passwd').value = 'honeyjiayi1314';"
        webView.stringByEvaluatingJavaScript(from: jsCode)
    }
    
    func loadPage()  {
        let urlStr = "https://api.weibo.com/oauth2/authorize?client_id=\(app_key)&redirect_uri=\(redirect_url)"
        webView.loadRequest(URLRequest(url: (URL(string: urlStr)!)))
    }
    
}


//准守协议
extension OAuthViewController : UIWebViewDelegate {
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        SVProgressHUD.show()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        SVProgressHUD.dismiss()
    }
    
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
//        let url = request.url?.absoluteString
        
        guard let url = request.url else {
            return true
        }
        
        let urlStr = url.absoluteString
//        print("---load:\(urlStr)")
        
        guard urlStr.contains("code=") else {
            return true
        }
        
        let code = urlStr.components(separatedBy: "code=").last!
        
        print("code:\(code)")
        
        loadAccesstoken(code: code)
        
        return false
    }
    
    //闭包中调用当前对象的方法需要调用self.
    func loadAccesstoken(code:String) {
        NetWorkTools.shareInstance.loadAccessToken(code: code) { (result : [String : AnyObject]?, error : NSError?) -> () in
            if error != nil {
                print(error ?? "")
                return
            }
            
//            print(result ?? "")
            guard let accountDict = result else {
                print("token 获取失败")
                return
            }
            
            let account = UserAccount(dict: accountDict)
//            print(account)
            
            //请求用户信息
            self.loadUserInfo(account: account)
        }
        
    }
    
    ///请求用户信息
    func loadUserInfo(account:UserAccount){
        
        guard let accessToken = account.access_token else {
            return
        }
        
        guard let uid = account.uid else {
            return
        }
        
        NetWorkTools.shareInstance.loadUserInfo(access_token: accessToken, uid: uid) {(result : [String : AnyObject]?, error : NSError?) -> () in
            if error != nil {
                print(error ?? "")
                return
            }
            
//            print(result ?? "")
            
            guard let userInfodict = result else {
                return
            }
            
            //添加昵称和头像地址
            account.screen_name = userInfodict["screen_name"] as? String
            account.avatar_large = userInfodict["avatar_large"] as? String
            
//            print(account)
            
            //保存account对象
            var accountPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            print(accountPath)
            accountPath = (accountPath as NSString).appendingPathComponent("account.plist")

            NSKeyedArchiver.archiveRootObject(account, toFile: accountPath)
            
            
        }
    }
}











