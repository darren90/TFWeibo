//
//  WBStatusImgView.m
//  TFWeibo
//
//  Created by Tengfei on 15/12/19.
//  Copyright © 2015年 tengfei. All rights reserved.
//

#import "WBStatusImgView.h"
#import "ImgModel.h"

@interface WBStatusImgView ()
@property (nonatomic,weak)UIImageView *gifView;

@end

@implementation WBStatusImgView


-(UIImageView *)gifView
{
    if (!_gifView) {
        UIImage *image = [UIImage imageNamed:@"timeline_image_gif"];
        UIImageView *gifView = [[UIImageView alloc]initWithImage:image];
        //这样写imageView的尺寸和image的一样
        [self addSubview:gifView];
        _gifView = gifView;
    }
    return _gifView;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //        UIImage *image = [UIImage imageNamed:@"timeline_image_gif"];
        //        UIImageView *gifView = [[UIImageView alloc]initWithImage:image];
        //        //这样写imageView的尺寸和image的一样
        //        [self addSubview:gifView];
        
        
        /**
         UIViewContentModeScaleToFill,
         UIViewContentModeScaleAspectFit,      // contents scaled to fit with fixed aspect. remainder is transparent
         UIViewContentModeScaleAspectFill,     // contents scaled to fill with fixed aspect. some portion of content may be clipped.
         UIViewContentModeRedraw,              // redraw on bounds change (calls -setNeedsDisplay)
         UIViewContentModeCenter,              // contents remain same size. positioned adjusted.
         UIViewContentModeTop,
         UIViewContentModeBottom,
         UIViewContentModeLeft,
         UIViewContentModeRight,
         UIViewContentModeTopLeft,
         UIViewContentModeTopRight,
         UIViewContentModeBottomLeft,
         UIViewContentModeBottomRight,
         
         凡是带有scale均会被拉伸，
         带有Aspec，图片会保持原有的宽高比，不会变形
         */
        
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
    }
    return self;
}

-(void)setImgModel:(ImgModel *)imgModel{
    _imgModel = imgModel;
    
    //设置图片
    [self sd_setImageWithURL:[NSURL URLWithString:imgModel.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
    //显示/隐藏gif
    if ([imgModel.thumbnail_pic.lowercaseString hasSuffix:@"gif"]) {
        self.gifView.hidden = NO;
    }else {
        self.gifView.hidden = YES;
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect gifF = self.gifView.frame;
    gifF.origin.x = self.frame.size.width - gifF.size.width;
    gifF.origin.y = self.frame.size.height - gifF.size.height;
    self.gifView.frame = gifF;
}




@end
