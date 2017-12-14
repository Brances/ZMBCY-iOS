//
//  ZMRankTopCollectionViewCell.m
//  ZMBCY
//
//  Created by ZOMAKE on 2017/12/14.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "ZMRankTopCollectionViewCell.h"

@implementation ZMRankTopCollectionViewCell

- (UIView *)mainView{
    if (!_mainView) {
        _mainView = [UIView new];
        _mainView.backgroundColor = [ZMColor whiteColor];
        [self.contentView addSubview:_mainView];
        [_mainView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(0);
            make.bottom.mas_offset(0);
        }];
        [_mainView.superview layoutIfNeeded];
    }
    return _mainView;
}

- (ZMDiscoverRecommendHotRecommCellWaterView *)view{
    if (!_view) {
        _view = [[ZMDiscoverRecommendHotRecommCellWaterView alloc] init];
        [self.mainView addSubview:_view];
        [self.mainView sendSubviewToBack:_view];
        [_view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(0);
            make.bottom.mas_equalTo(-40);
        }];
    }
    return _view;
}

- (ZMDiscoverRecommendProfileView *)profileView{
    if (!_profileView) {
        _profileView = [[ZMDiscoverRecommendProfileView alloc] init];
        _profileView.backgroundColor = [ZMColor whiteColor];
        [self.mainView addSubview:_profileView];
        [self.mainView bringSubviewToFront:_profileView];
        [_profileView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_equalTo(0);
            make.height.mas_equalTo(40);
        }];
        [_profileView.superview layoutIfNeeded];
    }
    return _profileView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [ZMColor appGraySpaceColor];
    }
    return self;
}

- (void)setModel:(ZMRankingModel *)model{
    _model = model;
    
    [self.view.thumbImageView setImageWithURL:[NSURL URLWithString:model.imageInfo.fullUrl] placeholder:placeholderFailImage];
    [self.profileView.thumbImageView setImageWithURL:[NSURL URLWithString:model.author.portraitFullUrl] placeholder:placeholderAvatarImage];
    self.profileView.nameLabel.text = model.author.nickName;
    self.profileView.nameLabel.textColor = [ZMColor blackColor];
    self.profileView.praiseButton.selected = model.hasSupport;
    
    if (model.rankNum == 1) {
        self.view.topImageView.image = [UIImage imageNamed:@"double_line_one"];
        [self.view.topButton setTitle:@"Top1" forState:UIControlStateNormal];
    }else if (model.rankNum == 2) {
        self.view.topImageView.image = [UIImage imageNamed:@"double_line_two"];
        [self.view.topButton setTitle:@"Top2" forState:UIControlStateNormal];
    }else{
        self.view.topImageView.image = [UIImage imageNamed:@"double_line_three"];
        [self.view.topButton setTitle:@"Top3" forState:UIControlStateNormal];
    }
    
}

@end


@implementation ZMRankTopDateTitleCollectionViewCell

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.userInteractionEnabled = YES;
        _nameLabel.font = [UIFont systemFontOfSize:15];
        _nameLabel.textColor = [ZMColor appSubColor];
        [self.contentView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView);
            make.left.mas_equalTo(12);
        }];
    }
    return _nameLabel;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [ZMColor appGraySpaceColor];
    }
    return self;
}


@end

