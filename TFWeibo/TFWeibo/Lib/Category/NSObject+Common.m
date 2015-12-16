//
//  NSObject+Common.m
//  TFWeibo
//
//  Created by Tengfei on 15/12/16.
//  Copyright © 2015年 tengfei. All rights reserved.
//

#import "NSObject+Common.h"
#import "JDStatusBarNotification.h"


#define kTestKey @"BaseURLIsTest"
//测试地址
#define kBaseUrlStr_Test @"https://coding.net/"


@implementation NSObject (Common)



+ (BOOL)showError:(NSError *)error{
    if ([JDStatusBarNotification isVisible]) {//如果statusBar上面正在显示信息，则不再用hud显示error
        NSLog(@"如果statusBar上面正在显示信息，则不再用hud显示error");
        return NO;
    }
    NSString *tipStr = [NSObject tipFromError:error];
    [NSObject showHudTipStr:tipStr];
    return YES;
}
#pragma mark BaseURL
+ (NSString *)baseURLStr{
    NSString *baseURLStr;
    if ([self baseURLStrIsTest]) {
        //staging
        baseURLStr = kBaseUrlStr_Test;
    }else{
        //生产
        baseURLStr = @"https://coding.net/";
    }
    //    //staging
    //    baseURLStr = kBaseUrlStr_Test;
    //    //村民
    //    baseURLStr = @"http://192.168.0.188:8080/";
    //    //彭博
    //    baseURLStr = @"http://192.168.0.156:9990/";
    //    //小胖
    //    baseURLStr = @"http://192.168.0.222:8080/";
    
    return baseURLStr;
}
+ (BOOL)baseURLStrIsTest{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [[defaults valueForKey:kTestKey] boolValue];
}
-(id)handleResponse:(id)responseJSON autoShowError:(BOOL)autoShowError{
    NSError *error = nil;
    //code为非0值时，表示有错
    NSNumber *resultCode = [responseJSON valueForKeyPath:@"code"];
    
//    if (resultCode.intValue != 0) {
//        error = [NSError errorWithDomain:[NSObject baseURLStr] code:resultCode.intValue userInfo:responseJSON];
//        
//        if (resultCode.intValue == 1000 || resultCode.intValue == 3207) {//用户未登录
//            if ([Login isLogin]) {//已登录的状态要抹掉
//                [Login doLogout];
//                [((AppDelegate *)[UIApplication sharedApplication].delegate) setupLoginViewController];
//                kTipAlert(@"%@", [NSObject tipFromError:error]);
//            }
//        }else{
//            if (autoShowError) {
//                [NSObject showError:error];
//            }
//        }
//    }
    return error;
}

@end
