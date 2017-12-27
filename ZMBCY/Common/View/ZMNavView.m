//
//  ZMNavView.m
//
//
//  Created by Brance on 17/11/24.
//  Copyright © 2016年 Brance. All rights reserved.
//

#import "ZMNavView.h"

@interface ZMNavView ()

@property (nonatomic, strong) UILabel *lineLabel;

@end

@implementation ZMNavView

- (UIView *)mainView{
    if (!_mainView) {
        _mainView = [UIView new];
        _mainView.backgroundColor = [ZMColor clearColor];
        [self addSubview:_mainView];
        [_mainView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(0);
        }];
        [_mainView.superview layoutIfNeeded];
    }
    return _mainView;
}

- (UIButton *)leftButton{
    if (!_leftButton) {
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftButton.titleLabel.font = [UIFont systemFontOfSize:15];
        _leftButton.adjustsImageWhenHighlighted = NO;
        _leftButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [_leftButton setTitleColor:[ZMColor blackColor] forState:UIControlStateNormal];
        [self.mainView addSubview:_leftButton];
        [_leftButton addTarget:self action:@selector(clickLeftButton) forControlEvents:UIControlEventTouchUpInside];
        [_leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.width.mas_equalTo(50);
            make.height.mas_equalTo(40);
            make.centerY.mas_equalTo(self.mainView.mas_centerY).with.offset((KStatusBarMargin+20)/2);
        }];
    }
    return _leftButton;
}

-(UIButton *)rightButton{
    if (!_rightButton) {
        //右边按钮
        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        rightButton.titleLabel.font = [UIFont systemFontOfSize:15];
        rightButton.adjustsImageWhenHighlighted = NO;
        [rightButton setTitleColor:[ZMColor blackColor] forState:UIControlStateNormal];
        [self.mainView addSubview:rightButton];
        self.rightButton = rightButton;
        [_rightButton addTarget:self action:@selector(clickRightButton) forControlEvents:UIControlEventTouchUpInside];
        [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-5);
            make.width.mas_equalTo(50);
            make.height.mas_equalTo(40);
            make.centerY.mas_equalTo(self.leftButton);
        }];
        [self.rightButton.superview layoutIfNeeded];
    }
    return _rightButton;
}

-(UIButton *)centerButton{
    if (!_centerButton) {
        //中间按钮
        UIButton *centerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        centerButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [centerButton setTitleColor:[ZMColor blackColor] forState:UIControlStateNormal];
        centerButton.adjustsImageWhenHighlighted = NO;
        [self.mainView addSubview:centerButton];
        self.centerButton = centerButton;
        [_centerButton addTarget:self action:@selector(clickCenterButton) forControlEvents:UIControlEventTouchUpInside];
        [self.centerButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.height.mas_equalTo(self.leftButton.mas_height);
            make.width.mas_equalTo(kScreenWidth - (self.rightButton.width + 38) * 2);
            make.centerY.mas_equalTo(self.leftButton);
        }];
        [self.centerButton.superview layoutIfNeeded];
    }
    return _centerButton;
}

-(UILabel *)lineLabel{
    if (!_lineLabel) {
        //底部分割线
        UILabel *lineLabel = [[UILabel alloc] init];
        lineLabel.backgroundColor = [ZMColor colorWithHexString:@"0xDCDCDC" alpha:1.0];
        self.lineLabel = lineLabel;
        [self.mainView addSubview:lineLabel];
        [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.height.mas_equalTo(0.5);
        }];
        [self.mainView bringSubviewToFront:lineLabel];
    }
    return _lineLabel;
}

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
    [self lineLabel];
}

- (void)setShowBottomLabel:(BOOL)showBottomLabel{
    self.lineLabel.hidden = !showBottomLabel;
}

#pragma mark - private
- (void)clickLeftButton{
    [self.viewController.navigationController popViewControllerAnimated:YES];
    if (self.leftButtonBlock) {
        self.leftButtonBlock();
    }
}

- (void)clickCenterButton{
    if (self.cenTerButtonBlock) {
        self.cenTerButtonBlock();
    }
}

- (void)clickRightButton{
    if (self.rightButtonBlock) {
        self.rightButtonBlock();
    }
}
@end
