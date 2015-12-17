//
//  Account.m
//  TFWeibo
//
//  Created by Tengfei on 15/12/17.
//  Copyright © 2015年 tengfei. All rights reserved.
//

#import "Account.h"

@implementation Account

+(instancetype)accountWithDict:(NSDictionary *)dict
{
    Account *account = [[self alloc]init];
    account.access_token = dict[@"access_token"];
    account.uid = dict[@"uid"];
    account.expires_in = dict[@"expires_in"];
    //获得账号存储时间，
    NSDate *createTime = [NSDate date];
    account.createTime = createTime;
    return account;
}

/**
 *  对象归档的时候调用
 */
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.access_token forKey:@"access_token"];
    [aCoder encodeObject:self.uid forKey:@"uid"];
    [aCoder encodeObject:self.expires_in forKey:@"expires_in"];
    [aCoder encodeObject:self.createTime forKey:@"createTime"];
    [aCoder encodeObject:self.name forKey:@"name"];
}

/**
 *  解档的时候调用
 *
 *  @param aDecoder
 *
 *  @return
 */
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.access_token = [aDecoder decodeObjectForKey:@"access_token"];
        self.uid = [aDecoder decodeObjectForKey:@"uid"];
        self.expires_in = [aDecoder decodeObjectForKey:@"expires_in"];
        self.createTime = [aDecoder decodeObjectForKey:@"createTime"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
    }
    return self;
}

@end
