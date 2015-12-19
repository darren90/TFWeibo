//
//  WBStatusImgsView.h
//  TFWeibo
//
//  Created by Tengfei on 15/12/19.
//  Copyright © 2015年 tengfei. All rights reserved.
//

//存放1-9张图片 存放的是WBStatusPhotoView
#import <UIKit/UIKit.h>

@interface WBStatusImgsView : UIView
/**
 *  根据图片个数，计算相册尺寸
 *
 *  @param NSArray NSArray description
 *
 *  @return CGSize ： 这个相册的宽高
 */
+(CGSize )photosSizeWithCount:(int)count;

@property (nonatomic,strong)NSArray * photos;

@end
