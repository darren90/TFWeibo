//
//  UIWindow+Category.m
//  WeiboWeico
//
//  Created by Tengfei on 15/10/3.
//  Copyright © 2015年 tengfei. All rights reserved.
//

#import "UIWindow+Category.h"
#import "BaseTabBarController.h"
//#import "NewFeatureController.h"

@implementation UIWindow (Category)


+(void)switchRootViewVC
{
    
#if 0
    BaseTabBarController *tabBar = [[BaseTabBarController alloc]init];
    NewFeatureController *newFeature = [[NewFeatureController alloc]init];
    //1：读取当前软件的版本号
    NSString *key = @"CFBundleVersion";
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    // 当前软件的版本号（从Info.plist中获得）
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    
    UIWindow *ww = [UIApplication sharedApplication].keyWindow;
    if ([currentVersion isEqualToString:lastVersion]) { // 版本号相同：这次打开和上次打开的是同一个版本
        ww.rootViewController = tabBar;
    } else {
        ww.rootViewController = newFeature;
        
        // 将当前的版本号存进沙盒
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
#endif
}

@end
