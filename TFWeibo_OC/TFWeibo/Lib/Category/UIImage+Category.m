//
//  UIImage+Category.m
//  WeiboWeico
//
//  Created by Tengfei on 15/9/26.
//  Copyright © 2015年 tengfei. All rights reserved.
//

#import "UIImage+Category.h"

@implementation UIImage (Category)


+(UIImage *)resizeImage:(NSString *)name
{
    UIImage *image = [UIImage imageNamed:name];
    image = [image stretchableImageWithLeftCapWidth:image.size.width / 2 topCapHeight:image.size.height / 2];
    return image;
}

@end
