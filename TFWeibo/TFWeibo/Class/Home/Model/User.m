//
//  User.m
//  TFWeibo
//
//  Created by Tengfei on 15/12/17.
//  Copyright © 2015年 tengfei. All rights reserved.
//

#import "User.h"

@implementation User
- (void)setMbtype:(int)mbtype
{
    _mbtype = mbtype;
    
    self.vip = mbtype > 2;
}

@end
