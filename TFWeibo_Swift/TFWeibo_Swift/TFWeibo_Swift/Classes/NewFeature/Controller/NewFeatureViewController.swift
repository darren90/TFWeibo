//
//  NewFeatureViewController.swift
//  TFWeibo_Swift
//
//  Created by Tengfei on 16/2/23.
//  Copyright © 2016年 tengfei. All rights reserved.
//

import UIKit

private let Identifier = "Identifier"

class NewFeatureViewController: UICollectionViewController {
    private let pageCount = 4
    
    private var layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    init(){
        super.init(collectionViewLayout: layout)
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        layout.itemSize = UIScreen.mainScreen().bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .Horizontal
        
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.bounces = false
        collectionView?.pagingEnabled = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        collectionView?.registerClass(NewFeatureCell.self, forCellWithReuseIdentifier: Identifier)
    }
    
    
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(Identifier , forIndexPath: indexPath) as! NewFeatureCell
//        cell.backgroundColor = UIColor.brownColor()
        cell.imgeIndex = indexPath.item
        return cell
    }
    
    //完全显示cell后调用
    override func collectionView(collectionView: UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        let indexPath = collectionView.indexPathsForVisibleItems().last!
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! NewFeatureCell
        cell.startBtnAnimation()
    }
}

//当前类需要监听按钮点击，当前类不能是私有的
class NewFeatureCell:UICollectionViewCell
{
    var imgeIndex:Int?{
        didSet{
            iconView.image = UIImage(named: "new_feature_\(imgeIndex! + 1)")
            if imgeIndex == 3 {
                startBtn.hidden = false
                
                startBtn.transform = CGAffineTransformMakeScale(0.0, 0.0)
                startBtn.userInteractionEnabled = false
                
//                UIViewAnimationOptions(rawValue: 0) == OC knilOptions 不要这个枚举了
            }
        }
    }
    
    func startBtnAnimation(){
        UIView.animateWithDuration(2.2, delay: 0, usingSpringWithDamping: 1.2, initialSpringVelocity: 10, options: UIViewAnimationOptions(rawValue: 0), animations: { () -> Void in
            self.startBtn.transform = CGAffineTransformIdentity
            }, completion: { (_) -> Void in
                self.startBtn.userInteractionEnabled = true
        })
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpSubViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpSubViews(){
        contentView.addSubview(iconView)
        contentView.addSubview(startBtn)
        
        iconView.xmg_Fill(contentView)
        startBtn.xmg_AlignInner(type: XMG_AlignType.BottomCenter, referView: contentView, size: nil, offset: CGPoint(x: 0, y: -150))
    }
    
    private lazy var iconView = UIImageView()
    
    private lazy var startBtn:UIButton = {
        let btn = UIButton()
        btn.hidden = true
        btn.setBackgroundImage(UIImage(named: "new_feature_button_highlighted"), forState: .Highlighted)
        btn.setBackgroundImage(UIImage(named: "new_feature_button"), forState: .Normal)
        btn.addTarget(self, action: "startBtnDidClick", forControlEvents: .TouchUpInside)
        return btn
    }()
    
    func startBtnDidClick(){
        print("startBtnDidClick")
    }
    
}

