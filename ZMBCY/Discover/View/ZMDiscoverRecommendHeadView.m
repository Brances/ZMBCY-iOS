//
//  ZMDiscoverRecommendHeadView.m
//  ZMBCY
//
//  Created by Brance on 2017/11/26.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "ZMDiscoverRecommendHeadView.h"

@implementation ZMDiscoverRecommendHeadView

- (instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = [ZMColor appGraySpaceColor];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [ZMColor appGraySpaceColor];
    }
    return self;
}

- (UIView *)mainView{
    if (!_mainView) {
        self.mainView = [[UIView alloc] init];
        self.mainView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.mainView];
        [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.top.mas_equalTo(2);
        }];
        [self.mainView.superview layoutIfNeeded];
    }
    return _mainView;
}

- (UIImageView *)iconImageView{
    if (!_iconImageView) {
        _iconImageView = [UIImageView new];
        _iconImageView.image = placeholderFailImage;
        [self.mainView addSubview:_iconImageView];
        [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(20, 20));
            make.centerY.mas_equalTo(self.mainView);
            make.left.mas_equalTo(10);
        }];
    }
    return _iconImageView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont systemFontOfSize:13];
        _titleLabel.textColor = [ZMColor blackColor];
        [self.mainView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.iconImageView.mas_right).with.offset(5);
            make.centerY.mas_equalTo(self.mainView);
        }];
    }
    return _titleLabel;
}

- (void)setupUI:(NSString *)text{
    self.titleLabel.text = text;
}

@end
