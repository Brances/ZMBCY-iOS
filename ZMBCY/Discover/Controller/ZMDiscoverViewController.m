//
//  ZMDiscoverViewController.m
//  ZMBCY
//
//  Created by Brance on 2017/11/24.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "ZMDiscoverViewController.h"
#import "SPPageMenu.h"
#import "ViewController.h"
#import "ZMDiscoverRecommendView.h"


#define pageMenuH 40
#define NaviH (kScreenHeight == 812 ? 88 : 64) // 812是iPhoneX的高度

@interface ZMDiscoverViewController ()<SPPageMenuDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) NSArray          *dataArr;
@property (nonatomic, weak) SPPageMenu         *pageMenu;
@property (nonatomic, weak) UIScrollView       *scrollView;
@property (nonatomic, strong) NSMutableArray   *myChildViewControllers;



@end

@implementation ZMDiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"发现";
    [self setupMenu];
}

- (void)setupMenu{
    self.dataArr = @[@"推荐",@"插画",@"文章",@"COS"];
    // trackerStyle:跟踪器的样式
    SPPageMenu *pageMenu = [SPPageMenu pageMenuWithFrame:CGRectMake(0, 64 + KStatusBarHeight, kScreenWidth, pageMenuH) trackerStyle:SPPageMenuTrackerStyleLineAttachment];
    pageMenu.permutationWay = SPPageMenuPermutationWayNotScrollEqualWidths;
    pageMenu.selectedItemTitleColor =   [ZMColor appMainColor];
    pageMenu.unSelectedItemTitleColor = [ZMColor appSupportColor];
    // 传递数组，默认选中第1个
    [pageMenu setItems:self.dataArr selectedItemIndex:0];
    // 设置代理
    pageMenu.delegate = self;
    [self.view addSubview:pageMenu];
    _pageMenu = pageMenu;
    
    for (NSInteger index = 0; index < self.dataArr.count; index++) {
        [self.myChildViewControllers addObject:@1];
    }
    
    //滚动容器
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NaviH+pageMenuH, kScreenWidth, kScreenHeight - NaviH - pageMenuH - self.tabBarController.tabBar.height)];
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    _scrollView = scrollView;
    
    // 这一行赋值，可实现pageMenu的跟踪器时刻跟随scrollView滑动的效果
    self.pageMenu.bridgeScrollView = self.scrollView;
    
    scrollView.contentOffset = CGPointMake(kScreenWidth * self.pageMenu.selectedItemIndex, 0);
    scrollView.contentSize = CGSizeMake(self.dataArr.count * kScreenWidth, 0);
    // pageMenu.selectedItemIndex就是选中的item下标 选中下标
    [self setupView:self.pageMenu.selectedItemIndex];
}

- (void)pageMenu:(SPPageMenu *)pageMenu itemSelectedAtIndex:(NSInteger)index {
    NSLog(@"%zd",index);
    [self setupView:index];
}

- (void)pageMenu:(SPPageMenu *)pageMenu itemSelectedFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    
    NSLog(@"%zd------->%zd",fromIndex,toIndex);
    // 如果fromIndex与toIndex之差大于等于2,说明跨界面移动了,此时不动画.
    if (labs(toIndex - fromIndex) >= 2) {
        [self.scrollView setContentOffset:CGPointMake(kScreenWidth * toIndex, 0) animated:NO];
    } else {
        [self.scrollView setContentOffset:CGPointMake(kScreenWidth * toIndex, 0) animated:YES];
    }
    if (self.myChildViewControllers.count <= toIndex) {return;}
    
    //获取索引对应的视图
    [self setupView:toIndex];
}

- (NSMutableArray *)myChildViewControllers {
    if (!_myChildViewControllers) {
        _myChildViewControllers = [NSMutableArray array];
    }
    return _myChildViewControllers;
}

#pragma mark - 初始化视图
- (void)setupView:(NSInteger)index{
    id table = [self.myChildViewControllers safeObjectAtIndex:index];
    if ([table isKindOfClass:[UIView class]]) {
        return;
    }
    ZMDiscoverRecommendView *view = [[ZMDiscoverRecommendView alloc] initWithFrame:CGRectMake(kScreenWidth * index, 0, kScreenWidth, self.scrollView.height)];
    [self.scrollView addSubview:view];
    //将当前视图存到数组中
    [self.myChildViewControllers replaceObjectAtIndex:index withObject:view];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
