//
//  ZMNavView.m
//  Zomake
//
//  Created by uzhengxiang on 16/6/20.
//  Copyright © 2016年 ZOMAKE. All rights reserved.
//

#import "ZMNavView.h"

@interface ZMNavView ()

@property (nonatomic, strong) UILabel *lineLabel;

@end

@implementation ZMNavView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [ZMColor whiteColor];
        [self setupUI];
    }
    return self;
    
}

/**
 *  UI 界面
 */
- (void)setupUI{
    
    UIView *mainView = [[UIView alloc] init];
    mainView.frame = self.bounds;
    mainView.backgroundColor = [ZMColor clearColor];
    [self addSubview:mainView];
    
    UIColor *textColor = [ZMColor blackColor];
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.size = CGSizeMake(26 * 2, self.height - 20);
    leftButton.left = 0;
    leftButton.centerY = self.centerY + KStatusBarMargin;
    [leftButton setTitleColor:textColor forState:UIControlStateNormal];
    [mainView addSubview:leftButton];
    
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.size = CGSizeMake(88, self.height - 20);
    rightButton.x = kScreenWidth - rightButton.width;
    //rightButton.y = 20;
    rightButton.centerY = self.centerY + KStatusBarMargin;
    rightButton.titleEdgeInsets = UIEdgeInsetsMake(0, 26, 0, 0);
    rightButton.imageEdgeInsets = UIEdgeInsetsMake(0, 26, 0, 0);
    
    [rightButton setTitleColor:textColor forState:UIControlStateNormal];
    [mainView addSubview:rightButton];
    
    self.rightButton = rightButton;
    self.leftButton = leftButton;
//    self.leftTwoButton = leftTwoButton;
    
    //中间文本
    YYLabel *centerLabel = [[YYLabel alloc]init];
    centerLabel.size = CGSizeMake(kScreenWidth - rightButton.width * 2, self.height - 20);
    centerLabel.centerY = self.centerY + KStatusBarMargin;
    centerLabel.centerX = kScreenWidth/2.f;
    centerLabel.textAlignment = NSTextAlignmentCenter;
    centerLabel.font = [UIFont systemFontOfSize:16];
    centerLabel.textColor = [ZMColor appNavTitleGrayColor];
    self.centerLabel = centerLabel;
    [mainView addSubview:centerLabel];
    
    //中间按钮
    UIButton *centerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    centerButton.size = CGSizeMake(kScreenWidth - rightButton.width * 2, self.height - 20);
    centerButton.centerY = self.centerY + KStatusBarMargin;
    centerButton.centerX = kScreenWidth / 2.f;
    centerButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [centerButton setTitleColor:textColor forState:UIControlStateNormal];
    self.centerButton = centerButton;
    
    [mainView addSubview:centerButton];
    
    //右边文字
    UILabel *rightLabel = [[UILabel alloc] init];
    rightLabel.frame = rightButton.frame;
    rightLabel.width = rightButton.width - 26;
    rightLabel.textColor = textColor;
    rightLabel.font = [UIFont systemFontOfSize:16];
    rightLabel.textAlignment = NSTextAlignmentRight;
    
    [mainView addSubview:rightLabel];
    
    self.rightLabel = rightLabel;
 
    //底部分割线
    UILabel *lineLabel = [[UILabel alloc] init];
    lineLabel.frame = CGRectMake(0, self.height - 0.5, kScreenWidth, 0.5);
    lineLabel.backgroundColor = [ZMColor colorWithRed:155 withGreen:155 withBlue:155 withAlpha:1];
    self.lineLabel = lineLabel;
    [mainView addSubview:lineLabel];
    
    centerButton.adjustsImageWhenHighlighted = NO;
    rightButton.adjustsImageWhenHighlighted = NO;
    leftButton.adjustsImageWhenHighlighted = NO;

}

- (void)setIsHaveLineLabel:(BOOL)isHaveLineLabel{
    
    _isHaveLineLabel = isHaveLineLabel;
    
    self.lineLabel.hidden = !isHaveLineLabel;
    
}

//设置白色背景
- (void)setIsWhite:(BOOL)isWhite{
    _isWhite = isWhite;
    if (_isWhite) {
        self.lineLabel.backgroundColor = [ZMColor whiteColor];
    }
}

@end
