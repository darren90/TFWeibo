//
//  NotLoginView.swift
//  TFWeibo_Swift
//
//  Created by Tengfei on 16/2/18.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class NotLoginView: UIView {

    override init(frame: CGRect) {
        super.init(frame:frame)
        
        //添加子控件
        
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
        
        return label
    }()
    //登陆按钮
    private lazy var loginButton:UIButton = {
        let btn = UIButton()
        return btn
    }()
    //注册按钮
    private lazy var registerButton:UIButton = {
        let btn = UIButton()
        return btn
    }()
    
    //Swift推荐我们自定义一个控件，纯代码 、xib
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
