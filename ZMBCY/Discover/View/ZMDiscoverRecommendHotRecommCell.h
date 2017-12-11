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

@class ZMDiscoverRecommendHotRecommCellWaterView;
@interface ZMDiscoverRecommendHotRecommCellWater : UICollectionViewCell

@property (nonatomic, strong) ZMDiscoverRecommendHotRecommCellWaterView *view;
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
