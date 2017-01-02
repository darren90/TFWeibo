//
//  EmoticonCell.swift
//  01-表情键盘
//
//  Created by Tengfei on 2016/12/30.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

class EmoticonCell: UICollectionViewCell {
    
    var emoticon:Emoticon? {
        didSet{
            guard let emoticon = emoticon else{
                return
            }
            
            //设置内容
            let img = UIImage(contentsOfFile: emoticon.pngPath ?? "")
            eBtn.setImage(img, for: .normal)
            eBtn.setTitle(emoticon.emojiCode, for: .normal)
            
            //设置删除按钮
            if emoticon.isRemove == true {
                eBtn.setImage(UIImage(named:"compose_emotion_delete"), for: .normal)
            }
        }
    }
    
    //定义属性
    lazy var eBtn:UIButton = UIButton()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addUI() {
        
        contentView.addSubview(eBtn)
        eBtn.titleLabel?.font = UIFont.systemFont(ofSize: 32)
        eBtn.frame = contentView.bounds
        eBtn.isUserInteractionEnabled = false
    }
}
