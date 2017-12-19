//
//  ZMDiscoverRecommendBannerCell.h
//  ZMBCY
//
//  Created by Brance on 2017/11/26.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "YYTableViewCell.h"
#import "ZMDiscoverBannerTopModel.h"
@class ZMDiscoverRecommendBannerCellView;
@interface ZMDiscoverRecommendBannerCell : YYTableViewCell

@property (nonatomic, strong) ZMDiscoverRecommendBannerCellView *view;
@property (nonatomic, strong) ZMDiscoverBannerTopModel          *model;

@end

@interface ZMDiscoverRecommendBannerCellView : UIView

@property (nonatomic, strong) UIView        *mainView;
@property (nonatomic, strong) UIImageView   *bgView;
@property (nonatomic, strong) UIImageView   *leftImageView;
@property (nonatomic, strong) UIImageView   *topImageView;
@property (nonatomic, strong) UIImageView   *thumbImageView;
@property (nonatomic, strong) UILabel       *nameLabel;
@property (nonatomic, strong) UIImageView   *rightImageView;

@end
