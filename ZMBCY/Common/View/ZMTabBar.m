//
//  ZMTabBar.m
//  Zomake
//
//  Created by uzhengxiang on 16/6/20.
//  Copyright © 2016年 ZOMAKE. All rights reserved.
//

#import "ZMTabBar.h"

@interface ZMTabBar()

@property (nonatomic, strong) UIButton *plusBtn;

@end

@implementation ZMTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
//        UIView *view = [[UIView alloc] init];
//        view.frame = self.bounds;
//        view.backgroundColor = [ZMColor colorWithHexString:@"000000" alpha:0.8];
//        [self addSubview:view];
        
        UIButton *plusBtn = [[UIButton alloc] init];
        
        plusBtn.backgroundColor = [ZMColor redColorWithZOMAKE];
        [plusBtn setTitle:@"+" forState:UIControlStateNormal];
        plusBtn.titleLabel.font = [ZMFont defaultZOMAKEFontWithSize:30];
        plusBtn.size = CGSizeMake(frame.size.width * 0.2 - 20, frame.size.height - 10);
        [plusBtn addTarget:self action:@selector(plusBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        self.plusBtn = plusBtn;
    }
    return self;
}

/**
 *  加号按钮点击
 */
- (void)plusBtnClick
{
    // 通知代理
    if ([self.delegates respondsToSelector:@selector(tabBarDidClickPlusButton:)]) {
        [self.delegates tabBarDidClickPlusButton:self];
    }
}

/**
 *  想要重新排布系统控件subview的布局，推荐重写layoutSubviews，在调用父类布局后重新排布。
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 1.设置加号按钮的位置
    self.plusBtn.centerX = self.width*0.5;
    self.plusBtn.centerY = self.height*0.5;
    
    // 2.设置其他tabbarButton的frame
    CGFloat tabBarButtonW = self.width / 5;
    CGFloat tabBarButtonIndex = 0;
    for (UIView *child in self.subviews) {
        Class class = NSClassFromString(@"UITabBarButton");
        if ([child isKindOfClass:class]) {
            // 设置x
            child.x = tabBarButtonIndex * tabBarButtonW;
            // 设置宽度
            child.width = tabBarButtonW;
            // 增加索引
            tabBarButtonIndex++;
            if (tabBarButtonIndex == 2) {
                
                [self addSubview:self.plusBtn];
                tabBarButtonIndex++;
            }
        }
    }
}



@end
