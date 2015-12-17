//
//  Weibo_APIManager.h
//  TFWeibo
//
//  Created by Tengfei on 15/12/16.
//  Copyright © 2015年 tengfei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeiboAPIClient.h"

@interface Weibo_APIManager : NSObject
+ (instancetype)sharedManager;


//OAuth
- (void)request_OAuth_WithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;


@end
