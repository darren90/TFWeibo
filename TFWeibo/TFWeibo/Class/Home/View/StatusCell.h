//
//  StatusCell.h
//  TFWeibo
//
//  Created by Tengfei on 15/12/19.
//  Copyright © 2015年 tengfei. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Status;

@interface StatusCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView;


//@property (nonatomic,strong)StatusFrame * statusFrame;
@property (nonatomic,strong)Status *model;

@end
