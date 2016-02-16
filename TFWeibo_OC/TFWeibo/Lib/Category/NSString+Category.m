//
//  NSString+Category.m
//  WeiboWeico
//
//  Created by Tengfei on 15/9/26.
//  Copyright © 2015年 tengfei. All rights reserved.
//

#import "NSString+Category.h"
#import "sys/utsname.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Category)

- (NSString *)md5Str
{
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

@end
