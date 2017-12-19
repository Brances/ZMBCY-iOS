//
//  ZMDiscoverArticleBannerViewCell.h
//  ZMBCY
//
//  Created by Brance on 2017/12/7.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "YYTableViewCell.h"

@interface ZMDiscoverArticleBannerViewCell : YYTableViewCell

/** model 集合 */
@property (nonatomic, strong) NSArray        *dataArray;
/** 图片集合 */
@property (nonatomic, strong) NSMutableArray *imagesArray;
@property (nonatomic, strong) UIImageView    *thumbView;
@property (nonatomic, strong) UILabel        *nickLabel;
@property (nonatomic, strong) UILabel        *descLabel;
@property (nonatomic, strong) UIImageView    *iconView;
@property (nonatomic, strong) UILabel        *remLabel;

@end
