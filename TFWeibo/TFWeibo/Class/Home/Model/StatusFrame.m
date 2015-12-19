//
//  StatusFrame.m
//  TFWeibo
//
//  Created by Tengfei on 15/12/19.
//  Copyright © 2015年 tengfei. All rights reserved.
//

#import "StatusFrame.h"
#import "Status.h"
#import "User.h"
#import "WBStatusImgsView.h"

/**  cell的边框宽度 */
#define KStatusCellBorderW 10


@implementation StatusFrame

-(void)setStatus:(Status *)status
{
    _status = status;
    User *user = status.user;
    
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width;
    
    /** 原创微博整体 */
    
    CGFloat iconHW = 35;
    CGFloat iconX = KStatusCellBorderW;
    CGFloat iconY = KStatusCellBorderW;
    self.iconViewF = CGRectMake(iconX, iconY, iconHW, iconHW);
    
    /** 昵称 */
    CGFloat nameX = CGRectGetMaxX(self.iconViewF) + KStatusCellBorderW;
    CGFloat nameY = iconY;
    CGSize nameSize = [self sizeWithText:user.name font:KStatusNameFont];
    self.nameLabelF = (CGRect){{nameX,nameY},nameSize};
    
    
    /** 原创微博-头像 */
    if (user.isVip) {
        CGFloat vipX = CGRectGetMaxX(self.nameLabelF)+KStatusCellBorderW;
        CGFloat vipY = nameY;
        CGFloat vipH = nameSize.height;
        CGFloat vipW = 14;
        self.vipViewF = CGRectMake(vipX, vipY, vipW, vipH);
    }
    
    /**会员图标 */
    
    
    
    /** 时间 */
    CGFloat timeX = nameX;
    CGFloat timeY = CGRectGetMaxY(self.nameLabelF)+KStatusCellBorderW;
    CGSize timeSize = [self sizeWithText:status.created_at font:KStatusTimeFont];
    self.timeLabelF =  (CGRect){{timeX,timeY},timeSize};
    
    /** 来源 */
    CGFloat sourceX = CGRectGetMaxX(self.timeLabelF)+KStatusCellBorderW;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [self sizeWithText:status.source font:KStatusSourceFont];
    self.sourceLabelF =  (CGRect){{sourceX,sourceY},sourceSize};
    
    /** 正文 */
    CGFloat contentX = iconX;
    CGFloat contentY = MAX(CGRectGetMaxY(self.iconViewF), CGRectGetMaxY(self.timeLabelF)+KStatusCellBorderW);
    CGFloat maxW = cellW - 2*KStatusCellBorderW;
    CGSize contentSize = [self sizeWithText:status.text font:KStatusContentFont maxW:maxW];
    self.contentLabelF =  (CGRect){{contentX,contentY},contentSize};
    
    
    
    /**配图 */
    CGFloat originH = 0;
    
    
    if (status.pic_urls.count) {//有配图
        CGFloat photoX= contentX;
        CGFloat photoY = CGRectGetMaxY(self.contentLabelF)+KStatusCellBorderW;
        CGSize photoSize = [WBStatusImgsView photosSizeWithCount:status.pic_urls.count];
        self.photoViewF = CGRectMake(photoX, photoY, photoSize.width, photoSize.height);
        
        originH =  CGRectGetMaxY(self.photoViewF)+KStatusCellBorderW;
    }else{
        originH =  CGRectGetMaxY(self.contentLabelF)+KStatusCellBorderW;
    }
    
    /** origin */
    CGFloat originX = 0;
    CGFloat originY = KStatusCellMarginW;
    CGFloat originW = cellW;
    self.originalViewF = CGRectMake(originX, originY, originW, originH);
    
    /**  被转发微博 */
    CGFloat toolBarY = 0;
    if (status.retweeted_status) {
        
        Status *retWeetSatus = status.retweeted_status;
        NSString *retweetContent = [NSString stringWithFormat:@"@%@ : %@",retWeetSatus.user.name,retWeetSatus.text];
        CGFloat retweetContentX = KStatusCellBorderW;
        CGFloat retweetContentY = KStatusCellBorderW;
        CGSize retweetContentSize = [self sizeWithText:retweetContent font:KRetweetStatusContentFont maxW:maxW];
        
        self.retweetContentLabelF = CGRectMake(retweetContentX, retweetContentY, retweetContentSize.width, retweetContentSize.height);
        
        CGFloat retweetOriginH = 0;
        if (retWeetSatus.pic_urls.count) {
            CGFloat photoX= contentX;
            CGFloat photoY = CGRectGetMaxY(self.retweetContentLabelF)+KStatusCellBorderW;
            CGSize photoSize = [WBStatusImgsView photosSizeWithCount:retWeetSatus.pic_urls.count];
            self.retweetPhotoViewF = CGRectMake(photoX, photoY, photoSize.width, photoSize.height);
            
            retweetOriginH =  CGRectGetMaxY(self.retweetPhotoViewF)+KStatusCellBorderW;
        }else{
            retweetOriginH =  CGRectGetMaxY(self.retweetContentLabelF)+KStatusCellBorderW;
        }
        
        CGFloat retweetX = 0;
        CGFloat retweetY = CGRectGetMaxY(self.originalViewF);
        self.retweetViewF = CGRectMake(retweetX, retweetY, cellW, retweetOriginH);
        
        
        toolBarY = CGRectGetMaxY(self.retweetViewF);
    }else{
        toolBarY = CGRectGetMaxY(self.originalViewF);
    }
    
    CGFloat toolBarH = 35;
    self.toolBarF = CGRectMake(0, toolBarY, cellW, toolBarH);
    
    //计算cell的高度
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
