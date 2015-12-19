//
//  StatusCell.m
//  TFWeibo
//
//  Created by Tengfei on 15/12/19.
//  Copyright © 2015年 tengfei. All rights reserved.
//

#import "StatusCell.h"
#import "Status.h"

@implementation StatusCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    StatusCell *cell = [tableView dequeueReusableCellWithIdentifier:@"status"];
    if (!cell) {
        cell = [[StatusCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"status"];
    }
    
    return cell;
}


-(void)setModel:(Status *)model
{
    _model = model;
    
    self.textLabel.text = model.text;
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
