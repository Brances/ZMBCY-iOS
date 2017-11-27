//
//  ZMDiscoverRecommendHotTopicCell.h
//  ZMBCY
//
//  Created by Brance on 2017/11/26.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "YYTableViewCell.h"
#import "ZMTopicModel.h"

@interface ZMDiscoverRecommendHotTopicCell : YYTableViewCell

@property (nonatomic, strong) UIView        *mainView;
@property (nonatomic, strong) UIImageView   *bigImageView;
@property (nonatomic, strong) UIImageView   *leftImageView;
@property (nonatomic, strong) UIImageView   *rightImageView;
@property (nonatomic, strong) ZMTopicModel  *model;


@end
