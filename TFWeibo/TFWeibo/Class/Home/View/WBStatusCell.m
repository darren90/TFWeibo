//
//  WBStatusCell.m
//  TFWeibo
//
//  Created by Tengfei on 15/12/21.
//  Copyright © 2015年 tengfei. All rights reserved.
//

#import "WBStatusCell.h"

@implementation WBStatusCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    WBStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WBStatusCell"];
    if (!cell) {
        cell = [[WBStatusCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"status"];
    }
    
    return cell;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
