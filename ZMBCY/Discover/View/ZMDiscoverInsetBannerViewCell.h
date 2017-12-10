//
//  ZMDiscoverInsetBannerViewCellCollectionViewCell.h
//  ZMBCY
//
//  Created by Brance on 2017/12/5.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMDiscoverInsetBannerViewCell : UICollectionViewCell

/** model集合 */
@property (nonatomic, strong) NSMutableArray *dataArray;
/** 图片集合 */
@property (nonatomic, strong) NSMutableArray *imagesArray;
@property (nonatomic, strong) UIImageView    *thumbView;
@property (nonatomic, strong) UILabel        *nickLabel;
@property (nonatomic, strong) UILabel        *descLabel;
@property (nonatomic, strong) UIImageView    *iconView;
@property (nonatomic, strong) UILabel        *remLabel;

@end
