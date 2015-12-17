//
//  Account.h
//  TFWeibo
//
//  Created by Tengfei on 15/12/17.
//  Copyright © 2015年 tengfei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Account : NSObject
/**
 "access_token": "ACCESS_TOKEN",
 "expires_in": 1234,
 "remind_in":"798114",
 "uid":"12341234"
 */

/** token */
@property (nonatomic,copy)NSString * access_token;
/** 过期时间 单位是秒*/
@property (nonatomic,copy)NSString * expires_in;

/** uid */
@property (nonatomic,copy)NSString * uid;

/** ----增加的字段--- */
/** 账号的创建时间 */
@property (nonatomic,strong)NSDate *createTime;

@property (nonatomic,copy)NSString * name;


+(instancetype)accountWithDict:(NSDictionary *)dict;

@end
