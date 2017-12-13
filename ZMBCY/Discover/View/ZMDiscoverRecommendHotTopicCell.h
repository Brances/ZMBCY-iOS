//
//  ZMDiscoverRecommendHotTopicCell.h
//  ZMBCY
//
//  Created by Brance on 2017/11/26.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "YYTableViewCell.h"
#import "ZMTopicModel.h"
#import "ZMImageView.h"

@class ZMDiscoverRecommendHotTopicCellView;
@interface ZMDiscoverRecommendHotTopicCell : YYTableViewCell

@property (nonatomic, strong) UIView        *mainView;
@property (nonatomic, strong) ZMDiscoverRecommendHotTopicCellView   *bigImageView;
@property (nonatomic, strong) ZMDiscoverRecommendHotTopicCellView   *leftImageView;
@property (nonatomic, strong) ZMDiscoverRecommendHotTopicCellView   *rightImageView;

- (void)setupUI:(NSArray *)hotTopicArray;

@end

@interface ZMDiscoverRecommendHotTopicCellView : UIView

@property (nonatomic, strong) UIView        *mainView;
@property (nonatomic, strong) UIView        *maskView;
@property (nonatomic, strong) ZMImageView   *bigImageView;
@property (nonatomic, strong) UIImageView   *numImageView;
@property (nonatomic, strong) UILabel       *numLabel;

@property (nonatomic, strong) UILabel       *monthLabel;
@property (nonatomic, strong) UILabel       *dayLabel;

@property (nonatomic, strong) UILabel       *nameLabel;
@property (nonatomic, strong) UILabel       *descLabel;

#pragma mark - 设置圆角
- (void)setupCornerRadiusWithDay;

@end
