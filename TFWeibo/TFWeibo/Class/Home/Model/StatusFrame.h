//
//  StatusFrame.h
//  TFWeibo
//
//  Created by Tengfei on 15/12/19.
//  Copyright © 2015年 tengfei. All rights reserved.
//


/**  cell的间距 */
#define KStatusCellMarginW 15

/**  昵称字体 */
#define KStatusNameFont [UIFont systemFontOfSize:15]

/**  time字体 */
#define KStatusTimeFont [UIFont systemFontOfSize:12]
/**  source字体 */
#define KStatusSourceFont [UIFont systemFontOfSize:12]
/**  content字体 */
#define KStatusContentFont [UIFont systemFontOfSize:14]

/**  被转发的微博content字体 */
#define KRetweetStatusContentFont [UIFont systemFontOfSize:14]


#import <Foundation/Foundation.h>
@class Status;

@interface StatusFrame : NSObject

@property (nonatomic,strong)Status * status;


/** 原创微博整体 */
@property (nonatomic,assign)CGRect originalViewF;
/** 原创微博-头像 */
@property (nonatomic,assign)CGRect iconViewF;
/** 原创微博-会员图标 */
@property (nonatomic,assign)CGRect vipViewF;
/** 原创微博-配图 */
@property (nonatomic,assign)CGRect photoViewF;
/** 昵称 */
@property (nonatomic,assign)CGRect nameLabelF;
/** 时间 */
@property (nonatomic,assign)CGRect timeLabelF;
/** 来源 */
@property (nonatomic,assign)CGRect sourceLabelF;
/** 正文 */
@property (nonatomic,assign)CGRect contentLabelF;

/**  *  -----转发微博---- */
@property (nonatomic,assign)CGRect retweetViewF;
/** 转发正文 */
@property (nonatomic,assign)CGRect retweetContentLabelF;
/** 转发配图 */
@property (nonatomic,assign)CGRect retweetPhotoViewF;

/** 工具条toolBar*/
@property (nonatomic,assign)CGRect toolBarF;


@property (nonatomic,assign)CGFloat cellH;
@end
