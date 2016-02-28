//
//  QRCodeViewController.swift
//  TFWeibo_Swift
//
//  Created by Tengfei on 16/2/20.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit
import AVFoundation

class QRCodeViewController: UIViewController,UITabBarDelegate {
    @IBOutlet weak var closeBtnClick: UIBarButtonItem!
    @IBOutlet weak var bottomTabBar: UITabBar!
    
    //扫描视图
    @IBOutlet weak var scanView: UIImageView!
    //扫描视图
    @IBOutlet weak var ScanLineCons: NSLayoutConstraint!
    //扫描容器的高度
    @IBOutlet weak var containerHeightCons: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //1,底部视图，默认选中第0个
        bottomTabBar.selectedItem = bottomTabBar.items![0]
        bottomTabBar.delegate = self
    }
    
    @IBAction func closeBtnDidClick(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
  
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
  
        //1:开始扫描动画
        startAnimation()
    
        //2：开始扫描
        startScan()
        
    }
    
    private func startScan(){
        //1：判断是否能够将输入添加到会话中
        if !session.canAddInput(deviceInput){
            return
        }
        //2：判断是否能够将输出添加到会话中
        if !session.canAddOutput(output){
            return
        }
        
        //3：将输入，输出都添加到会话中
        session.addInput(deviceInput)
        print(output.metadataObjectTypes)
        session.addOutput(output)
        print(output.metadataObjectTypes)
        //4：设置能够解析的数据类型
        output.metadataObjectTypes = output.availableMetadataObjectTypes
        //5：设置输出对象的代理，只要解析成功，就会通知代理
        
        output.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
        //6：告诉session开始扫描
        session.startRunning()
    }
    
    private func startAnimation(){
        self.ScanLineCons.constant = -self.containerHeightCons.constant
        self.scanView.layoutIfNeeded()
        
        //执行扫描视图的动画
        UIView.animateWithDuration(2.0, animations: { () -> Void in
            //修改约束
            self.ScanLineCons.constant = self.containerHeightCons.constant
            //强制更新界面
            UIView.setAnimationRepeatCount(MAXFLOAT)
            self.scanView.layoutIfNeeded()
        })
    }
    
    //MARK : - 懒加载
    
    //1:会话
    private lazy var session:AVCaptureSession = AVCaptureSession()
    //拿到输入设备
    private lazy var deviceInput :AVCaptureDeviceInput? = {
        ///获取摄像头
        let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        do {
            let input = try  AVCaptureDeviceInput(device: device)
            return input
        }catch{
            print(error)
            return nil
        }
    }()
    //拿到输出对象
    private lazy var output :AVCaptureMetadataOutput = AVCaptureMetadataOutput()
    
    //创建预览图层
//    private lazy var previewLayer:AVCaptureVideoPreviewLayer = {
//        let layer = AVCaptureVideoPreviewLayer(session: self.session)
//        layer.frame = UIScreen.mainScreen.().bounds
//        return layer
//    }()
 
    
    private lazy var previewLayer: AVCaptureVideoPreviewLayer = {
        let layer = AVCaptureVideoPreviewLayer(session: self.session)
//        layer.frame = UIScreen.mainScreen.().bounds
//        layer.frame = UIScreen.m
        return layer
    }()
    
    
   

    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        //1：修改容器高度
        if item.tag == 1{
            self.containerHeightCons.constant = 300
        }else {
            self.containerHeightCons.constant = 150
        }
        //停止动画
        self.scanView.layer.removeAllAnimations()
        startAnimation()
    }
  
}


extension QRCodeViewController: AVCaptureMetadataOutputObjectsDelegate
{
    // 只要解析到数据就会调用
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!)
    {
        // 注意: 要使用stringValue
        print(metadataObjects.last?.stringValue)
//        resultLabel.text = metadataObjects.last?.stringValue
//        resultLabel.sizeToFit()
    }
}
