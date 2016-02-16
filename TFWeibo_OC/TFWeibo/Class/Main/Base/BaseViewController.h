//
//  BaseViewController.h
//  TFWeibo
//
//  Created by Tengfei on 15/12/16.
//  Copyright © 2015年 tengfei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
- (void)tabBarItemClicked;
- (void)loginOutToLoginVC;

+ (void)handleNotificationInfo:(NSDictionary *)userInfo applicationState:(UIApplicationState)applicationState;
+ (UIViewController *)analyseVCFromLinkStr:(NSString *)linkStr;
+ (void)presentLinkStr:(NSString *)linkStr;
+ (UIViewController *)presentingVC;
+ (void)presentVC:(UIViewController *)viewController;
@end
