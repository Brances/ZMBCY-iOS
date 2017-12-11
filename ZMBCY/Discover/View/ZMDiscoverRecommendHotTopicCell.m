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
    
    _bigImageView = [[ZMImageView alloc] init];
    _bigImageView.image = placeholderFailImage;
    [_mainView addSubview:_bigImageView];
    [_bigImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(190 * FIT_WIDTH);
    }];
    
    _leftImageView = [[ZMImageView alloc] init];
    _leftImageView.image = [YYImage imageWithColor:[ZMColor appLightGrayColor]];
    [_mainView addSubview:_leftImageView];
    [_leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(_bigImageView.mas_bottom).with.offset(2);
        make.width.height.mas_equalTo((kScreenWidth-2)/2);
    }];
    
    _rightImageView = [[ZMImageView alloc] init];
    _rightImageView.image = placeholderFailImage;
    [_mainView addSubview:_rightImageView];
    [_rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(_bigImageView.mas_bottom).with.offset(2);
        make.width.height.mas_equalTo((kScreenWidth-2)/2);
    }];
    
}

- (void)setupUI:(NSArray *)hotTopicArray{
    if (!hotTopicArray.count) return;
    NSString *bigCover = [NSString stringWithFormat:@"%@%@%@%@",HttpImageURLPre,((ZMTopicModel *)[hotTopicArray safeObjectAtIndex:0]).cover,HttpImageURLSuffixScanle(@"750", @"380"),((ZMTopicModel *)[hotTopicArray safeObjectAtIndex:0]).imageSuffix];
    NSString *leftCover = [NSString stringWithFormat:@"%@%@%@%@",HttpImageURLPre,((ZMTopicModel *)[hotTopicArray safeObjectAtIndex:1]).cover,HttpImageURLSuffixSquare,((ZMTopicModel *)[hotTopicArray safeObjectAtIndex:1]).imageSuffix];
    NSString *rightCover = [NSString stringWithFormat:@"%@%@%@%@",HttpImageURLPre,((ZMTopicModel *)[hotTopicArray safeObjectAtIndex:2]).cover,HttpImageURLSuffixSquare,((ZMTopicModel *)[hotTopicArray safeObjectAtIndex:2]).imageSuffix];
    
    [self.bigImageView setAnimationLoadingImage:[NSURL URLWithString:bigCover] placeholder:placeholderFailImage];
    [self.leftImageView setAnimationLoadingImage:[NSURL URLWithString:leftCover] placeholder:placeholderFailImage];
    [self.rightImageView setAnimationLoadingImage:[NSURL URLWithString:rightCover] placeholder:placeholderFailImage];
}

@end
