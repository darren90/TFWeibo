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
    UITableViewController *home = [[UITableViewController alloc]init];
    UINavigationController *navHome = [[BaseNavigationController alloc]initWithRootViewController:home];
    
    UITableViewController *message = [[UITableViewController alloc]init];
    UINavigationController *navMessage = [[BaseNavigationController alloc]initWithRootViewController:message];
    
    UITableViewController *compose = [[UITableViewController alloc]init];
    UINavigationController *navCompose = [[BaseNavigationController alloc]initWithRootViewController:compose];
    
    UITableViewController *discover = [[UITableViewController alloc]init];
    discover.title = @"发现";
    UINavigationController *navDiscover = [[BaseNavigationController alloc]initWithRootViewController:discover];
    
    UITableViewController *me = [[UITableViewController alloc]init];
    UINavigationController *navMe = [[BaseNavigationController alloc]initWithRootViewController:me];
    
    [self setViewControllers:@[navHome, navMessage, navCompose,navDiscover, navMe]];
    
    [self initTabBarForController];
    self.delegate = self;
}

-(void)initTabBarForController
{
    UIImage *backgroundImage = [UIImage imageNamed:@"tabbar_background"];
    NSArray *tabBarItemImages = @[@"project", @"task", @"tweet", @"privatemessage", @"me"];
    NSArray *tabBarItemTitles = @[@"首页", @"消息",@"发微博", @"发现", @"我"];
    
    NSInteger index = 0;
    for (RDVTabBarItem *item in [[self tabBar] items]) {
        item.titlePositionAdjustment = UIOffsetMake(0, 3);
        [item setBackgroundSelectedImage:backgroundImage withUnselectedImage:backgroundImage];
        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",
                                                      [tabBarItemImages objectAtIndex:index]]];
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_normal",
                                                        [tabBarItemImages objectAtIndex:index]]];
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        [item setTitle:[tabBarItemTitles objectAtIndex:index]];
        index++;
    }
}

@end
