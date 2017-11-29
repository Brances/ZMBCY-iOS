//
//  ZMWaterFlowLayout.h
//  ZMBCY
//
//  Created by ZOMAKE on 2017/11/28.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WaterFlowLayoutDelegate;

@interface ZMWaterFlowLayout : UICollectionViewLayout

@property (nonatomic, weak) id<WaterFlowLayoutDelegate> delegate;
@property (nonatomic, copy) void(^updateHeight)(CGFloat);
@end

@protocol WaterFlowLayoutDelegate <NSObject>

@required
- (CGFloat)WaterFlowLayout:(ZMWaterFlowLayout *)WaterFlowLayout heightForRowAtIndexPath:(NSInteger)index itemWidth:(CGFloat)itemWidth;

@optional
- (CGFloat)columnCountInWaterflowLayout:(ZMWaterFlowLayout *)waterflowLayout;
- (CGFloat)columnMarginInWaterflowLayout:(ZMWaterFlowLayout *)waterflowLayout;
- (CGFloat)rowMarginInWaterflowLayout:(ZMWaterFlowLayout *)waterflowLayout;
- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(ZMWaterFlowLayout *)waterflowLayout;

@end

