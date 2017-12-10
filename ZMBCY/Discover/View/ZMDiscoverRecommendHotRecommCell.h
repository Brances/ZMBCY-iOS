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

@interface ZMDiscoverRecommendHotRecommCellWater : UICollectionViewCell

@property (nonatomic, strong) ZMImageView           *thumbImageView;
@property (nonatomic, strong) ZMHotRecommendModel   *model;
@property (nonatomic, strong) ZMHotInsetPostModel   *postModel;

@end
