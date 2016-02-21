//
//  OAuthViewController.swift
//  TFWeibo_Swift
//
//  Created by Tengfei on 16/2/20.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit
import SVProgressHUD


class OAuthViewController: UIViewController {
//    App Key：1470767324
//    App Secret：8058457ae6865540c4d20d6409006529
    let APPKey = "1470767324"
    let APPSecret = "8058457ae6865540c4d20d6409006529"
    let APPRedirect_Uri = "https://www.baidu.com/"
    
    override func loadView() {
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title  = "大风车转转登陆"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "关闭", style: .Plain, target: self, action: "closeVc")

        //获取未授权的RequestToken
        let urlString = "https://api.weibo.com/oauth2/authorize?client_id=\(APPKey)&redirect_uri=\(APPRedirect_Uri)"
        let url = NSURL(string:urlString)!
        let request = NSURLRequest(URL: url)
        webView.loadRequest(request)
    }
    
    func closeVc(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    private lazy var webView:UIWebView = {
        let webview = UIWebView()
        webview.delegate = self
        return webview
    }()

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 

}

extension OAuthViewController:UIWebViewDelegate
{
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
//        print(request.URL?.absoluteString)
        if ((request.URL?.absoluteString.containsString("code=")) == true){
            let code = request.URL?.query?.substringFromIndex("code=".endIndex)
            print("code=:\(code!)")
            //拿到AccessToken
            loadAccessToken(code!)
            
            return false
        }
        return true
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        SVProgressHUD.showInfoWithStatus("正在加载", maskType: .Black)
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        SVProgressHUD.dismiss()
    }
    
    
    private func loadAccessToken(code :String){
        let url = "oauth2/access_token"
        
//        client_id	true	string	申请应用时分配的AppKey。
//        client_secret	true	string	申请应用时分配的AppSecret。
//        grant_type	true	string	请求的类型，填写authorization_code
//        必选	类型及范围	说明
//        code	true	string	调用authorize获得的code值。
//        redirect_uri	true	string	回调地址，需需与注册应用里的回调地址一致。
        
        let params = ["client_id":APPKey, "client_secret":APPSecret, "grant_type":"authorization_code", "code":code, "redirect_uri":APPRedirect_Uri]

        APINetTools.post(url, params: params, success: { (json) -> Void in
            print("----ALA--");
            print(json)
            let user = UserAccount(dict: json as! [String : AnyObject])
//            print(user)
            user.saveAccount()
            
            }) { (error) -> Void in
                print(error)
        }
        
        
//        NetWorkTools.shareNetWorkTools().POST(url, parameters: params, success: { (_, JSON) -> Void in
//            print("----AFN--");
//            print(JSON)
//        }) { (_, error) -> Void in
//            print(error)
//        }
    }
}









