//
//  Status.m
//  TFWeibo
//
//  Created by Tengfei on 15/12/19.
//  Copyright © 2015年 tengfei. All rights reserved.
//

#import "Status.h"

@implementation Status

+(NSDictionary *)objectClassInArray{
    return @{ @"pic_urls" : @"PictureModel" };
}

- (void)setSource:(NSString *)source
{
    if (source == nil || source.length == 0)  return;
    // 正则表达式 NSRegularExpression // 截串 NSString
    NSRange range;
    range.location = [source rangeOfString:@">"].location + 1;
    range.length = [source rangeOfString:@"</"].location - range.location;
     _source = [NSString stringWithFormat:@"来自%@", [source substringWithRange:range]];
}


    // E:星期几
    // M:月份
    // d:几号(这个月的第几天)
    // H:24小时制的小时
    // m:分钟
    // s:秒
    // y:年
- (NSString *)created_at
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 如果是真机调试，转换这种欧美时间，需要设置locale
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"local"];

    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    NSDate *createDate = [fmt dateFromString:_created_at];
    fmt.dateFormat = @"yyy-MMM-dd";
    NSString *dateStr = [fmt stringFromDate:createDate];
    return dateStr;
}

@end



