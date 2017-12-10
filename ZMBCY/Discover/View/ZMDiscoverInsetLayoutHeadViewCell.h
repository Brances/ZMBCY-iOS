//
//  ZMDiscoverInsetLayoutHeadViewCell.h
//  ZMBCY
//
//  Created by Brance on 2017/12/6.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZMDiscoverHeadModel.h"
#import "ZMDiscoverRecommendHeadView.h"


@interface ZMDiscoverInsetLayoutHeadViewCell : UICollectionViewCell

@property (nonatomic, strong) ZMDiscoverRecommendHeadView *headView;
@property (nonatomic, strong) ZMDiscoverHeadModel *model;

@end
