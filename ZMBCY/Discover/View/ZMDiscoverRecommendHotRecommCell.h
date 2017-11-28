//
//  ZMDiscoverRecommendHotRecommCell.h
//  ZMBCY
//
//  Created by ZOMAKE on 2017/11/28.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "YYTableViewCell.h"
#import "ZMWaterFlowLayout.h"
#import "ZMHotRecommendModel.h"
#import "XRWaterfallLayout.h"

@class ZMDiscoverRecommendHotRecommCellWater;

@interface ZMDiscoverRecommendHotRecommCell : YYTableViewCell

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, assign) CGFloat cacheHeight;

@end

@interface ZMDiscoverRecommendHotRecommCellWater : UICollectionViewCell

@property (nonatomic, strong) ZMImageView           *thumbImageView;
@property (nonatomic, strong) ZMHotRecommendModel   *model;


@end