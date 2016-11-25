//
//  VisitorView.swift
//  Weibo_Swift
//
//  Created by Tengfei on 16/11/25.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class VisitorView: UIView {

    // MARK:-- 提供快读通过xib创建的类方法
    class func visitorView() -> VisitorView{
        return Bundle.main.loadNibNamed("VisitorView", owner: nil, options: nil)?.first as! VisitorView
    }
    
    // MARK：-- 控件属性
    @IBOutlet weak var rotationView: UIImageView!
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var tipLabel: UILabel!
    
    
    // MARK:-- 自定义函数
    func setUpVisitoryViewInfo(iconName:String,title:String) {
        iconView.image = UIImage(named: iconName)
        tipLabel.text = title
        rotationView.isHidden = true
    }

    //旋转动画
    func rotationAnim() {
        //1:创建动画，
//        CAKeyframeAnimation : values
//        CABasicAnimation
        
        let rotationAnim = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnim.fromValue = 0
        rotationAnim.toValue = M_PI * 2
        rotationAnim.repeatCount = MAXFLOAT
        rotationAnim.duration = 10
        rotationAnim.isRemovedOnCompletion = false
        //将动画，添加到图层中
        rotationView.layer.add(rotationAnim, forKey: nil)
        
        //核心动画，进入后台，就不执行了
    }
    
}






