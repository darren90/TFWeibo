//
//  WBStatusFrame.m
//  TFWeibo
//
//  Created by Tengfei on 15/12/21.
//  Copyright © 2015年 tengfei. All rights reserved.
//

#import "WBStatusFrame.h"
#import "Status.h"
#import "User.h"

#define KWBStatusCellMargin 10

@implementation WBStatusFrame


-(void)setStatus:(Status *)status
{
    _status = status;
    
    User *user = status.user;
    
    
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width;


    //1: 原创微博
    CGFloat iconHW = 35;
    self.iconViewF = CGRectMake(KWBStatusCellMargin, KWBStatusCellMargin, iconHW, iconHW);
    
    CGFloat nameX = CGRectGetMaxX(self.iconViewF) + KWBStatusCellMargin;
    CGFloat nameY = CGRectGetMinY(self.iconViewF);
    CGSize nameSize = [self sizeWithText:user.name font:[UIFont systemFontOfSize:15]];
    self.nameLabelF = CGRectMake(nameX, nameY, nameSize.width, nameSize.height);
    
   
    if (user.isVip) {
        self.vipViewF = CGRectMake(CGRectGetMaxX(self.nameLabelF), nameY, 15, nameSize.height);
    }
    
    CGSize timeSize = [self sizeWithText:status.created_at font:[UIFont systemFontOfSize:12]];
    self.timeLabelF = CGRectMake(nameX, CGRectGetMaxY(self.nameLabelF)+KWBStatusCellMargin, timeSize.width, timeSize.height);
    
    
    
     //2: 转发微博
    //3: 底部工具条

    
}


- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxW:(CGFloat)maxW
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font
{
    return [self sizeWithText:text font:font maxW:MAXFLOAT];
}



@end
