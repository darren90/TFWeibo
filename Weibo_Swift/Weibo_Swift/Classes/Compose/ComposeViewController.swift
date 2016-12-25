//
//  ComposeViewController.swift
//  Weibo_Swift
//
//  Created by Tengfei on 2016/12/25.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {
    @IBOutlet weak var textView: ComposeTextView!
    @IBOutlet weak var toolBarBottomCons: NSLayoutConstraint!

    lazy var titleView:ComposeTitleView = ComposeTitleView()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        textView.becomeFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //设置导航栏
        
        setUpNavBar()
        
        //
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillChangeFrame(notice:)), name: .UIKeyboardWillChangeFrame, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    @IBAction func pictPIckAction(_ sender: UIButton) {
        
    }
    
    @IBAction func atAction(_ sender: UIButton) {
    }
 
    
    @IBAction func huatiAction(_ sender: UIButton) {
        
    }
    
    @IBAction func biaoqingAction(_ sender: UIButton) {
        
    }
 
    @IBAction func noAction(_ sender: UIButton) {
        
    }
  
}

//MARK: -- 设置
extension ComposeViewController {
    func setUpNavBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: .plain, target: self, action: #selector(self.closeSelf))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发送", style: .plain, target: self, action: #selector(self.sendWeibo))
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        titleView.frame = CGRect(x: 0, y: 0, width: 200, height: 40)
        navigationItem.titleView = titleView
    }
    
    func closeSelf(){
        dismiss(animated: true, completion: nil)
    }
    
    func sendWeibo() {
        print("sendWeibo---")
    }
    
    func keyboardWillChangeFrame(notice:Notification){
//        UIKeyboardAnimationDurationUserInfoKey  0.25
//        UIKeyboardFrameEndUserInfoKey   258
//        print("notice--:\(notice.userInfo!)")
        let dutation = notice.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! Double
//        AnyHashable("UIKeyboardFrameEndUserInfoKey"): NSRect: {{0, 409}, {375, 258}}, 
        //NSvalue ---
        let endFrame = (notice.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let y = endFrame.origin.y
        let margin = UIScreen.main.bounds.height - y
        
        toolBarBottomCons.constant = margin
        UIView.animate(withDuration: dutation){() -> Void in
            self.view.layoutIfNeeded()
        }
    }
    
    
}


//MARK: --- 代理
extension ComposeViewController : UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
//        print(textView.text)
        self.textView.placeHolderLabel.isHidden = self.textView.hasText
        navigationItem.rightBarButtonItem?.isEnabled = self.textView.hasText
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.textView.resignFirstResponder()
    }
}












