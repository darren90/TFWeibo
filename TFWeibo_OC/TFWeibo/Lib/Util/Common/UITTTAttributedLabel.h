//
//  UITTTAttributedLabel.h
//  TFWeibo
//
//  Created by Tengfei on 15/12/19.
//  Copyright © 2015年 tengfei. All rights reserved.
//

#import "TTTAttributedLabel.h"

typedef void(^UITTTLabelTapBlock)(id aObj);

@interface UITTTAttributedLabel : TTTAttributedLabel
-(void)addLongPressForCopy;
-(void)addLongPressForCopyWithBGColor:(UIColor *)color;
-(void)addTapBlock:(UITTTLabelTapBlock)block;
-(void)addDeleteBlock:(UITTTLabelTapBlock)block;

@end
