//
//  WBToolBar.m
//  TFWeibo
//
//  Created by Tengfei on 15/12/20.
//  Copyright © 2015年 tengfei. All rights reserved.
//

#import "WBToolBar.h"
#import "Status.h"
#import "DWBubbleMenuButton.h"

@interface WBToolBar()
@property (nonatomic , weak) DWBubbleMenuButton *dingdingAnimationMenu;

@property (nonatomic,weak)UILabel *label;

@end


@implementation WBToolBar

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
//        self.backgroundColor = [UIColor grayColor];
//        [self dingdingAnimation];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.f, 0.f, 40.f, 40.f)];
        self.label = label;
        
        label.text = @"Tap";
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.layer.cornerRadius = label.frame.size.height / 2.f;
        label.backgroundColor =[UIColor colorWithRed:0.f green:0.f blue:0.f alpha:0.5f];
        label.clipsToBounds = YES;

        
        DWBubbleMenuButton *upMenuView = [[DWBubbleMenuButton alloc] initWithFrame:CGRectMake(self.frame.size.width - label.frame.size.width - 20.f,
                                                                                              self.frame.size.height - label.frame.size.height - 20.f,
                                                                                              label.frame.size.width,
                                                                                              label.frame.size.height)
                                                                expansionDirection:DirectionLeft];
        upMenuView.homeButtonView = label;
        [upMenuView addButtons:[self createDemoButtonArray]];
        
        self.dingdingAnimationMenu = upMenuView;
        [self addSubview:upMenuView];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.label.frame = CGRectMake(0.f, 0.f, 40.f, 40.f);
    self.dingdingAnimationMenu.frame = CGRectMake(self.frame.size.width - self.label.frame.size.width - 20.f,
                                                  self.frame.size.height - self.label.frame.size.height - 20.f,
                                                  self.label.frame.size.width,
                                                  self.label.frame.size.height);
}


-(void)setStatus:(Status *)status
{
    _status = status;
}


/**
 *  钉钉菜单动画
 */
-(void)dingdingAnimation{
  
    if (!_dingdingAnimationMenu) {
        UILabel *homeLabel = [self createHomeButtonView];
        
        DWBubbleMenuButton *upMenuView = [[DWBubbleMenuButton alloc] initWithFrame:CGRectMake(self.frame.size.width - homeLabel.frame.size.width - 20.f,
                                                                                              self.frame.size.height - homeLabel.frame.size.height - 20.f,
                                                                                              homeLabel.frame.size.width,
                                                                                              homeLabel.frame.size.height)
                                                                expansionDirection:DirectionLeft];
        upMenuView.homeButtonView = homeLabel;
        [upMenuView addButtons:[self createDemoButtonArray]];
        
        _dingdingAnimationMenu = upMenuView;
        
        [self addSubview:upMenuView];
    }else{
        _dingdingAnimationMenu.hidden = NO;
    }
}

- (UILabel *)createHomeButtonView {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.f, 0.f, 40.f, 40.f)];
    self.label = label;
    
    label.text = @"Tap";
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.layer.cornerRadius = label.frame.size.height / 2.f;
    label.backgroundColor =[UIColor colorWithRed:0.f green:0.f blue:0.f alpha:0.5f];
    label.clipsToBounds = YES;
    
    return label;
}

- (NSArray *)createDemoButtonArray {
    NSMutableArray *buttonsMutable = [[NSMutableArray alloc] init];
    
    int i = 0;
    for (NSString *title in @[@"点赞", @"B", @"C", @"D", @"E", @"F"]) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitle:title forState:UIControlStateNormal];
        
        button.frame = CGRectMake(0.f, 0.f, 30.f, 30.f);
        button.layer.cornerRadius = button.frame.size.height / 2.f;
        button.backgroundColor = [UIColor colorWithRed:0.f green:0.f blue:0.f alpha:0.5f];
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        button.clipsToBounds = YES;
        button.tag = i++;
        
        [button addTarget:self action:@selector(dwBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [buttonsMutable addObject:button];
    }
    
    return [buttonsMutable copy];
}

- (void)dwBtnClick:(UIButton *)sender {
    NSLog(@"DWButton tapped, tag: %ld", (long)sender.tag);
}



@end
