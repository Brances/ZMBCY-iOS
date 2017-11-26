//
//  ZMDiscoverRecommendHotTopicCell.m
//  ZMBCY
//
//  Created by Brance on 2017/11/26.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "ZMDiscoverRecommendHotTopicCell.h"

@implementation ZMDiscoverRecommendHotTopicCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [ZMColor whiteColor];
        [self setupUI];
    }
    return self;
}

- (void)setupUI{

    _mainView = [UIView new];
    _mainView.backgroundColor = [ZMColor whiteColor];
    [self.contentView addSubview:_mainView];
    [_mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];
    
    _bigImageView = [UIImageView new];
    _bigImageView.image = [YYImage imageWithColor:[ZMColor appSupportColor]];
    [_mainView addSubview:_bigImageView];
    [_bigImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(190 * FIT_WIDTH);
    }];
    
    _leftImageView = [UIImageView new];
    _leftImageView.image = [YYImage imageWithColor:[ZMColor appLightGrayColor]];
    [_mainView addSubview:_leftImageView];
    [_leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(_bigImageView.mas_bottom).with.offset(2);
        make.width.height.mas_equalTo((kScreenWidth-2)/2);
    }];
    
    _rightImageView = [UIImageView new];
    _rightImageView.image = [YYImage imageWithColor:[ZMColor appLightGrayColor]];
    [_mainView addSubview:_rightImageView];
    [_rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(_bigImageView.mas_bottom).with.offset(2);
        make.width.height.mas_equalTo((kScreenWidth-2)/2);
    }];
    
}

@end
