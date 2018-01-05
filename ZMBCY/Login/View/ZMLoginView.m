//
//  ZMLoginView.m
//  ZMBCY
//
//  Created by ZOMAKE on 2018/1/5.
//  Copyright © 2018年 Brance. All rights reserved.
//

#import "ZMLoginView.h"

@interface ZMLoginView()

@property (nonatomic, strong) UIView        *mainView;
@property (nonatomic, strong) UIScrollView  *scrollView;
@property (nonatomic, strong) UIImageView   *bgImageView;
@property (nonatomic, strong) UIButton      *closeButton;
@property (nonatomic, strong) UITextField   *userNameField;


@end

@implementation ZMLoginView

- (UIView *)mainView{
    if (!_mainView) {
        _mainView = [UIView new];
        _mainView.backgroundColor = [ZMColor clearColor];
        [self.scrollView addSubview:_mainView];
        [_mainView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(0);
            make.width.mas_equalTo(self.width);
            make.height.mas_equalTo(self.height + 50);
        }];
    }
    return _mainView;
}

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        [self addSubview:_scrollView];
        [self insertSubview:_scrollView aboveSubview:self.bgImageView];
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(0);
            make.width.mas_equalTo(self.width);
            make.height.mas_equalTo(self.height);
        }];
        [_scrollView.superview layoutIfNeeded];
        _scrollView.contentSize = CGSizeMake(0, _scrollView.height + 1);
    }
    return _scrollView;
}

- (UIImageView *)bgImageView{
    if (!_bgImageView) {
        _bgImageView = [UIImageView new];
        _bgImageView.image = [UIImage imageNamed:@"login_bg_640X1136"];
        [self addSubview:_bgImageView];
        [self sendSubviewToBack:_bgImageView];
        [_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(0);
        }];
    }
    return _bgImageView;
}

- (UIButton *)closeButton{
    if (!_closeButton) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *image = [UIImage imageNamed:@"login_alert_cancel"];
        _closeButton.layer.cornerRadius = 30 * 0.5;
        _closeButton.layer.masksToBounds = YES;
        _closeButton.layer.borderColor = [ZMColor whiteColor].CGColor;
        _closeButton.layer.borderWidth = 1;
        [_closeButton setImage:image forState:UIControlStateNormal];
        [self addSubview:_closeButton];
        [self bringSubviewToFront:_closeButton];
        [_closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(20 + 5);
            make.left.mas_equalTo(5);
            make.width.mas_equalTo(30);
            make.height.mas_equalTo(30);
        }];
        [_closeButton addTarget:self action:@selector(clickLoginOut:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeButton;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [ZMColor appGraySpaceColor];
        //[self setupUI];
    }
    return self;
}

- (void)setupUI{
    [self closeButton];
    [self bgImageView];
    [self mainView];
}

#pragma mark - 退出页面
- (void)clickLoginOut:(UIButton *)btn{
    btn.enabled = NO;
    [self.viewController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
