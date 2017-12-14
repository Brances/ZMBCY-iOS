//
//  ZMRankTopCollectionViewCell.h
//  ZMBCY
//
//  Created by ZOMAKE on 2017/12/14.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZMDiscoverRecommendHotRecommCell.h"
#import "ZMRankingListModel.h"

@interface ZMRankTopCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIView                                    *mainView;
@property (nonatomic, strong) ZMDiscoverRecommendHotRecommCellWaterView *view;
@property (nonatomic, strong) ZMDiscoverRecommendProfileView            *profileView;
@property (nonatomic, strong) ZMRankingModel                            *model;

@end

@interface ZMRankTopDateTitleCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UILabel           *nameLabel;
@property (nonatomic, strong) UIImageView       *arrowView;

@end
