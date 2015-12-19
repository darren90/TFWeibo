//
//  UIIconView.m
//  TFWeibo
//
//  Created by Tengfei on 15/12/19.
//  Copyright © 2015年 tengfei. All rights reserved.
//

#import "UIIconView.h"
#import "User.h"

@implementation UIIconView

-(void)setUser:(User *)user
{
    _user = user;
    //下载图片
    //设置图片
    [self sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
}

@end
