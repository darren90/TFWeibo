//
//  ComposeViewController.swift
//  Weibo_Swift
//
//  Created by Tengfei on 2016/12/25.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit
import SVProgressHUD

class ComposeViewController: UIViewController {
    @IBOutlet weak var textView: ComposeTextView!
    @IBOutlet weak var toolBarBottomCons: NSLayoutConstraint!
    @IBOutlet weak var pickViewH: NSLayoutConstraint!
    @IBOutlet weak var pickView: PicPIckView!

    lazy var titleView:ComposeTitleView = ComposeTitleView()
    lazy var imags:[UIImage] = [UIImage]()
    
    
    lazy var emotionVC:EmotionViewController = EmotionViewController {[weak self] (emoticon) -> () in
        //        print(emoticon)
        //        weak.textView.text = "sdf"
        self!.textView.insetEmotion(emoticon:emoticon)
        self!.textViewDidChange(self!.textView)
    }
    
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
        
        //选中图片
        NotificationCenter.default.addObserver(self, selector: #selector(self.addPhoto), name: NSNotification.Name(rawValue: "PicPickAddPhotoNote"), object: nil)
        //删除图片
        NotificationCenter.default.addObserver(self, selector: #selector(self.delePhot(note:)), name: NSNotification.Name(rawValue: PicPickRemovePhotoNote), object: nil)
        
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    ///添加照片
    func addPhoto() {
        // 1 判断照片源是否可用
        if !UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            return
        }
        
        let ipc = UIImagePickerController()
        //设置照片源头
        ipc.sourceType = .photoLibrary
        ipc.delegate = self
        
        //弹出控制器        
        present(ipc,animated:true,completion:nil)
        
    }
    //删除照片
    func delePhot(note:NSNotification){
        guard let image = note.object as? UIImage else{
            return
        }
        guard let index = imags.index(of: image) else {
            return
        }
        
        imags.remove(at: index)
        pickView.images = imags
    }
    
    @IBAction func pictPIckAction(_ sender: UIButton) {
        //退出键盘
        textView.resignFirstResponder()
//        pickView.backgroundColor = UIColor.brown
        pickViewH.constant = UIScreen.main.bounds.height * 0.35
        //执行动画
        UIView.animate(withDuration: 0.3){ () -> Void in
            self.view.layoutIfNeeded()
            print("--p:\(self.pickView.frame)")
        }
    }
    
    @IBAction func atAction(_ sender: UIButton) {
    }
 
    
    @IBAction func huatiAction(_ sender: UIButton) {
        
    }
    
    //表情
    @IBAction func biaoqingAction(_ sender: UIButton) {
        // 1 - 退出键盘
        textView.resignFirstResponder()
        // 2 - 切换键盘
        textView.inputView = (textView.inputView != nil ? nil : emotionVC.view)
        // 3 - 弹出新键盘
        textView.becomeFirstResponder()
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
    
    // MARK:-- 发送微博
    func sendWeibo() {
        print(textView.getEmotionStr())
//        print("sendWeibo---")
        textView.resignFirstResponder()
        
        let statusText = textView.getEmotionStr()
        NetWorkTools.shareInstance.sendStatus(statusText: statusText) {(isSuccess) -> () in
            if !isSuccess {
                SVProgressHUD.showError(withStatus: "发送失败")
                return
            }
            SVProgressHUD.showSuccess(withStatus: "发送成功")
            self.dismiss(animated: true, completion: nil)
        }
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

//图片选择器
extension ComposeViewController : UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        print(info)
        //获取选中的照片
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        //展示照片
        imags.append(image)
        //将数组赋值为collectionview
        pickView.images = imags
        
        //退出选中照片控制器
        picker.dismiss(animated: true, completion: nil)
        
    }
    
}










