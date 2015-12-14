//
//  UITextView+Category.m
//  WeiboWeico
//
//  Created by Tengfei on 15/10/27.
//  Copyright © 2015年 tengfei. All rights reserved.
//

#import "UITextView+Category.h"

@implementation UITextView (Category)

-(void)insetAttributeText:(NSAttributedString *)text
{
    NSMutableAttributedString *attbutedText = [[NSMutableAttributedString alloc]init];
    // 拼接之前的文字（图片和普通文字）
    [attbutedText appendAttributedString:self.attributedText];
    
    NSUInteger loc = self.selectedRange.location;
//    [attbutedText insertAttributedString:text atIndex:loc];
    [attbutedText replaceCharactersInRange:self.selectedRange withAttributedString:text];

    
//    //设置字体 -- 设置属性字符串后，字体就和以前设置的字体不一样了，
    [attbutedText addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, attbutedText.length)];
    
    self.attributedText = attbutedText;
    
    //移动光标到原来的位置+1
    self.selectedRange = NSMakeRange(loc + 1, 0);

}
@end
