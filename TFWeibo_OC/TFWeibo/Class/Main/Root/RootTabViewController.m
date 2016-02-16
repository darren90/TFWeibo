//
//  RootTabViewController.m
//  TFWeibo
//
//  Created by Tengfei on 15/12/14.
//  Copyright © 2015年 tengfei. All rights reserved.
//

#import "RootTabViewController.h"
#import "BaseNavigationController.h"
#import "RDVTabBarItem.h"

#import "HomeController.h"
#import "MessageController.h"
#import "ComposeController.h"
#import "DiscoverController.h"
#import "MeController.h"

@interface RootTabViewController ()<RDVTabBarControllerDelegate>

@end

@implementation RootTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self  initViewControllers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initViewControllers
{
    UIViewController *home = [[HomeController alloc]init];
    UINavigationController *navHome = [[BaseNavigationController alloc]initWithRootViewController:home];
    
    UIViewController *message = [[MessageController alloc]init];
    UINavigationController *navMessage = [[BaseNavigationController alloc]initWithRootViewController:message];
    
    UIViewController *compose = [[ComposeController alloc]init];
    UINavigationController *navCompose = [[BaseNavigationController alloc]initWithRootViewController:compose];
    
    UIViewController *discover = [[DiscoverController alloc]init];
    discover.title = @"发现";
    UINavigationController *navDiscover = [[BaseNavigationController alloc]initWithRootViewController:discover];
    
    UIViewController *me = [[MeController alloc]init];
    UINavigationController *navMe = [[BaseNavigationController alloc]initWithRootViewController:me];
    
    [self setViewControllers:@[navHome, navMessage, navCompose,navDiscover, navMe]];
    
    [self initTabBarForController];
    self.delegate = self;
}

-(void)initTabBarForController
{
    UIImage *backgroundImage = [UIImage imageNamed:@"tabbar_background"];
    NSArray *tabBarItemImages = @[@"tabbar_home", @"tabbar_message_center", @"tweet", @"tabbar_discover", @"tabbar_profile"];
    NSArray *tabBarItemTitles = @[@"首页", @"消息",@"发微博", @"发现", @"我"];
    
    NSInteger index = 0;
    for (RDVTabBarItem *item in self.tabBar.items) {
        item.titlePositionAdjustment = UIOffsetMake(0, 2);
        [item setBackgroundSelectedImage:backgroundImage withUnselectedImage:backgroundImage];
        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",
                                                      [tabBarItemImages objectAtIndex:index]]];
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@",
                                                        [tabBarItemImages objectAtIndex:index]]];
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        [item setTitle:[tabBarItemTitles objectAtIndex:index]];
        index++;
    }
}


#pragma mark RDVTabBarControllerDelegate

- (BOOL)tabBarController:(RDVTabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    if (tabBarController.selectedViewController != viewController) {
        return YES;
    }
    if (![viewController isKindOfClass:[UINavigationController class]]) {
        return YES;
    }
    UINavigationController *nav = (UINavigationController *)viewController;
    if (nav.topViewController != nav.viewControllers[0]) {
        return YES;
    }
//    if ([nav isKindOfClass:[RKSwipeBetweenViewControllers class]]) {
//        RKSwipeBetweenViewControllers *swipeVC = (RKSwipeBetweenViewControllers *)nav;
//        if ([[swipeVC curViewController] isKindOfClass:[BaseViewController class]]) {
//            BaseViewController *rootVC = (BaseViewController *)[swipeVC curViewController];
//            [rootVC tabBarItemClicked];
//        }
//    }else{
//        if ([nav.topViewController isKindOfClass:[BaseViewController class]]) {
//            BaseViewController *rootVC = (BaseViewController *)nav.topViewController;
//            [rootVC tabBarItemClicked];
//        }
//    }
    return YES;
}

@end
