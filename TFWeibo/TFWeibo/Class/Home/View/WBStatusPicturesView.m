//
//  WBStatusPicturesView.m
//  TFWeibo
//
//  Created by Tengfei on 15/12/23.
//  Copyright © 2015年 tengfei. All rights reserved.
//

#import "WBStatusPicturesView.h"

#define KStatusPhotoWH 70
#define KStatusPhotoMargin 10
#define KStatusPhotoMaxCol(count) ((count == 4) ? 2 :3)


@interface WBStatusPicturesView ()


@property (nonatomic,weak)UICollectionView * waterView;

@end

@implementation WBStatusPicturesView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
}


+(CGSize )photosSizeWithCount:(NSInteger)count
{
    //最大列数
    int maxCols = KStatusPhotoMaxCol(count);;
    
    //列数
    int cols = count > 2 ? maxCols : count;
    CGFloat photoW = cols * KStatusPhotoWH + (cols -1)*KStatusPhotoMargin;
    
    
    //行数
    int rows = (count + maxCols - 1) / maxCols;//3是最大列数
    CGFloat photoH = rows * KStatusPhotoWH + (rows -1)*KStatusPhotoMargin;
    
    return CGSizeMake(photoW, photoH);
}

@end
