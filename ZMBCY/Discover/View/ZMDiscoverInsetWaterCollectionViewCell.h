//
//  ZMDiscoverInsetWaterCollectionViewCell.h
//  ZMBCY
//
//  Created by ZOMAKE on 2017/12/6.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMDiscoverInsetWaterCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, assign) CGFloat cacheHeight;
@property (nonatomic, assign) BOOL    needUpdate;
@property (nonatomic, copy) void(^updateCellHeight)(CGFloat);
@property (nonatomic, assign) itemStyle style;

@end

