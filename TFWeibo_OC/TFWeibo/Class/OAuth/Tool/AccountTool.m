//
//  AccountTool.m
//  TFWeibo
//
//  Created by Tengfei on 15/12/17.
//  Copyright © 2015年 tengfei. All rights reserved.
//

#import "AccountTool.h"

#define path [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.plist"]

@implementation AccountTool

+(void)saveAccount:(Account *)account
{
    //将返回的数据，存进沙盒
    //自定义对象的储存，用NSKeyedArchiver，不能用write同file
    [NSKeyedArchiver archiveRootObject:account toFile:path];
    //        BOOL result = [responseObject writeToFile:path atomically:YES];
}

+(Account *)account
{
    Account *account = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    
    long long expires_in = [account.expires_in longLongValue];
    //获得当前时间
    NSDate *now = [NSDate date];
    NSDate *expiresTime = [account.createTime dateByAddingTimeInterval:expires_in];
    
    //
    NSComparisonResult result = [expiresTime compare:now];
    if (result != NSOrderedDescending) { // 过期
        return nil;
    }
    return account;
}

@end
