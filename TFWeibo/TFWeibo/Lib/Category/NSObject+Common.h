//
//  NSObject+Common.h
//  TFWeibo
//
//  Created by Tengfei on 15/12/16.
//  Copyright © 2015年 tengfei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Common)


+ (BOOL)showError:(NSError *)error;
+ (NSString *)baseURLStr;
-(id)handleResponse:(id)responseJSON autoShowError:(BOOL)autoShowError;
@end
