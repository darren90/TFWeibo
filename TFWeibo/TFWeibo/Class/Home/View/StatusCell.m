//
//  StatusCell.m
//  TFWeibo
//
//  Created by Tengfei on 15/12/19.
//  Copyright © 2015年 tengfei. All rights reserved.
//

#import "StatusCell.h"
#import "Status.h"
#import "UITapImageView.h"
#import "UITTTAttributedLabel.h"
#import "UICustomCollectionView.h"

@interface StatusCell()
@property (assign, nonatomic) BOOL needTopView;

@property (strong, nonatomic) UIView *topView;
@property (strong, nonatomic) UITapImageView *ownerImgView;
@property (strong, nonatomic) UIButton *ownerNameBtn;
@property (strong, nonatomic) UITTTAttributedLabel *contentLabel;
@property (strong, nonatomic) UILabel *timeLabel, *fromLabel;
@property (strong, nonatomic) UIButton *likeBtn, *commentBtn, *deleteBtn, *shareBtn;
@property (strong, nonatomic) UIButton *locaitonBtn;
 @property (strong, nonatomic) UICollectionView *likeUsersView;
@property (strong, nonatomic) UITableView *commentListView;
@property (strong, nonatomic) UIImageView *timeClockIconView, *commentOrLikeBeginImgView, *commentOrLikeSplitlineView, *fromPhoneIconView;

@end

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
