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
#import "UIIconView.h"
#import "StatusFrame.h"
#import "WBStatusImgsView.h"
#import "WBToolBar.h"

@interface StatusCell()
@property (assign, nonatomic) BOOL needTopView;

//@property (strong, nonatomic) UIView *topView;
//@property (strong, nonatomic) UITapImageView *ownerImgView;
//@property (strong, nonatomic) UIButton *ownerNameBtn;
//@property (strong, nonatomic) UITTTAttributedLabel *contentLabel;
//@property (strong, nonatomic) UILabel *timeLabel, *fromLabel;
//@property (strong, nonatomic) UIButton *likeBtn, *commentBtn, *deleteBtn, *shareBtn;
//@property (strong, nonatomic) UIButton *locaitonBtn;
// @property (strong, nonatomic) UICollectionView *likeUsersView;
//@property (strong, nonatomic) UITableView *commentListView;
//@property (strong, nonatomic) UIImageView *timeClockIconView, *commentOrLikeBeginImgView, *commentOrLikeSplitlineView, *fromPhoneIconView;


/** --------1-原创微博整体--------- */
/** 原创微博-头像 */
@property (nonatomic,weak)UIIconView * iconView;
/** 原创微博-会员图标 */
@property (nonatomic,weak)UIImageView * vipView;
/** 原创微博-配图 */
@property (nonatomic,weak)WBStatusImgsView * photosView;
/** 昵称 */
@property (nonatomic,weak)UILabel * nameLabel;
/** 时间 */
@property (nonatomic,weak)UILabel * timeLabel;
/** 来源 */
@property (nonatomic,weak)UILabel * sourceLabel;
/** 正文 */
@property (nonatomic,weak)UILabel * contentLabel;
/** 原创微博整体 */
@property (nonatomic,weak)UIView * originalView;
/** --------1-原创微博整体--------- */


/** --------2-转发微博整体--------- */
/** 转发微博整体 */
@property (nonatomic,weak)UIView * retweetView;
/** 转发正文 */
@property (nonatomic,weak)UILabel * retweetContentLabel;
/** 转发配图 */
//@property (nonatomic,weak)WBStatusPhotosView * retweetPhotosView;
/** --------2-转发微博整体--------- */



/** --------3-工具条--------- */
@property (nonatomic,weak)WBToolBar * toolBar;

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
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //1: 初始化原创微博
        [self initOriginal];
    }
    return self;
}

-(void)initOriginal
{
    //1:底部的整体view
    UIView *originalView = [[UIView alloc]init];
    [self.contentView addSubview:originalView];
    self.originalView = originalView;
    originalView.backgroundColor = [UIColor whiteColor];
    
    //2：头像
    UIIconView *iconView = [[UIIconView alloc]init];
    self.iconView = iconView;
    [self.originalView addSubview:iconView];
    
    //3:会员图标
    UIImageView *vipView = [[UIImageView alloc]init];
    self.vipView = vipView;
    vipView.contentMode = UIViewContentModeCenter;
    
    //4:原创微博配图
    WBStatusImgsView * photoView = [[WBStatusImgsView alloc]init];
    [originalView addSubview:photoView];
    self.photosView = photoView;
    
    //5:昵称
    UILabel *nameLabel = [[UILabel alloc]init];
    self.nameLabel = nameLabel;
    [self.originalView addSubview:nameLabel];
    nameLabel.font = [UIFont systemFontOfSize:15];
    
    //6:时间
    UILabel *timeLabel = [[UILabel alloc]init];
    self.timeLabel = timeLabel;
    [self.originalView addSubview:timeLabel];
    timeLabel.textColor = [UIColor orangeColor];
    timeLabel.font = [UIFont systemFontOfSize:12];
    
    //7:来源
    UILabel *sourceLabel = [[UILabel alloc]init];
    self.sourceLabel = sourceLabel;
    [self.originalView addSubview:sourceLabel];
    sourceLabel.font = [UIFont systemFontOfSize:12];
    
    //8:正文
    UILabel * contentLabel = [[UILabel alloc]init];
    [originalView addSubview:contentLabel];
    self.contentLabel = contentLabel;
    contentLabel.font = [UIFont systemFontOfSize:14];;
    contentLabel.numberOfLines = 0;
}

-(void)setStatusFModel:(StatusFrame *)statusFModel
{
    _statusFModel = statusFModel;
    Status *status = statusFModel.status;
    User *user = status.user;
    
    self.originalView.frame = statusFModel.originalViewF;
    self.iconView.frame = statusFModel.iconViewF;
    self.iconView.user = user;
    
    if (user.isVip) {
        self.vipView.hidden = NO;
        
        self.vipView.frame = statusFModel.vipViewF;
        self.vipView.image = [UIImage imageNamed:[NSString stringWithFormat:@"common_icon_membership_level%d",user.mbrank]];
        self.nameLabel.textColor = [UIColor orangeColor];
    }else{
        self.vipView.hidden = YES;
        
        self.nameLabel.textColor = [UIColor blackColor];
    }
    
    self.photosView.frame = statusFModel.photoViewF;
    if (status.pic_urls.count) {
        
        //        Photo *photo = status.pic_urls[0];
        self.photosView.photos = status.pic_urls;
        self.photosView.hidden = NO;
    }else{
        self.photosView.hidden = YES;
    }
    
    
    self.nameLabel.text = user.name;
    self.nameLabel.frame = statusFModel.nameLabelF;
    
    self.timeLabel.text = status.created_at;
    self.timeLabel.frame = statusFModel.timeLabelF;
    
    self.sourceLabel.text = status.source;
    self.sourceLabel.frame = statusFModel.sourceLabelF;
    
    //    self.contentLabel.text = status.text;
    self.contentLabel.attributedText = status.attributeText;
    self.contentLabel.frame = statusFModel.contentLabelF;
    
    /** 转发微博 */
    
//    Status *retWeetSatus = status.retweeted_status;
//    if (retWeetSatus) {
//        self.retweetView.hidden = NO;
//        self.retweetView.frame = statusFModel.retweetViewF;
// 
//        self.retweetContentLabel.attributedText = status.retweetAttributeText;
//        
//        self.retweetContentLabel.frame = statusFModel.retweetContentLabelF;
//        
//        if (retWeetSatus.pic_urls.count) {
//            self.retweetPhotosView.frame = statusFModel.retweetPhotoViewF;
//            
// 
//            self.self.retweetPhotosView.photos = retWeetSatus.pic_urls;
// 
//            self.retweetPhotosView.hidden = NO;
//        }else{
//            
//        }
//        
//    }else{
//        self.retweetView.hidden = YES;
//    }
    
    
    /** 工具条 */
    self.toolBar.frame = statusFModel.toolBarF;
//    self.toolBar.status = status;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
