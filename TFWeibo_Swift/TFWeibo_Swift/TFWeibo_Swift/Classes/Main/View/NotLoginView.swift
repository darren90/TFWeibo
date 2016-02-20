//
//  NotLoginView.swift
//  TFWeibo_Swift
//
//  Created by Tengfei on 16/2/18.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

//Swift
protocol NotLoginViewDelegate: NSObjectProtocol{
    //登陆的回调
    func loginBtnClick()
    //注册的回调
    func registerBtnClick()
}

class NotLoginView: UIView {
    
    ///定义一个属性保存代理对象
    //加上weak。避免虚幻引用
    weak var delegate:NotLoginViewDelegate?
    
    //设置各个界面的初始化
    func setUpInfo(isHome:Bool,imageName:String,message:String){
        //不是首页，隐藏转盘
        iconView.hidden = !isHome
        homeIcon.image = UIImage(named: imageName)
        messageLabel.text = message
        
        //判断是否需要执行动画
        if isHome{
            startAnimation()
        }
    }
    

    override init(frame: CGRect) {
        super.init(frame:frame)
        
        //添加子控件
        addSubview(iconView)
        addSubview(maskBGView)
        addSubview(homeIcon)
        addSubview(messageLabel)
        addSubview(loginButton)
        addSubview(registerButton)
        
        iconView.xmg_AlignInner(type: .Center, referView: self, size: nil)
        homeIcon.xmg_AlignInner(type: .Center, referView: self, size: nil)
        messageLabel.xmg_AlignVertical(type: .BottomCenter, referView: iconView, size: nil)
        //添加宽度约束
        //“哪个控件”的“什么属性”“等于”“另外一个控件”的“什么属性”乘以”多少“ 加上 “多少”
        let widthCons = NSLayoutConstraint(item: messageLabel, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 224)
        addConstraint(widthCons)
        
        //按钮
        registerButton.xmg_AlignVertical(type: .BottomLeft, referView: messageLabel, size: CGSize(width: 100, height: 30), offset: CGPoint(x: 0, y: 20))
        
        loginButton.xmg_AlignVertical(type: .BottomRight, referView: messageLabel, size: CGSize(width: 100, height: 30), offset: CGPoint(x: 0, y: 20))
//        maskBGView.xmg_AlignInner(type: XMG_AlignType.Center, referView: self, size: nil)
            maskBGView.xmg_Fill(self)
    }

    
    private func startAnimation(){
        let anim = CABasicAnimation(keyPath: "transform.rotation")
        anim.toValue = 2 * M_PI
        anim.duration = 20
        //该属性默认为YES，代表动画执行完毕就移除
        anim.removedOnCompletion = false
        anim.repeatCount = MAXFLOAT
        iconView.layer.addAnimation(anim, forKey: nil)
    
        //创建动画
        //设置动画属性
        //将动画添加到图层上
    }
    
    //MARK: - 懒加载
    //背景
    private lazy var iconView:UIImageView = {
        let iv = UIImageView(image: UIImage(named: "visitordiscover_feed_image_smallicon"))
        return iv
    }()
    //图标
    private lazy var homeIcon :UIImageView = {
        let iv = UIImageView(image: UIImage(named: "visitordiscover_feed_image_house"))
        return iv
    }()
    //文本
    private lazy var messageLabel:UILabel = {
        let label = UILabel()
        label.text = "登陆后可以查看详细信息登陆后可以查看详细信息登陆后可以查看详细信息登陆"
        label.numberOfLines = 0
        label.textColor = UIColor.darkGrayColor()
        return label
    }()
    //登陆按钮
    private lazy var loginButton:UIButton = {
        let btn = UIButton()
        btn.setTitle("登陆", forState: .Normal)
        btn.setTitleColor(UIColor.darkGrayColor(), forState: .Normal)
        btn.setBackgroundImage(UIImage(named: "common_button_white_disable"), forState: .Normal)
        btn.addTarget(self, action: "registerBtnClick", forControlEvents: .TouchUpInside)
        return btn
    }()
    //注册按钮
    private lazy var registerButton:UIButton = {
        let btn = UIButton()
        btn.setTitle("注册", forState: .Normal)
        btn.setTitleColor(UIColor.orangeColor(), forState: .Normal)
        btn.setBackgroundImage(UIImage(named: "common_button_white_disable"), forState: .Normal)
        btn.addTarget(self, action: "loginBtnClick", forControlEvents: .TouchUpInside)
        return btn
    }()
    
    func loginBtnClick(){
        delegate?.loginBtnClick()
    }
    
    func registerBtnClick(){
        delegate?.registerBtnClick()
    }
    
    
    private lazy var maskBGView:UIImageView = {
        let iv = UIImageView(image: UIImage(imageLiteral: "visitordiscover_feed_mask_smallicon"))
        
        return iv
    }()
    
    
    
    //Swift推荐我们自定义一个控件，纯代码 、xib
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
