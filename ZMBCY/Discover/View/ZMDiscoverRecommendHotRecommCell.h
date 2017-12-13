//
//  ZMDiscoverRecommendHotRecommCell.h
//  ZMBCY
//
//  Created by Brance on 2017/11/28.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "YYTableViewCell.h"
#import "ZMWaterFlowLayout.h"
#import "ZMHotRecommendModel.h"
#import "ZMInsetHomeModel.h"

@class ZMDiscoverRecommendHotRecommCellWater;

@interface ZMDiscoverRecommendHotRecommCell : YYTableViewCell

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, assign) CGFloat cacheHeight;
@property (nonatomic, assign) BOOL    needUpdate;
@property (nonatomic, copy) void(^updateCellHeight)(CGFloat);
@property (nonatomic, assign) itemStyle style;

@end

@class ZMDiscoverRecommendHotRecommCellWaterView,ZMDiscoverRecommendProfileView;
@interface ZMDiscoverRecommendHotRecommCellWater : UICollectionViewCell

/** 容器 */
@property (nonatomic, strong) UIView                *mainView;
@property (nonatomic, strong) ZMDiscoverRecommendHotRecommCellWaterView *view;
@property (nonatomic, strong) ZMDiscoverRecommendProfileView            *profileView;
@property (nonatomic, strong) ZMHotRecommendModel   *model;
@property (nonatomic, strong) ZMHotInsetPostModel   *postModel;

#pragma mark - 根据布局来确定UI
- (void)setupUIWithRecommend:(itemStyle)style model:(ZMHotRecommendModel *)model;
- (void)setupUIWithPost:(itemStyle)style model:(ZMHotInsetPostModel *)model;

@end


@interface ZMDiscoverRecommendHotRecommCellWaterView : UIView

/** 容器 */
@property (nonatomic, strong) UIView                *mainView;
/** 封面图 */
@property (nonatomic, strong) ZMImageView           *thumbImageView;
/** top1 专属 icon */
@property (nonatomic, strong) UIImageView           *topImageView;
/** top1 专属 标致 */
@property (nonatomic, strong) UIButton              *topButton;
/** 底部渐变层 */
@property (nonatomic, strong) UIImageView           *bottomShadow;

@end


@interface ZMDiscoverRecommendProfileView : UIView

@property (nonatomic, strong) UIView        *mainView;
@property (nonatomic, strong) UIImageView   *thumbImageView;
@property (nonatomic, strong) UILabel       *nameLabel;
@property (nonatomic, strong) UIButton      *praiseButton;
@property (nonatomic, copy)      void(^praiseBlock)(BOOL);

@end

