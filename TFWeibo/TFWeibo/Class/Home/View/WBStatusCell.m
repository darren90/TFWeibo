//
//  WBStatusCell.m
//  TFWeibo
//
//  Created by Tengfei on 15/12/21.
//  Copyright © 2015年 tengfei. All rights reserved.
//

#import "WBStatusCell.h"
#import "Status.h"
#import "UITapImageView.h"
#import "UITTTAttributedLabel.h"
#import "UICustomCollectionView.h"
#import "UIIconView.h"
#import "StatusFrame.h"
#import "WBStatusImgsView.h"
#import "WBToolBar.h"

@interface WBStatusCell ()

/**
 *  1：原创微博
 */

@property (weak, nonatomic) UIView *topView;
@property (weak, nonatomic) UITapImageView *iconView;
//@property (strong, nonatomic) UIButton *ownerNameBtn;

@property (nonatomic,weak)UIImageView * vipView;

@property (nonatomic,weak)UILabel * nameLabel;

@property (nonatomic,weak)UILabel * timeLabel;

@property (nonatomic,weak)UILabel * clientLabel;

@property (weak, nonatomic) UITTTAttributedLabel *contentLabel;

@property (nonatomic,weak)UICollectionView * photosView;


/**
 *  2：原创微博
 */

@property (nonatomic,weak)UIView * retBottomView;

@property (weak, nonatomic) UITTTAttributedLabel *retContentLabel;

@property (nonatomic,weak)UICollectionView * retPhotosView;


/**
 *  3：底部
 */

@property (nonatomic,weak)WBToolBar * toolBar;


//@property (weak, nonatomic) UIButton *likeBtn, *commentBtn, *deleteBtn, *shareBtn;
//@property (weak, nonatomic) UIButton *locaitonBtn;
//@property (weak, nonatomic) UICollectionView *likeUsersView;
//@property (weak, nonatomic) UITableView *commentListView;
//@property (weak, nonatomic) UIImageView *timeClockIconView, *commentOrLikeBeginImgView, *commentOrLikeSplitlineView, *fromPhoneIconView;
@end

@implementation WBStatusCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    WBStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WBStatusCell"];
    if (!cell) {
        cell = [[WBStatusCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"status"];
    }
    
    return cell;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //1: 原创微博
        [self initOriginal];
        //2: 原创微博
        [self initRetWeet];
        //3: 底部工具条
        [self initToolBar];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}



//1: 原创微博
-(void)initOriginal
{
    
}
//2: 原创微博
-(void)initRetWeet
{
    
}
//3: 底部工具条
-(void)initToolBar
{
    
}





- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
