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

@end
