//
//  WBStatusFrame.h
//  TFWeibo
//
//  Created by Tengfei on 15/12/21.
//  Copyright © 2015年 tengfei. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Status;

@interface WBStatusFrame : NSObject

@property (nonatomic,strong)Status *status;

//1: 原创微博
@property (nonatomic,assign)CGRect topViewF;

@property (nonatomic,assign)CGRect iconViewF;

@property (nonatomic,assign)CGRect vipViewF;

@property (nonatomic,assign)CGRect nameLabelF;

@property (nonatomic,assign)CGRect timeLabelF;

@property (nonatomic,assign)CGRect clientLabelF;

@property (nonatomic,assign)CGRect contentLabelF;

@property (nonatomic,assign)CGRect photosViewF;

//2: 转发微博
@property (nonatomic,assign)CGRect retBottomViewF;

@property (nonatomic,assign)CGRect retContentLabelF;

@property (nonatomic,assign)CGRect retPhotosViewF;


//3: 底部工具条
@property (nonatomic,assign)CGRect toolBarF;

//5:Last
@property (nonatomic,assign)CGFloat cellH;

@end
