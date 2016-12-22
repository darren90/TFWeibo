//
//  WellcomeViewController.swift
//  Weibo_Swift
//
//  Created by Tengfei on 2016/12/23.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit
import SDWebImage

class WellcomeViewController: UIViewController {

    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var iconViewBottomCons: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        self.view.
        let urlStr = UserAccountViewModel.shareInstance.account?.avatar_large
        let url = URL(string: urlStr ?? "")
        iconView.sd_setImage(with: url, placeholderImage: UIImage(named: "avatar_default_big"))
        
        iconViewBottomCons.constant = UIScreen.main.bounds.height - 250
        
        //执行动画
//        Damping 阻力系数：阻力系数越大，弹懂越不明显 0-1
//        initialSpringVelocity 初始化速度
//        swift中枚举值不想传值，直接[],多个值也是[..]
        UIView.animate(withDuration: 1.5, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 5.0, options: [], animations: {() -> Void in
            self.view.layoutIfNeeded()
        }){(_) -> Void in
            UIApplication.shared.keyWindow?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
