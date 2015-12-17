//
//  AccountTool.h
//  TFWeibo
//
//  Created by Tengfei on 15/12/17.
//  Copyright © 2015年 tengfei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Account.h"

@interface AccountTool : NSObject

+(void)saveAccount:(Account *)account;

+(Account *)account;

@end
 
