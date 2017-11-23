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
    leftButton.size = CGSizeMake(DefaultSpace * 2, self.height - 20);
    leftButton.titleLabel.font = [ZMFont iconOutlineFontWithSize:18];
    leftButton.x = 0;
    leftButton.centerY = self.centerY + KStatusBarMargin;
    [leftButton setTitleColor:textColor forState:UIControlStateNormal];
    [mainView addSubview:leftButton];
    
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.size = CGSizeMake(88, self.height - 20);
    rightButton.titleLabel.font = [ZMFont iconOutlineFontWithSize:18];
    rightButton.x = UISCREENWIDTH - rightButton.width;
    //rightButton.y = 20;
    rightButton.centerY = self.centerY + KStatusBarMargin;
    rightButton.titleEdgeInsets = UIEdgeInsetsMake(0, DefaultSpace, 0, 0);
    rightButton.imageEdgeInsets = UIEdgeInsetsMake(0, DefaultSpace, 0, 0);
    
    [rightButton setTitleColor:textColor forState:UIControlStateNormal];
    [mainView addSubview:rightButton];
    
    self.rightButton = rightButton;
    self.leftButton = leftButton;
//    self.leftTwoButton = leftTwoButton;
    
    //中间文本
    ZMLabel *centerLabel = [[ZMLabel alloc]init];
    centerLabel.size = CGSizeMake(UISCREENWIDTH - rightButton.width * 2, self.height - 20);
    //centerLabel.y = 20;
    centerLabel.centerY = self.centerY + KStatusBarMargin;
    centerLabel.centerX = UISCREENWIDTH/2.f;
    centerLabel.textAlignment = NSTextAlignmentCenter;
    centerLabel.font = [ZMFont defaultZOMAKEFontWithSize:18 * FIT_WIDTH];
    centerLabel.textColor = [ZMColor appNavTitleGrayColor];
    self.centerLabel = centerLabel;
    [mainView addSubview:centerLabel];
    
    //中间按钮
    UIButton *centerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    centerButton.size = CGSizeMake(UISCREENWIDTH - rightButton.width * 2, self.height - 20);
    //centerButton.y = 20;
    centerButton.centerY = self.centerY + KStatusBarMargin;
    centerButton.centerX = UISCREENWIDTH/2.f;
    centerButton.titleLabel.font = [ZMFont defaultZOMAKEFontWithSize:18];
    [centerButton setTitleColor:textColor forState:UIControlStateNormal];
    self.centerButton = centerButton;
    
    [mainView addSubview:centerButton];
    
    //右边文字
    UILabel *rightLabel = [[UILabel alloc] init];
    rightLabel.frame = rightButton.frame;
    rightLabel.width = rightButton.width - DefaultSpace;
    rightLabel.textColor = textColor;
    rightLabel.font = [ZMFont defaultZOMAKEFontWithSize:15 * FIT_WIDTH];
    rightLabel.textAlignment = NSTextAlignmentRight;
    
    [mainView addSubview:rightLabel];
    
    self.rightLabel = rightLabel;
 
    //底部分割线
    UILabel *lineLabel = [[UILabel alloc] init];
    lineLabel.frame = CGRectMake(0, self.height - 0.5, UISCREENWIDTH, 0.5);
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
