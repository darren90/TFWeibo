//
//  WBToolBar.m
//  TFWeibo
//
//  Created by Tengfei on 15/12/20.
//  Copyright © 2015年 tengfei. All rights reserved.
//

#import "WBToolBar.h"
#import "Status.h"

@interface WBToolBar()

@end


@implementation WBToolBar

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor grayColor];
    }
    return self;
}


-(void)setStatus:(Status *)status
{
    _status = status;
}

@end
