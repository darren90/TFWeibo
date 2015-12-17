//
//  Weibo_APIManager.m
//  TFWeibo
//
//  Created by Tengfei on 15/12/16.
//  Copyright © 2015年 tengfei. All rights reserved.
//

#import "Weibo_APIManager.h"

@implementation Weibo_APIManager

//- (void)request_Login_WithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{

- (void)request_OAuth_WithParams:(id)params andBlock:(void (^)(id data, NSError *error))block
{
    [[WeiboAPIClient sharedJsonClient] requestJsonDataWithPath:@"/oauth2/access_token" withParams:params withMethodType:Get autoShowError:NO andBlock:^(id data, NSError *error) {
        if (data) {
//            [MobClick event:kUmeng_Event_Request_Notification label:@"Tab首页的红点通知"];
            
            id resultData = [data valueForKeyPath:@"data"];
            block(resultData, nil);
        }else{
            block(nil, error);
        }
    }];
}


@end
