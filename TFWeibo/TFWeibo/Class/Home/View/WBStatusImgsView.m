//
//  WBStatusImgsView.m
//  TFWeibo
//
//  Created by Tengfei on 15/12/19.
//  Copyright © 2015年 tengfei. All rights reserved.
//

#import "WBStatusImgsView.h"
#import "ImgModel.h"
#import "WBStatusImgView.h"

#define KStatusPhotoWH 70
#define KStatusPhotoMargin 10
#define KStatusPhotoMaxCol(count) ((count == 4) ? 2 :3)

@implementation WBStatusImgsView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //        self.backgroundColor = [UIColor blueColor];
    }
    return self;
}

-(void)setPhotos:(NSArray *)photos
{
    _photos  = photos;
    
    //    //删除子控件
    //    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    int photosCount = (int)photos.count;
    while (self.subviews.count < photosCount) {
        //创建缺少的imageView
        WBStatusImgView *photpView = [[WBStatusImgView alloc]init];
        [self addSubview:photpView];
    }
    
    //遍历imageView，设置图片
    for (int i=0; i<self.subviews.count; i++) {
        WBStatusImgView *phtoView = self.subviews[i];
        
        if (i < photosCount) {
            phtoView.hidden = NO;//隐藏
            
            ImgModel *photo = photos[i];
            phtoView.imgModel = photo;
        }else{
            phtoView.hidden = YES;//显示
        }
    }
}
+(CGSize )photosSizeWithCount:(int)count
{
    //最大列数
    int maxCols = KStatusPhotoMaxCol(count);;
    
    //列数
    int cols = count > 2 ? maxCols : count;
    CGFloat photoW = cols * KStatusPhotoWH + (cols -1)*KStatusPhotoMargin;
    
    
    //行数
    //    int rows = 0;
    //    if (count % 3 == 0) {
    //        rows = count / 3;
    //    }else{
    //        rows = count / 3 + 1 ;
    //    }
    int rows = (count + maxCols - 1) / maxCols;//3是最大列数
    CGFloat photoH = rows * KStatusPhotoWH + (rows -1)*KStatusPhotoMargin;
    
    
    return CGSizeMake(photoW, photoH);
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    //设置图片的尺寸和位置
    int photosCount = (int)self.photos.count;
    int maxCol = KStatusPhotoMaxCol(photosCount);
    for (int i = 0; i < photosCount; i++) {
        WBStatusImgView *photoView = self.subviews[i];
        
        int col = i % 3;
        int row = i / 3;
        
        CGFloat photoW = KStatusPhotoWH;
        CGFloat photoH = KStatusPhotoWH;
        CGFloat photoY = row *(photoW + KStatusPhotoMargin);
        CGFloat photoX = col *(photoW + KStatusPhotoMargin);
        photoView.frame = CGRectMake(photoX, photoY, photoW, photoH);
        
    }
}




@end
