//
//  User.h
//  TFWeibo
//
//  Created by Tengfei on 15/12/17.
//  Copyright © 2015年 tengfei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic,copy)NSString * idstr;

@property (nonatomic,copy)NSString * name;
/**  用户头像地址（中图），50×50像素 */
@property (nonatomic,copy)NSString * profile_image_url;



/** 会员类型 > 2代表是会员 */
@property (nonatomic, assign) int mbtype;
/** 会员等级 */
@property (nonatomic, assign) int mbrank;
@property (nonatomic, assign, getter = isVip) BOOL vip;
 

@end
