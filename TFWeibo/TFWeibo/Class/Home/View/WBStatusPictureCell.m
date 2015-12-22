//
//  WBStatusPictureCell.m
//  TFWeibo
//
//  Created by Tengfei on 15/12/23.
//  Copyright © 2015年 tengfei. All rights reserved.
//

#import "WBStatusPictureCell.h"

@interface WBStatusPictureCell ()

@property (weak, nonatomic) IBOutlet UIImageView *picView;

@end

@implementation WBStatusPictureCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setPic:(NSString *)pic
{
    _pic = pic;
    
    [self.picView sd_setImageWithURL:[NSURL URLWithString:pic] placeholderImage:nil];
}



@end
