//
//  WBStatusCell.h
//  TFWeibo
//
//  Created by Tengfei on 15/12/21.
//  Copyright © 2015年 tengfei. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WBStatusFrame;

@interface WBStatusCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic,strong)WBStatusFrame *statusFrame;

@end
