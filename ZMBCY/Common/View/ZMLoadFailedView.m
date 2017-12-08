//
//  LPLoadFailedView.m
//  LovePlayNews
//
//  Created by tany on 16/8/30.
//  Copyright © 2016年 tany. All rights reserved.
//  webView_error_icon

#import "ZMLoadFailedView.h"

@interface ZMLoadFailedView ()

@end

@implementation ZMLoadFailedView

- (UIImageView *)failedImage{
    if (!_failedImage) {
        _failedImage = [UIImageView new];
        UIImage *image = [UIImage imageNamed:@"webView_error_icon"];
        _failedImage.image = image;
        [self addSubview:_failedImage];
        [_failedImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.size.mas_equalTo(CGSizeMake(self.width / 2.0, self.width / 2.0 * image.size.height /image.size.width));
            make.centerY.mas_equalTo(self.mas_centerY).with.offset(-40);
        }];
    }
    return _failedImage;
}

- (UIButton *)refreshButton{
    if (!_refreshButton) {
        _refreshButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _refreshButton.layer.cornerRadius = 18;
        _refreshButton.layer.masksToBounds = YES;
        [_refreshButton setTitle:@"刷新试试" forState:UIControlStateNormal];
        [_refreshButton setTitleColor:[ZMColor whiteColor] forState:UIControlStateNormal];
        _refreshButton.backgroundColor = [ZMColor appMainColor];
        _refreshButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [self addSubview:_refreshButton];
        [_refreshButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.top.mas_equalTo(_failedImage.mas_bottom).with.offset(0);
            make.size.mas_equalTo(CGSizeMake(140 * FIT_WIDTH, 38 * FIT_WIDTH));
        }];
        [_refreshButton addTarget:self action:@selector(clickRefresh:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _refreshButton;
}

+ (instancetype)loadViewWithFrame:(CGRect)frame{
    ZMLoadFailedView *failedView = [[self alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    return failedView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [ZMColor appGraySpaceColor];
        self.failedImage.hidden = NO;
        self.refreshButton.hidden = NO;
    }
    return self;
}

#pragma mark - action - private
- (void)clickRefresh:(UIButton *)btn{
    if (_retryHandle) {
        _retryHandle();
    }
    [self hide];
}

#pragma mark - 便利方法

+ (void)showLoadFailedInView:(UIView *)view
{
    [self showLoadFailedInView:view edgeInset:UIEdgeInsetsZero];
}

+ (void)showLoadFailedInView:(UIView *)view retryHandle: (void (^)(void))retryHandle
{
    [self showLoadFailedInView:view edgeInset:UIEdgeInsetsZero retryHandle:retryHandle];
}

+ (void)showLoadFailedInView:(UIView *)view edgeInset:(UIEdgeInsets)edgeInset
{
    [self showLoadFailedInView:view edgeInset:edgeInset retryHandle:nil];
}

+ (void)showLoadFailedInView:(UIView *)view edgeInset:(UIEdgeInsets)edgeInset retryHandle: (void (^)(void))retryHandle{
    ZMLoadFailedView *loadFailedView = [self loadViewWithFrame:view.frame];
    loadFailedView.edgeInset = edgeInset;
    loadFailedView.retryHandle = retryHandle;
    [loadFailedView showInView:view];
}

+ (void)showLoadFailedInView:(UIView *)view topEdge:(CGFloat)topEdge retryHandle:(void (^)(void))retryHandle{
    ZMLoadFailedView *loadFailedView = [self loadViewWithFrame:view.frame];
    loadFailedView.edgeInset = UIEdgeInsetsMake(topEdge, 0, 0, 0);
    loadFailedView.retryHandle = retryHandle;
    [loadFailedView showInView:view];
}

+ (void)hideLoadFailedForView:(UIView *)view{
    ZMLoadFailedView *loadFailedView = [self loadFailedForView:view];
    if (loadFailedView) {
        [loadFailedView hide];
    }
}

+ (ZMLoadFailedView *)loadFailedForView:(UIView *)view{
    NSEnumerator *reverseSubviews = [view.subviews reverseObjectEnumerator];
    for (UIView *subview in reverseSubviews) {
        if ([subview isKindOfClass:self]) {
            return (ZMLoadFailedView *)subview;
        }
    }
    return nil;
}

#pragma mark - 实例方法

- (void)showInView:(UIView *)view{
    if (!view) {
        return ;
    }
    if (self.superview != view) {
        [self removeFromSuperview];
        [view addSubview:self];
        [view bringSubviewToFront:self];
    }
}

- (void)hide{
    self.alpha = 1.0;
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)dealloc{
    NSLog(@"%@释放了",[self class]);
}

@end
