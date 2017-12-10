//
//  ZMDiscoverRecommendCircleCell.h
//  ZMBCY
//
//  Created by Brance on 2017/11/28.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "YYTableViewCell.h"
#import "ZMCircleModel.h"

@class ZMDiscoverRecommendCircleCellView;

@interface ZMDiscoverRecommendCircleCell : YYTableViewCell

- (void)setupUI:(NSArray *)array;

@end

@interface ZMDiscoverRecommendCircleCellView : UIView

/** 容器 */
@property (nonatomic, strong) UIView        *mainView;
/** 配图 */
@property (nonatomic, strong) UIImageView   *thumbImageView;
/** 名称 */
@property (nonatomic, strong) UILabel       *nameLabel;
/** 人气值 */
@property (nonatomic, strong) UILabel       *countLabel;
/** 按钮 */
@property (nonatomic, strong) UIButton      *intoButton;
/** 圈子model */
@property (nonatomic, strong) ZMCircleModel *model;


@end
