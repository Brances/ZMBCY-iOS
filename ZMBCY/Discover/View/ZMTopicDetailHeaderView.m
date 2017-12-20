//
//  ZMTopicDetailHeaderView.m
//  ZMBCY
//
//  Created by ZOMAKE on 2017/12/20.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "ZMTopicDetailHeaderView.h"

@implementation ZMTopicDetailHeaderView

- (UIView *)mainView{
    if (!_mainView) {
        _mainView = [UIView new];
        _mainView.frame = self.frame;
        _mainView.backgroundColor = [ZMColor appMainColor];
        [self addSubview:_mainView];
        [_mainView.superview layoutIfNeeded];
    }
    return _mainView;
}

-(UIImageView *)headImageView{
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.mainView.height)];
        self.headImageView.image = [YYImage imageWithColor:[ZMColor appMainColor]];
    }
    return _headImageView;
}

- (UIImageView *)leftTopImageView{
    if (!_leftTopImageView) {
        _leftTopImageView = [UIImageView new];
        UIImage *image = [UIImage imageNamed:@"GList_top_left~iphone"];
        _leftTopImageView.image = image;
        [self.mainView addSubview:_leftTopImageView];
        [_leftTopImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.size.mas_equalTo(image.size);
            make.bottom.mas_equalTo(-(self.mainView.height - image.size.height + 40));
        }];
    }
    return _leftTopImageView;
}

- (UIImageView *)rightBottomImageView{
    if (!_rightBottomImageView) {
        _rightBottomImageView = [UIImageView new];
        UIImage *image = [UIImage imageNamed:@"GList_top_right~iphone"];
        _rightBottomImageView.image = image;
        [self.mainView addSubview:_rightBottomImageView];
        [_rightBottomImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(0);
            make.size.mas_equalTo(image.size);
            make.bottom.mas_equalTo(0);
        }];
    }
    return _rightBottomImageView;
}

- (UILabel *)nickLabel{
    if (!_nickLabel) {
        _nickLabel = [UILabel new];
        _nickLabel.font = [UIFont systemFontOfSize:12];
        _nickLabel.textColor = [ZMColor whiteColor];
        [self.mainView addSubview:_nickLabel];
        [_nickLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.thumbImageView);
            make.centerX.mas_equalTo(self.mainView.mas_centerX).with.offset(15);
        }];
    }
    return _nickLabel;
}

- (UIImageView *)thumbImageView{
    if (!_thumbImageView) {
        _thumbImageView = [UIImageView new];
        _thumbImageView.layer.masksToBounds = YES;
        _thumbImageView.layer.cornerRadius = 20 * 0.5;
        _thumbImageView.image = placeholderAvatarImage;
        [self.mainView addSubview:_thumbImageView];
        [_thumbImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(20, 20));
            make.right.mas_equalTo(self.nickLabel.mas_left).with.offset(-5);
            make.bottom.mas_equalTo(-10);
        }];
        
    }
    return _thumbImageView;
}

- (UIButton *)followButton{
    if (!_followButton) {
        _followButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _followButton.layer.masksToBounds = YES;
        _followButton.layer.cornerRadius = 3;
        _followButton.layer.borderColor = [ZMColor whiteColor].CGColor;
        _followButton.layer.borderWidth = 1;
        _followButton.backgroundColor = [ZMColor clearColor];
        _followButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_followButton setTitle:@"关注" forState:UIControlStateNormal];
        [self.mainView addSubview:_followButton];
        [_followButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mainView);
            make.bottom.mas_equalTo(self.thumbImageView.mas_top).with.offset(-20);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(32);
        }];
    }
    return _followButton;
}

- (YYLabel *)descLabel{
    if (!_descLabel) {
        _descLabel = [YYLabel new];
        _descLabel.numberOfLines = 0;
        [self.mainView addSubview:_descLabel];
        [_descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(30);
            make.right.mas_equalTo(-30);
            make.bottom.mas_equalTo(self.followButton.mas_top).with.offset(-10);
        }];
    }
    return _descLabel;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [ZMColor whiteColor];
        _titleLabel.font = [UIFont boldSystemFontOfSize:20];
        [self.mainView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.right.mas_equalTo(-20);
            make.bottom.mas_equalTo(self.descLabel.mas_top).with.offset(-10);
            make.height.mas_equalTo(25);
        }];
    }
    return _titleLabel;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.leftTopImageView.hidden = NO;
        self.rightBottomImageView.hidden = NO;
        self.followButton.hidden = NO;
    }
    return self;
}

- (void)setModel:(ZMTopicDetailModel *)model{
    if (model) {
        _model = model;
        self.nickLabel.text = model.user_name;
        self.descLabel.textLayout = model.descLayout;
        [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(model.descHeight);
        }];
        self.titleLabel.text = model.collect_name;
    }
}

@end
