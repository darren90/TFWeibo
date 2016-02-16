//
//  HomeController.m
//  TFWeibo
//
//  Created by Tengfei on 15/12/16.
//  Copyright © 2015年 tengfei. All rights reserved.
//

#import "HomeController.h"
#import "Status.h"
#import "WBStatusCell.h"
#import "WBStatusFrame.h"

@interface HomeController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,weak)UITableView *tableView ;
@property (nonatomic,strong)ODRefreshControl *myRefreshControl;

//@property (nonatomic,strong)NSMutableArray *dataArray;

@property (nonatomic,strong)NSMutableArray * statusFrameArray;

@end

@implementation HomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的微博";
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self addTableView];
    [self setupNavBar];
    
    self.myRefreshControl = [[ODRefreshControl alloc] initInScrollView:self.tableView];
    [self.myRefreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    [self refresh];
}

-(void)addTableView
{
    UITableView *tableView = [[UITableView alloc]init];
    [self.view addSubview:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
    self.tableView = tableView;
    tableView.allowsSelection = NO;
    tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64);//self.view.bounds;
}

- (void)refresh
{
    double delayInSeconds = 3.0;
    Account *account = [AccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"count"] = @20;
    __weak typeof(self) weakSelf = self;
    [[Weibo_APIManager sharedManager] request_Friends_timeline_WithParams:params andBlock:^(id data, NSError *error) {
        if (data) {
            NSLog(@":ddd--:%@",data);
            NSArray *newStatuses = [Status mj_objectArrayWithKeyValuesArray:data[@"statuses"]];
            
            NSMutableArray *newFrames = [NSMutableArray array];
            for (Status *status in newStatuses) {
                WBStatusFrame *sf = [[WBStatusFrame alloc]init];
                sf.status = status;
                [newFrames addObject:sf];
            }
            [weakSelf.statusFrameArray addObjectsFromArray:newFrames];
            
//            [weakSelf.dataArray addObjectsFromArray:newStatuses];
            [weakSelf.tableView reloadData];
            NSLog(@"--status-:%@",newStatuses);
        }
    }];
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self.myRefreshControl endRefreshing];
    });
}
- (void)setupNavBar{
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigationbar_friendsearch"] style:UIBarButtonItemStylePlain target:self action:@selector(friendsearch)] animated:NO];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigationbar_pop"] style:UIBarButtonItemStylePlain target:self action:@selector(righBarClick)] animated:NO];
}


-(void)friendsearch
{
    TFLog(@"fiend-search");
}

-(void)righBarClick
{
    TFLog(@"pop---");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.statusFrameArray.count;
//    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //1,创建cell
//    StatusCell *cell = [StatusCell cellWithTableView:tableView];
//    //2,设置cell的数据
//    StatusFrame *model = self.statusFrameArray[indexPath.row];
//    cell.statusFModel = model;
//    return cell;
    
    WBStatusCell *cell = [WBStatusCell cellWithTableView:tableView];
    //2,设置cell的数据
    WBStatusFrame *model = self.self.statusFrameArray[indexPath.row];
    cell.statusFrame = model;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WBStatusFrame *model = self.statusFrameArray[indexPath.row];
    return model.cellH;
}


-(NSMutableArray *)statusFrameArray
{
    if (!_statusFrameArray) {
        _statusFrameArray = [NSMutableArray array];
    }
    return _statusFrameArray;
}


//-(NSMutableArray *)dataArray
//{
//    if (!_dataArray) {
//        _dataArray = [NSMutableArray array];
//    }
//    return _dataArray;
//}

@end
