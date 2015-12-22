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
#import "WBStatusFrame.h"

#define KWBStatusCellBorderW 10

@interface WBStatusCell ()

/**
 *  1：原创微博
 */

@property (weak, nonatomic) UIView *topView;
@property (weak, nonatomic) UITapImageView *iconView;

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
        //2: 转发微博
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
    //1：整体
    UIView *topView = [[UIView alloc]init];
    self.topView  = topView;
    [self.contentView addSubview:topView];
    
    //2:头像
    UITapImageView *iconView = [[UITapImageView alloc]init];
    self.iconView = iconView;
    [topView addSubview:iconView];
    
    //3:会员图标
    UIImageView *vipView = [[UIImageView alloc]init];
    self.vipView = vipView;
    vipView.contentMode = UIViewContentModeCenter;
    [topView addSubview:vipView];
    
    //3.1:昵称
    UILabel *nameLabel = [[UILabel alloc]init];
    self.nameLabel = nameLabel;
    [topView addSubview:nameLabel];
    nameLabel.font = [UIFont systemFontOfSize:15];
    
    //5:时间
    UILabel *timeLabel = [[UILabel alloc]init];
    self.timeLabel = timeLabel;
    [topView addSubview:timeLabel];
    timeLabel.textColor = [UIColor orangeColor];
    timeLabel.font = [UIFont systemFontOfSize:12];
    
    //6:来源
    UILabel *clientLabel = [[UILabel alloc]init];
    self.clientLabel = clientLabel;
    [topView addSubview:clientLabel];
    clientLabel.font = [UIFont systemFontOfSize:12];
    
    //7:正文
    UITTTAttributedLabel *contentLabel = [[UITTTAttributedLabel alloc]init];
    self.contentLabel = contentLabel;
    [topView addSubview:contentLabel];
    
    //8:配图
    CGRect rect = CGRectZero;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    UICollectionView * photosView = [[UICollectionView alloc]initWithFrame:rect collectionViewLayout:layout];
    self.photosView = photosView;
    [topView addSubview:photosView];
}
//2: 转发微博
-(void)initRetWeet
{
    
}
//3: 底部工具条
-(void)initToolBar
{
    
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
//    CGFloat width = self.frame.size.width;
//    CGFloat heigh = self.frame.size.height;
    
    //1: 原创微博
       
    //2: 转发微博
    
    //3: 底部工具条
}


//设置模型
-(void)setStatusFrame:(WBStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    Status *status = statusFrame.status;
/** 1-设置frame */
    
    //1: 原创微博
    self.iconView.frame = statusFrame.iconViewF;
    self.vipView.frame = statusFrame.vipViewF;
    self.nameLabel.frame = statusFrame.vipViewF;
    
    //2: 转发微博
    
    //3: 底部工具条

    
/** 2-设置content */
    //1: 原创微博
    self.nameLabel.text = status.text;
    
    //2: 转发微博
    
    //3: 底部工具条
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end













