//
//  ZMICarouselView.m
//  ZMICarousel
//
//  Created by Brance on 2017/12/1.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "ZMICarouselView.h"
#import "TAPageControl.h"
#import "UIImageView+WebCache.h"
#import "ZMWorksModel.h"

#define kCycleScrollViewInitialPageControlDotSize CGSizeMake(10, 10)

#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
#define kBounds [UIScreen mainScreen].bounds

@interface ZMICarouselView()<iCarouselDataSource, iCarouselDelegate>
{
    struct {
        unsigned int numberOfItemsInZMICarouselView :1;
        unsigned int didSelectItemAtIndex :1;
        unsigned int didScrollToIndex :1;
    }_dataSourceFlags;
}

@property (nonatomic, strong) ZMImageView       *blurImageView;
@property (nonatomic, strong) UIView            *blurMaskView;
@property (nonatomic, strong) NSArray           *imagePathsGroup;
@property (nonatomic, weak) NSTimer             *timer;
@property (nonatomic, assign) NSInteger         totalItemsCount;
@property (nonatomic, weak) UIControl           *pageControl;

@property (nonatomic, strong) UIImageView       *backgroundImageView; // 当imageURLs为空时的背景图

@end

@implementation ZMICarouselView
#pragma mark - 无限循环
- (void)setInfiniteLoop:(BOOL)infiniteLoop{
    _infiniteLoop = infiniteLoop;
}
#pragma mark - 自动轮播
- (void)setAutoScroll:(BOOL)autoScroll{
    _autoScroll = autoScroll;
    [self invalidateTimer];
    if (_autoScroll) {
        [self setupTimer];
    }
}
#pragma mark - 自动轮播间隔时间
- (void)setAutoScrollTimeInterval:(CGFloat)autoScrollTimeInterval{
    _autoScrollTimeInterval = autoScrollTimeInterval;
    [self setAutoScroll:self.autoScroll];
}
#pragma mark - 数据源
- (void)setDataSource:(id<ZMICarouselViewDataSource>)dataSource{
    if (_dataSource == dataSource) {
        return;
    }
    _dataSource = dataSource;
    _dataSourceFlags.numberOfItemsInZMICarouselView = [_dataSource respondsToSelector:@selector(numberOfItemsInZMICarouselView)];
    NSLog(@"是否实现返回行数 = %u",_dataSourceFlags.numberOfItemsInZMICarouselView);
   
    
    if ([_dataSource respondsToSelector:@selector(numberOfItemsInZMICarouselView)]) {
        self.imagePathsGroup = [_dataSource numberOfItemsInZMICarouselView];
    } else {
        self.imagePathsGroup = nil;
    }
    //初始化轮播
    [self setupMainView];
}
#pragma mark - 代理
- (void)setDelegate:(id<ZMICarouselViewDelegate>)delegate{
    _delegate = delegate;
    _dataSourceFlags.didSelectItemAtIndex =[_delegate respondsToSelector:@selector(ZMICarouselView:didSelectItemAtIndex:)];
    _dataSourceFlags.didScrollToIndex = [_delegate respondsToSelector:@selector(ZMICarouselViews:didScrollToIndex:)];
    NSLog(@"是否实现点击 = %u",_dataSourceFlags.didSelectItemAtIndex);
    NSLog(@"是否实现滚动 = %u",_dataSourceFlags.didScrollToIndex);
}
#pragma mark - 图片数组
- (void)setImagePathsGroup:(NSArray *)imagePathsGroup{
    [self invalidateTimer];
    _imagePathsGroup = imagePathsGroup;
    if (imagePathsGroup.count > 1) {
        [self setAutoScroll:self.autoScroll];
    }else{
        [self setAutoScroll:NO];
    }
    [self setupPageControl];
    [self.carousel reloadData];
}
#pragma mark - 默认占位图
- (void)setPlaceholderImage:(UIImage *)placeholderImage{
    _placeholderImage = placeholderImage;
}
#pragma mark - 控制点大小
- (void)setPageControlDotSize:(CGSize)pageControlDotSize{
    _pageControlDotSize = pageControlDotSize;
    [self setupPageControl];
    if ([self.pageControl isKindOfClass:[TAPageControl class]]) {
        TAPageControl *pageContol = (TAPageControl *)_pageControl;
        pageContol.dotSize = pageControlDotSize;
    }
}
#pragma mark - 是否显示控制点
- (void)setShowPageControl:(BOOL)showPageControl{
    _showPageControl = showPageControl;
    _pageControl.hidden = !showPageControl;
}
#pragma mark - 控制点样式
- (void)setPageControlStyle:(ZMICarouselPageContolStyle)pageControlStyle{
    _pageControlStyle = pageControlStyle;
    [self setupPageControl];
}
#pragma mark - 当前控制点颜色
- (void)setCurrentPageDotColor:(UIColor *)currentPageDotColor{
    _currentPageDotColor = currentPageDotColor;
    if ([self.pageControl isKindOfClass:[TAPageControl class]]) {
        TAPageControl *pageControl = (TAPageControl *)_pageControl;
        pageControl.dotColor = currentPageDotColor;
    } else {
        UIPageControl *pageControl = (UIPageControl *)_pageControl;
        pageControl.currentPageIndicatorTintColor = currentPageDotColor;
    }
}
#pragma mark - 控制点颜色
- (void)setPageDotColor:(UIColor *)pageDotColor{
    _pageDotColor = pageDotColor;
    
    if ([self.pageControl isKindOfClass:[UIPageControl class]]) {
        UIPageControl *pageControl = (UIPageControl *)_pageControl;
        pageControl.pageIndicatorTintColor = pageDotColor;
    }
}
#pragma mark - 当前控制点图片
- (void)setCurrentPageDotImage:(UIImage *)currentPageDotImage{
    _currentPageDotImage = currentPageDotImage;
    if (self.pageControlStyle != ZMICarouselPageContolStyleAnimated) {
        self.pageControlStyle = ZMICarouselPageContolStyleAnimated;
    }
    
    [self setCustomPageControlDotImage:currentPageDotImage isCurrentPageDot:YES];
}
#pragma mark - 控制点图片
- (void)setPageDotImage:(UIImage *)pageDotImage{
    _pageDotImage = pageDotImage;
    if (self.pageControlStyle != ZMICarouselPageContolStyleAnimated) {
        self.pageControlStyle = ZMICarouselPageContolStyleAnimated;
    }
    [self setCustomPageControlDotImage:pageDotImage isCurrentPageDot:NO];
}
#pragma mark - 设置控制点图片 - private
- (void)setCustomPageControlDotImage:(UIImage *)image isCurrentPageDot:(BOOL)isCurrentPageDot{
    if (!image || !self.pageControl) return;
    
    if ([self.pageControl isKindOfClass:[TAPageControl class]]) {
        TAPageControl *pageControl = (TAPageControl *)_pageControl;
        if (isCurrentPageDot) {
            pageControl.currentDotImage = image;
        } else {
            pageControl.dotImage = image;
        }
    }
}
#pragma mark - 背景图片遮罩
- (UIView *)blurMaskView{
    if (!_blurMaskView) {
        _blurMaskView = [UIView new];
        _blurMaskView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        [self.blurImageView addSubview:_blurMaskView];
        [_blurMaskView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(0);
        }];
    }
    return _blurMaskView;
}
#pragma mark - 是否显示遮罩
- (void)setShowBgMask:(BOOL)showBgMask{
    if (showBgMask) {
        self.blurMaskView.hidden = NO;
    }else{
        self.blurMaskView.hidden = YES;
    }
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initialization];
    }
    return self;
}

- (void)initialization{
    _pageControlAliment = ZMICarouselPageContolAligmentCenter;
    _autoScrollTimeInterval = 3.0;
    _autoScroll = YES;
    _infiniteLoop = YES;
    _showPageControl = NO;
    _pageControlDotSize = kCycleScrollViewInitialPageControlDotSize;
    _pageControlBottomOffset = 0;
    _pageControlRightOffset = 0;
    _pageControlStyle = ZMICarouselPageContolStyleNormal;
    _hidesForSinglePage = YES;
    _currentPageDotColor = [UIColor redColor];
    _pageDotColor = [UIColor lightGrayColor];
    
    self.backgroundColor = [UIColor lightGrayColor];
}

- (void)setupMainView{
    
    NSString *work = self.imagePathsGroup[0];
    //第一张作品
    //NSString *firstImg = ((ZMWorkModel *)[work.work safeObjectAtIndex:0]).fullUrl;
    self.blurImageView = [[ZMImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self.blurImageView setBlurImageView];
    
    [self.blurImageView setImageWithURL:[NSURL URLWithString:work] placeholder:placeholderFailImage];
    
    [self addSubview:self.blurImageView];
    
    self.carousel = [[iCarousel alloc] initWithFrame:CGRectMake(0, 80 * FIT_HEIGHT, self.frame.size.width, (self.frame.size.height - 80 - 20) * FIT_HEIGHT)];
    self.carousel.type = iCarouselTypeCustom;
    self.carousel.delegate =    self;
    self.carousel.dataSource =  self;
    self.carousel.pagingEnabled = YES;
    //self.carousel.currentItemView.alpha = 1.0f;
    
    [self addSubview:self.carousel];
    
}

+ (instancetype)icarouselViewWithFrame:(CGRect)frame{
    ZMICarouselView *icarousel = [[self alloc] initWithFrame:frame];
    return icarousel;
}

#pragma mark - iCarousel - iCarouselDataSource
- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel{
    if (_dataSourceFlags.numberOfItemsInZMICarouselView) {
        _imagePathsGroup = [self.dataSource numberOfItemsInZMICarouselView];
        return _imagePathsGroup.count;
    }
    return 0;
}

- (UIView *)carousel:(iCarousel * __nonnull)carousel viewForItemAtIndex:(NSInteger)index reusingView:(nullable UIView *)view{
    NSString *work = self.imagePathsGroup[index];
    //NSString *firstImg = ((ZMWorkModel *)[work.work safeObjectAtIndex:0]).fullUrl;
    if (view == nil) {
        view = [[ZMMaskImageView alloc] initWithFrame:CGRectMake(0, 0, 180 * FIT_WIDTH,  carousel.height)];
    }
    ZMMaskImageView *imageView = [[ZMMaskImageView alloc] initWithFrame:CGRectMake(0, 0, 180 * FIT_WIDTH, carousel.height)];
    //imageView.isShowMask = YES;
    [self setupImageWithURL:imageView url:work];
    [self setupViewAlpha];
    [view addSubview:imageView];
    return view;
}
#pragma mark - 设置图片
- (void)setupImageWithURL:(UIImageView *)imageView url:(NSString *)url{
    if (![url isKindOfClass:[NSString class]] || !url.length) return;
    
    if ([url hasPrefix:@"http"]) {
        [imageView setImageWithURL:[NSURL URLWithString:url] placeholder:placeholderFailImage];
    }else{
        imageView.image = [UIImage imageNamed:url];
    }
}
//转动触发方法
- (void)carouselDidEndScrollingAnimation:(iCarousel *)carousel {
    if (self.carousel.scrollOffset == self.imagePathsGroup.count) {
        self.carousel.scrollOffset = self.imagePathsGroup.count - 1;
    }
    NSString *work = self.imagePathsGroup[(NSInteger)self.carousel.scrollOffset];
    //第一张作品
    //NSString *firstImg = ((ZMWorkModel *)[work.work safeObjectAtIndex:0]).fullUrl;
    [self setupImageWithURL:self.blurImageView url:work];
    
}

- (void)carouselDidScroll:(iCarousel *)carousel{
    //NSLog(@"已经转动索引 = %lu",carousel.currentItemIndex);
}

#pragma mark - 设置透明度
- (void)setupViewAlpha{
    UIView *currenView = self.carousel.currentItemView;
    NSArray *visibleItemViews = self.carousel.visibleItemViews;
    for (UIView *view in visibleItemViews) {
        if (![view isKindOfClass:[ZMMaskImageView class]]) continue;
        if ([view isEqual:currenView]) {
            ((ZMMaskImageView *)view).isShowMask = NO;
            
        }else{
            ((ZMMaskImageView *)view).isShowMask = YES;
        }
    }
}
#pragma mark - 已经滚动到下一项
- (void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel{
    [self setupViewAlpha];
    if ([self.pageControl isKindOfClass:[TAPageControl class]]) {
        TAPageControl *pageControl = (TAPageControl *)_pageControl;
        pageControl.currentPage = carousel.currentItemIndex;
    } else {
        UIPageControl *pageControl = (UIPageControl *)_pageControl;
        pageControl.currentPage = carousel.currentItemIndex;
    }
    
    if (_dataSourceFlags.didScrollToIndex) {
        [self.delegate ZMICarouselViews:carousel didScrollToIndex:carousel.currentItemIndex];
    }
    
    NSLog(@"已经改变的索引 %lu",carousel.currentItemIndex);
}

#pragma mark - 当用户自定义时会返回这个代理
-(CATransform3D)carousel:(iCarousel *)carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform{
    static CGFloat max_sacle = 1.0f;
    static CGFloat min_scale = 0.85f;
    if (offset <= 1 && offset >= -1) {
        float tempScale = offset < 0 ? 1+offset : 1-offset;
        float slope = (max_sacle - min_scale) / 1;
        CGFloat scale = min_scale + slope*tempScale;
        transform = CATransform3DScale(transform, scale, scale, 1);
    }else{
        transform = CATransform3DScale(transform, min_scale, min_scale, 1);
    }
    return CATransform3DTranslate(transform, offset * self.carousel.itemWidth * 1.4, 0.0, 0.0);
}
#pragma mark - item 宽度
- (CGFloat)carouselItemWidth:(iCarousel *)carousel{
    return 155;
}
#pragma mark - 可以设置可滑动显示的内容可以循环显示，还可以设置每个元素的高度，每次显示多少个元素
- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value{
    
    switch (option) {
        case iCarouselOptionWrap:
            if (self.infiniteLoop) {
                return YES;
            }
            return NO;
            break;
        case iCarouselOptionSpacing:
            return value * 1.f;
            break;
        default:
            return value * 0.8;
            break;
    }
    
    return YES;
}
#pragma mark - 将要拖拽
- (void)carouselWillBeginDragging:(iCarousel *)carousel{
    NSLog(@"将要拖拽");
    if (self.autoScroll) {
        [self invalidateTimer];
    }
}

#pragma mark - 已经拖拽完毕需要重新初始化定时器
- (void)carouselDidEndDragging:(iCarousel *)carousel willDecelerate:(BOOL)decelerate{
    NSLog(@"结束拖拽");
    if (self.autoScroll) {
        [self setupTimer];
    }
}
#pragma mark - 点击carousel item 回调
- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index{
    if (_dataSourceFlags.didSelectItemAtIndex) {
        [self.delegate ZMICarouselView:carousel didSelectItemAtIndex:index];
    }
}

#pragma mark - 释放定时器
- (void)invalidateTimer{
    [_timer invalidate];
    _timer = nil;
}
#pragma mark - 开启定时器
- (void)setupTimer{
    [self invalidateTimer]; // 创建定时器前先停止定时器，不然会出现僵尸定时器，导致轮播频率错误
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:self.autoScrollTimeInterval target:self selector:@selector(automaticScroll) userInfo:nil repeats:YES];
    _timer = timer;
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}
#pragma mark - 自动滚动到相应位置
- (void)automaticScroll{
    if (0 == _imagePathsGroup.count) return;
    NSInteger currentIndex = self.carousel.currentItemIndex;
    NSInteger targetIndex = currentIndex + 1;
    [self.carousel scrollToItemAtIndex:targetIndex animated:YES];
}

#pragma mark - 初始化圆点控件
- (void)setupPageControl{
    if (_pageControl) [_pageControl removeFromSuperview]; // 重新加载数据时调整
    if (self.imagePathsGroup.count == 0) return;
    if ((self.imagePathsGroup.count == 1) && self.hidesForSinglePage) return;
    NSInteger indexOnPageControl = self.carousel.currentItemIndex;
    switch (self.pageControlStyle) {
        case ZMICarouselPageContolStyleAnimated:
        {
            TAPageControl *pageControl = [[TAPageControl alloc] init];
            pageControl.numberOfPages = self.imagePathsGroup.count;
            pageControl.dotColor = self.currentPageDotColor;
            pageControl.userInteractionEnabled = NO;
            pageControl.currentPage = indexOnPageControl;
            [self addSubview:pageControl];
            [self bringSubviewToFront:pageControl];
            _pageControl = pageControl;
        }
            break;
            
        case ZMICarouselPageContolStyleNormal:
        {
            UIPageControl *pageControl = [[UIPageControl alloc] init];
            pageControl.numberOfPages = self.imagePathsGroup.count;
            pageControl.currentPageIndicatorTintColor = self.currentPageDotColor;
            pageControl.pageIndicatorTintColor = self.pageDotColor;
            pageControl.userInteractionEnabled = NO;
            pageControl.currentPage = indexOnPageControl;
            [self addSubview:pageControl];
            _pageControl = pageControl;
        }
            break;
            
        default:
            break;
    }
    
    // 重设pagecontroldot图片
    if (self.currentPageDotImage) {
        self.currentPageDotImage = self.currentPageDotImage;
    }
    if (self.pageDotImage) {
        self.pageDotImage = self.pageDotImage;
    }
}

#pragma mark - 设置frame
- (void)layoutSubviews{
    [super layoutSubviews];
    if (_imagePathsGroup.count && _carousel) {
        [_carousel scrollToItemAtIndex:0 animated:NO];
    }
    
    CGSize size = CGSizeZero;
    if ([self.pageControl isKindOfClass:[TAPageControl class]]) {
        TAPageControl *pageControl = (TAPageControl *)_pageControl;
        if (!(self.pageDotImage && self.currentPageDotImage && CGSizeEqualToSize(kCycleScrollViewInitialPageControlDotSize, self.pageControlDotSize))) {
            pageControl.dotSize = self.pageControlDotSize;
        }
        size = [pageControl sizeForNumberOfPages:self.imagePathsGroup.count];
    } else {
        size = CGSizeMake(self.imagePathsGroup.count * self.pageControlDotSize.width * 1.5, self.pageControlDotSize.height);
    }
    CGFloat x = (self.frame.size.width - size.width) * 0.5;
    if (self.pageControlAliment == ZMICarouselPageContolAligmentRight) {
        x = self.frame.size.width - size.width - 10;
    }
    CGFloat y = self.frame.size.height - size.height - 10;
    
    if ([self.pageControl isKindOfClass:[TAPageControl class]]) {
        TAPageControl *pageControl = (TAPageControl *)_pageControl;
        [pageControl sizeToFit];
    }
    
    CGRect pageControlFrame = CGRectMake(x, y, size.width, size.height);
    pageControlFrame.origin.y -= self.pageControlBottomOffset;
    pageControlFrame.origin.x -= self.pageControlRightOffset;
    self.pageControl.frame = pageControlFrame;
    self.pageControl.hidden = !_showPageControl;
    [self bringSubviewToFront:self.pageControl];
}
#pragma mark - 解决当timer释放后 回调scrollViewDidScroll时访问野指针导致崩溃
- (void)dealloc {
    NSLog(@"已经释放 = %@",[self class]);
    _carousel.delegate = nil;
    _carousel.dataSource = nil;
}
#pragma mark - 解决当父View释放时，当前视图因为被Timer强引用而不能释放的问题
- (void)willMoveToSuperview:(UIView *)newSuperview{
    if (!newSuperview) {
        [self invalidateTimer];
    }
}

- (void)reloadData{
    if (_carousel) {
        [self.carousel reloadData];
    }
}

@end
