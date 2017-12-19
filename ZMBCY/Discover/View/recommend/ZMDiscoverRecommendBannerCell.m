//
//  ZMDiscoverRecommendBannerCell.m
//  ZMBCY
//
//  Created by Brance on 2017/11/26.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "ZMDiscoverRecommendBannerCell.h"
#import "ZMRankViewController.h"

@implementation ZMDiscoverRecommendBannerCell

- (ZMDiscoverRecommendBannerCellView *)view{
    if (!_view) {
        _view = [ZMDiscoverRecommendBannerCellView new];
        _view.userInteractionEnabled = YES;
        UITapGestureRecognizer *ger = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickJumpRank:)];
        [_view addGestureRecognizer:ger];
        [self.contentView addSubview:_view];
        [_view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(0);
        }];
    }
    return _view;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}

- (void)setModel:(ZMDiscoverBannerTopModel *)model{
    _model = model;
    [self.view.rightImageView setImageWithURL:[NSURL URLWithString:model.rightFull] placeholder:placeholderFailImage];
    [self.view.thumbImageView setImageWithURL:[NSURL URLWithString:model.headFull] placeholder:placeholderAvatarImage];
    self.view.nameLabel.text = [NSString stringWithFormat:@"@%@",model.authorName];
}

#pragma mark - 排行榜
- (void)clickJumpRank:(UITapGestureRecognizer *)tap{
    ZMRankViewController *vc = [[ZMRankViewController alloc] init];
    [self.viewController.navigationController pushViewController:vc animated:YES];
}

@end

@implementation ZMDiscoverRecommendBannerCellView

- (UIView *)mainView{
    if (!_mainView) {
        _mainView = [UIView new];
        _mainView.layer.masksToBounds = YES;
        _mainView.backgroundColor = [ZMColor appGraySpaceColor];
        [self addSubview:_mainView];
        [_mainView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(0);
        }];
        [_mainView.superview layoutIfNeeded];
    }
    return _mainView;
}

- (UIImageView *)rightImageView{
    if (!_rightImageView) {
        _rightImageView = [UIImageView new];
        [self.mainView addSubview:_rightImageView];
        [self.mainView sendSubviewToBack:_rightImageView];
        [_rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mainView.mas_centerX);
            make.top.bottom.right.mas_equalTo(0);
        }];
    }
    return _rightImageView;
}

- (UIImageView *)leftImageView{
    if (!_leftImageView) {
        _leftImageView = [UIImageView new];
        
        UIImage *image = [UIImage imageNamed:@"discovery_banner_icon~iphone"];
        _leftImageView.image = image;
        [self.mainView addSubview:_leftImageView];
        [_leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.size.mas_equalTo(image.size);
            make.centerY.mas_equalTo(self.mainView);
        }];
    }
    return _leftImageView;
}

- (UIImageView *)bgView{
    if (!_bgView) {
        _bgView = [UIImageView new];
        _bgView.image = [UIImage imageNamed:@"discovery_banner_gradient~iphone"];
        //_bgView.alpha = 0.5;
        [self.mainView addSubview:_bgView];
        [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(kScreenWidth/2.0);
            make.top.bottom.mas_equalTo(0);
            make.centerY.mas_equalTo(self.mainView);
            make.centerX.mas_equalTo(self.mainView).with.offset(40);
        }];
        [_bgView.superview layoutIfNeeded];
    }
    return _bgView;
}

- (UIImageView *)topImageView{
    if (!_topImageView) {
        _topImageView = [UIImageView new];
        UIImage *image = [UIImage imageNamed:@"discovery_banner_top1~iphone"];
        _topImageView.image = image;
        [self.mainView addSubview:_topImageView];
        [_topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(image.size);
            make.centerY.mas_equalTo(self.mainView.mas_centerY);
            make.left.mas_equalTo(12);
        }];
    }
    return _topImageView;
}

- (UIImageView *)thumbImageView{
    if (!_thumbImageView) {
        _thumbImageView = [UIImageView new];
        _thumbImageView.layer.cornerRadius = 25 * 0.5;
        _thumbImageView.layer.masksToBounds = YES;
        [self.topImageView addSubview:_thumbImageView];
        [_thumbImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(25, 25));
            make.left.mas_equalTo(40);
            make.centerY.mas_equalTo(self.topImageView.mas_bottom);
        }];
    }
    return _thumbImageView;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.textColor = [ZMColor blackColor];
        _nameLabel.font = [UIFont systemFontOfSize:13];
        [self.topImageView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.thumbImageView.mas_right).with.offset(8);
            make.centerY.mas_equalTo(self.thumbImageView);
        }];
    }
    return _nameLabel;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self leftImageView];
        [self bgView];
        [self topImageView];
    }
    return self;
}

@end

