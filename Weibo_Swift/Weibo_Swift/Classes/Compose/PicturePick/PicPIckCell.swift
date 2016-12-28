//
//  PicPIckCell.swift
//  Weibo_Swift
//
//  Created by Tengfei on 2016/12/28.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class PicPIckCell: UICollectionViewCell {
    @IBOutlet weak var deleView: UIImageView!
    @IBOutlet weak var btn: UIButton!
    
    var image:UIImage? {
        didSet {
            if image != nil {
                btn.setBackgroundImage(image, for: .normal)
                btn.isUserInteractionEnabled = false
                deleView.isHidden = false
            }else{
                btn.setBackgroundImage(UIImage(named:"compose_pic_add"), for: .normal)
                btn.isUserInteractionEnabled = true
                deleView.isHidden = true
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        btn.imageView?.contentMode = .scaleAspectFill
        deleView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.delPhoto))
        deleView.addGestureRecognizer(tap)
    }
    
    @IBAction func addPhotoAction(_ sender: UIButton) {
//            print("---")

        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "PicPickAddPhotoNote"), object: nil, userInfo: nil)
        
    }
    
    func delPhoto() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: PicPickRemovePhotoNote), object: image, userInfo: nil)
    }

}





