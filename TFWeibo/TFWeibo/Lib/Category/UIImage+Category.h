//
//  UIImage+Category.h
//  WeiboWeico
//
//  Created by Tengfei on 15/9/26.
//  Copyright © 2015年 tengfei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Category)
/**
 *  返回一张自由拉伸色图片
 *
 *  @param name
 *
 *  @return  
 */
+(UIImage *)resizeImage:(NSString *)name;
@end
