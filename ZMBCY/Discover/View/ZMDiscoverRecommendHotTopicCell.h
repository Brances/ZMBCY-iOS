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

@interface ZMDiscoverRecommendHotTopicCell : YYTableViewCell

@property (nonatomic, strong) UIView        *mainView;
@property (nonatomic, strong) ZMImageView   *bigImageView;
@property (nonatomic, strong) ZMImageView   *leftImageView;
@property (nonatomic, strong) ZMImageView   *rightImageView;

- (void)setupUI:(NSArray *)hotTopicArray;

@end
