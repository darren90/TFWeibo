//
//  WBStatusPictureCell.m
//  TFWeibo
//
//  Created by Tengfei on 15/12/23.
//  Copyright © 2015年 tengfei. All rights reserved.
//

#import "WBStatusPictureCell.h"
#import "PictureModel.h"

@interface WBStatusPictureCell ()

@property (weak, nonatomic) IBOutlet UIImageView *picView;

@end

@implementation WBStatusPictureCell

- (void)awakeFromNib {
    // Initialization code
    self.picView.clipsToBounds = YES;
    self.picView.userInteractionEnabled = YES;
    self.picView.contentMode = UIViewContentModeScaleAspectFill;
}

-(void)setPic:(PictureModel *)pic
{
    _pic = pic;
    
    [self.picView sd_setImageWithURL:[NSURL URLWithString:pic.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"nopic_240x240"]];
}



@end
