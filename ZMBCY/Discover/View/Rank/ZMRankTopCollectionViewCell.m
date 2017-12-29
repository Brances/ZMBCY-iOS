//
//  ZMRankTopCollectionViewCell.m
//  ZMBCY
//
//  Created by Brance on 2017/12/14.
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
    //kScreenWidth * model.imageInfo.height / model.imageInfo.width
    //https://gacha.nosdn.127.net/6c0a51fd9bf4432b88968f43911b7d21.jpg?imageView&axis=5_0&enlarge=1&quality=75&thumbnail=750y1000&type=webp
    CGFloat width = kScreenWidth * 2;
    CGFloat height = kScreenWidth * 2 * model.imageInfo.height / model.imageInfo.width;
    
    NSString *string = [NSString stringWithFormat:@"%@%@?imageView&axis=5_0&enlarge=1&quality=75&thumbnail=%.0fy%.0f&type=webp",HttpImageURLPre,model.imageInfo.imageId,width,height];
    // string model.imageInfo.fullUrl
    [self.view.thumbImageView setImageWithURL:[NSURL URLWithString:string] placeholder:placeholderFailImage];
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
        _nameLabel.textColor = [ZMColor appSupportColor];
        [self.contentView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView);
            make.left.mas_equalTo(12);
        }];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickNameLabel:)];
        [_nameLabel addGestureRecognizer:tap];
    }
    return _nameLabel;
}

- (UIImageView *)arrowView{
    if (!_arrowView) {
        _arrowView = [UIImageView new];
        UIImage *image = [UIImage imageNamed:@"topic_ground_allList_back"];
        _arrowView.image = image;
        [self.contentView addSubview:_arrowView];
        [_arrowView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(image.size.width * 0.5, image.size.height * 0.5));
            make.left.mas_equalTo(self.nameLabel.mas_right).with.offset(5);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
        }];
    }
    return _arrowView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [ZMColor appGraySpaceColor];
        [self arrowView];
    }
    return self;
}

- (void)clickNameLabel:(UITapGestureRecognizer *)tap{
    if (self.clickChangeDateBlock && self.nameLabel.text.length) {
        self.clickChangeDateBlock(self.nameLabel.text);
    }
}

@end

