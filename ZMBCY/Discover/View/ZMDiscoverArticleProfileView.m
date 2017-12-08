//
//  ZMDiscoverArticleProfileView.m
//  ZMBCY
//
//  Created by ZOMAKE on 2017/12/8.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "ZMDiscoverArticleProfileView.h"

@implementation ZMDiscoverArticleProfileView

- (instancetype) initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [ZMColor whiteColor];
        [self setupUI];
    }
    return self;
}
- (instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = [ZMColor whiteColor];
        [self setupUI];
    }
    return self;
}
- (void)setupUI{
    _mainView = [UIView new];
    _mainView.backgroundColor = [ZMColor whiteColor];
    [self addSubview:_mainView];
    [_mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
        
    }];
    
    _thumb = [UIImageView new];
    _thumb.size = CGSizeMake(25, 25);
    _thumb.layer.cornerRadius = _thumb.size.width * 0.5;
    _thumb.layer.masksToBounds = YES;
    [_mainView addSubview:_thumb];
    [_thumb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(_thumb.size);
        make.left.mas_equalTo(12);
        make.centerY.mas_equalTo(_mainView.mas_centerY);
    }];
    
    _praiseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _praiseButton.adjustsImageWhenHighlighted = NO;
    _praiseButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [_praiseButton setImage:[UIImage imageNamed:@"ill_cos_like"] forState:UIControlStateNormal];
    [_praiseButton setImage:[UIImage imageNamed:@"ill_cos_liked"] forState:UIControlStateSelected];
    [_mainView addSubview:_praiseButton];
    [_praiseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.centerY.mas_equalTo(_thumb.mas_centerY);
        make.height.mas_equalTo(_mainView.mas_height);
        make.width.mas_equalTo(60);
    }];
    [_praiseButton addTarget:self action:@selector(clickPraiseButton:) forControlEvents:UIControlEventTouchUpInside];
    [_praiseButton.superview layoutIfNeeded];
    
    _nickLabel = [YYLabel new];
    _nickLabel.font = [UIFont systemFontOfSize:15];
    _nickLabel.textColor = [ZMColor blackColor];
    [_mainView addSubview:_nickLabel];
    [_nickLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_thumb.mas_right).with.offset(20);
        make.centerY.mas_equalTo(_thumb.mas_centerY);
        make.right.mas_equalTo(_praiseButton.mas_left).with.offset(-20);
    }];
}

#pragma mark - private - TouchUpInSide
- (void)clickPraiseButton:(UIButton *)btn{
    btn.selected = !btn.selected;
    if (self.praiseBlock) {
        self.praiseBlock(btn.selected);
    }
}

@end
