//
//  ZMICarouselView.h
//  ZMICarousel
//
//  Created by Brance on 2017/12/1.
//  Copyright © 2017年 Brance. All rights reserved.
//

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunknown-pragmas"
#pragma clang diagnostic ignored "-Wreserved-id-macro"
#pragma clang diagnostic ignored "-Wobjc-missing-property-synthesis"

#import <UIKit/UIKit.h>
#import "iCarousel.h"

typedef NS_ENUM(NSInteger,ZMICarouselPageContolAligment){
    ZMICarouselPageContolAligmentCenter = 0,
    ZMICarouselPageContolAligmentRight
};

typedef NS_ENUM(NSInteger,ZMICarouselPageContolStyle){
    ZMICarouselPageContolStyleNormal = 0,     // 系统自带经典样式
    ZMICarouselPageContolStyleAnimated,       // 动画效果pagecontrol
    ZMICarouselPageContolStyleNone
};

@class ZMICarouselView;

NS_ASSUME_NONNULL_BEGIN

@protocol ZMICarouselViewDelegate <NSObject>

@optional;
/** 点击图片回调 */
- (void)ZMICarouselView:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index;
/** 图片滚动回调 */
- (void)ZMICarouselViews:(iCarousel *)carousel didScrollToIndex:(NSInteger)index;

@end

@protocol ZMICarouselViewDataSource <NSObject>

/** 返回行数 */
- (NSArray *)numberOfItemsInZMICarouselView;

@end



@interface ZMICarouselView : UIView

/** 主视图 */
@property (nonatomic, strong) iCarousel         *carousel;
//////////////////////  滚动控制API //////////////////////

/** 自动滚动间隔时间,默认2s */
@property (nonatomic, assign) CGFloat autoScrollTimeInterval;
/** 是否无限循环,默认Yes */
@property (nonatomic, assign) BOOL infiniteLoop;
/** 是否自动滚动,默认Yes */
@property (nonatomic, assign) BOOL autoScroll;
/** 是否显示底部图片遮罩 */
@property (nonatomic, assign) BOOL showBgMask;

@property (nonatomic, weak) id<ZMICarouselViewDelegate>     delegate;
@property (nonatomic, weak) id<ZMICarouselViewDataSource>   dataSource;

/** block方式监听点击 */
@property (nonatomic, copy) void (^clickItemOperationBlock)(NSInteger currentIndex);

/** block方式监听滚动 */
@property (nonatomic, copy) void (^itemDidScrollOperationBlock)(NSInteger currentIndex);

/** 占位图，用于网络未加载到图片时 */
@property (nonatomic, strong) UIImage *placeholderImage;

/** 是否显示分页控件 */
@property (nonatomic, assign) BOOL showPageControl;

/** 是否在只有一张图时隐藏pagecontrol，默认为YES */
@property(nonatomic) BOOL hidesForSinglePage;

/** pagecontrol 样式，默认为经典样式 */
@property (nonatomic, assign) ZMICarouselPageContolStyle    pageControlStyle;

/** 分页控件位置 */
@property (nonatomic, assign) ZMICarouselPageContolAligment pageControlAliment;

/** 分页控件距离轮播图的底部间距（在默认间距基础上）的偏移量 */
@property (nonatomic, assign) CGFloat pageControlBottomOffset;

/** 分页控件距离轮播图的右边间距（在默认间距基础上）的偏移量 */
@property (nonatomic, assign) CGFloat pageControlRightOffset;

/** 分页控件小圆标大小 */
@property (nonatomic, assign) CGSize pageControlDotSize;

/** 当前分页控件小圆标颜色 */
@property (nonatomic, strong) UIColor *currentPageDotColor;

/** 其他分页控件小圆标颜色 */
@property (nonatomic, strong) UIColor *pageDotColor;

/** 当前分页控件小圆标图片 */
@property (nonatomic, strong) UIImage *currentPageDotImage;

/** 其他分页控件小圆标图片 */
@property (nonatomic, strong) UIImage *pageDotImage;

+ (instancetype)icarouselViewWithFrame:(CGRect)frame;

- (void)reloadData;

@end

NS_ASSUME_NONNULL_END
#pragma clang diagnostic pop

