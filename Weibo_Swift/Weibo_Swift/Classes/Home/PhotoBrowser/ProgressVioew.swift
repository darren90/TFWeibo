//
//  ProgressVioew.swift
//  Weibo_Swift
//
//  Created by Tengfei on 2017/1/5.
//  Copyright © 2017年 tengfei. All rights reserved.
//

import UIKit

class ProgressVioew: UIView {

    // MARK:-- 
    var progress:CGFloat = 0 {
        didSet{
            setNeedsDisplay()
            
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        //创建贝塞尔曲线
        let center = CGPoint(x: rect.width*0.5, y: rect.height*0.5)
        let radius = rect.width * 0.5 - 3
        let startAngle = CGFloat(-M_PI_2)
        let endAngle = CGFloat(2*M_PI)*progress + startAngle
        
        let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        //绘制到中心点的线
        path.addLine(to: center)
        path.close()
        UIColor.init(white: 1.0, alpha: 0.4).setFill()
        
        //开始绘制 --- 实心
        path.fill()
        
    }

}
