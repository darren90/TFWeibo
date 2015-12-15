//
//  RootTabViewController.m
//  TFWeibo
//
//  Created by Tengfei on 15/12/14.
//  Copyright © 2015年 tengfei. All rights reserved.
//

#import "RootTabViewController.h"
#import "BaseNavigationController.h"

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
    
    UITableViewController *discover = [[UITableViewController alloc]init];
    UINavigationController *navDiscover = [[BaseNavigationController alloc]initWithRootViewController:discover];
    
    UITableViewController *me = [[UITableViewController alloc]init];
    UINavigationController *navMe = [[BaseNavigationController alloc]initWithRootViewController:me];
    
    [self setViewControllers:@[navHome, navMessage, navDiscover, navMe]];
    
    [self customizeTabBarForController];
    self.delegate = self;
}

-(void)customizeTabBarForController
{
    
}

@end
