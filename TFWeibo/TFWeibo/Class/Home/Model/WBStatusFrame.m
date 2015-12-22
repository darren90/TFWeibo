//
//  WBStatusFrame.m
//  TFWeibo
//
//  Created by Tengfei on 15/12/21.
//  Copyright © 2015年 tengfei. All rights reserved.
//

#import "WBStatusFrame.h"
#import "Status.h"
#import "User.h"
#import "WBStatusPicturesView.h"

#define KWBStatusCellMargin 10

@implementation WBStatusFrame


-(void)setStatus:(Status *)status
{
    _status = status;
    
    User *user = status.user;
    
    
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width;


    //1: 原创微博
    CGFloat iconHW = 35;
    self.iconViewF = CGRectMake(KWBStatusCellMargin, KWBStatusCellMargin, iconHW, iconHW);
    
    CGFloat nameX = CGRectGetMaxX(self.iconViewF) + KWBStatusCellMargin;
    CGFloat nameY = CGRectGetMinY(self.iconViewF);
    CGSize nameSize = [self sizeWithText:user.name font:[UIFont systemFontOfSize:15]];
    self.nameLabelF = CGRectMake(nameX, nameY, nameSize.width, nameSize.height);
    
   
    if (user.isVip) {
        self.vipViewF = CGRectMake(CGRectGetMaxX(self.nameLabelF), nameY, 15, nameSize.height);
    }
    
    CGSize timeSize = [self sizeWithText:status.created_at font:[UIFont systemFontOfSize:12]];
    self.timeLabelF = CGRectMake(nameX, CGRectGetMaxY(self.nameLabelF)+KWBStatusCellMargin, timeSize.width, timeSize.height);
    
    CGSize clientSize = [self sizeWithText:status.source font:[UIFont systemFontOfSize:12]];
    self.clientLabelF = CGRectMake(CGRectGetMaxX(self.timeLabelF)+KWBStatusCellMargin, CGRectGetMinY(self.timeLabelF), clientSize.width, clientSize.height);
    
    CGFloat contentX = KWBStatusCellMargin;
    CGFloat contentY = MAX(CGRectGetMaxY(self.iconViewF), CGRectGetMaxY(self.timeLabelF)+KWBStatusCellMargin);
    CGFloat maxW = cellW - 2*KWBStatusCellMargin;
    CGSize contentSize = [self sizeWithText:status.text font:[UIFont systemFontOfSize:14] maxW:maxW];
    self.contentLabelF =  (CGRect){{contentX,contentY},contentSize};
    
    CGFloat topH = 0;
    if (status.pic_urls.count) {
        CGSize picSize = [WBStatusPicturesView photosSizeWithCount:status.pic_urls.count];
        self.photosViewF = CGRectMake(KWBStatusCellMargin, CGRectGetMaxY(self.contentLabelF)+KWBStatusCellMargin, cellW - 2 * KWBStatusCellMargin, picSize.height);
        
         topH =  CGRectGetMaxY(self.photosViewF)+KWBStatusCellMargin;
    }else{
        topH =  CGRectGetMaxY(self.contentLabelF)+KWBStatusCellMargin;
    }
    self.topViewF = CGRectMake(KWBStatusCellMargin, KWBStatusCellMargin, cellW, topH);
    
     //2: 转发微博
    CGFloat toolBarY = 0;
    
    Status *retStatus = status.retweeted_status;
    if (retStatus) {
        
        NSString *retContent = [NSString stringWithFormat:@"@%@ : %@",retStatus.user.name,retStatus.text];
        CGSize retweetContentSize = [self sizeWithText:retContent font:[UIFont systemFontOfSize:14] maxW:maxW];
        
        self.retContentLabelF = CGRectMake(KWBStatusCellMargin, KWBStatusCellMargin, retweetContentSize.width, retweetContentSize.height);
        
        CGFloat retBottomH = 0;
        if (retStatus.pic_urls) {
            CGFloat photoX= contentX;
            CGFloat photoY = CGRectGetMaxY(self.retContentLabelF)+KWBStatusCellMargin;
            CGSize photoSize = [WBStatusPicturesView photosSizeWithCount:retStatus.pic_urls.count];
            self.retPhotosViewF = CGRectMake(photoX, photoY, photoSize.width, photoSize.height);
            
            retBottomH = CGRectGetMaxY(self.retPhotosViewF)+KWBStatusCellMargin;;
        }else{
            retBottomH = CGRectGetMaxY(self.retContentLabelF)+KWBStatusCellMargin;;
        }
        
        CGFloat retweetY = CGRectGetMaxY(self.topViewF);
        self.retBottomViewF = CGRectMake(0, retweetY, cellW, retBottomH);
        
        toolBarY =  CGRectGetMaxY(self.retBottomViewF);
    }else{
        toolBarY = CGRectGetMaxY(self.topViewF);
    }
    
    //3: 底部工具条
    self.toolBarF = CGRectMake(0, toolBarY, cellW, 35);
    
    self.cellH = CGRectGetMaxY(self.toolBarF) ;
}


- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxW:(CGFloat)maxW
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font
{
    return [self sizeWithText:text font:font maxW:MAXFLOAT];
}



@end
