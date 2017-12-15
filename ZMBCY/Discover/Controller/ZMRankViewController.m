//
//  ZMRankViewController.m
//  ZMBCY
//
//  Created by Brance on 2017/12/13.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "ZMRankViewController.h"
#import "ZMRankView.h"

@interface ZMRankViewController ()<SPPageMenuDelegate,UIScrollViewDelegate>

@property (nonatomic, weak) SPPageMenu         *pageMenu;
@property (nonatomic, strong) NSArray          *dataArray;
@property (nonatomic, weak) UIScrollView       *scrollView;
@property (nonatomic, strong) NSMutableArray   *rankViewControllers;

@end

@implementation ZMRankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"排行榜";
    self.rankViewControllers = [NSMutableArray new];
    [self setupUI];
}

- (void)setupUI{
    
    self.dataArray = @[@"日榜",@"周榜",@"月榜"];
    SPPageMenu *pageMenu = [SPPageMenu pageMenuWithFrame:CGRectMake(0, 64 + KStatusBarHeight, kScreenWidth, pageMenuH) trackerStyle:SPPageMenuTrackerStyleLineAttachment];
    pageMenu.permutationWay = SPPageMenuPermutationWayNotScrollEqualWidths;
    pageMenu.selectedItemTitleColor =   [ZMColor blackColor];
    pageMenu.unSelectedItemTitleColor = [ZMColor appSupportColor];
    // 传递数组，默认选中第1个
    [pageMenu setItems:self.dataArray selectedItemIndex:0];
    // 设置代理
    pageMenu.delegate = self;
    [self.view addSubview:pageMenu];
    [self.view bringSubviewToFront:pageMenu];
    _pageMenu = pageMenu;
    
    for (NSInteger index = 0; index < self.dataArray.count; index++) {
        [self.rankViewControllers addObject:@1];
    }
    
    //滚动容器
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NaviH+pageMenuH, kScreenWidth, kScreenHeight - NaviH - pageMenuH)];
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.scrollsToTop = NO;
    [self.view addSubview:scrollView];
    
    [self.view sendSubviewToBack:scrollView];
    _scrollView = scrollView;
    
    // 这一行赋值，可实现pageMenu的跟踪器时刻跟随scrollView滑动的效果
    self.pageMenu.bridgeScrollView = self.scrollView;
    
    scrollView.contentOffset = CGPointMake(kScreenWidth * self.pageMenu.selectedItemIndex, 0);
    scrollView.contentSize = CGSizeMake(self.dataArray.count * kScreenWidth, 0);
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
    if (self.rankViewControllers.count <= toIndex) return;
    
    //获取索引对应的视图
    [self setupView:toIndex];
}

#pragma mark - 初始化视图
- (void)setupView:(NSInteger)index{
    id table = [self.rankViewControllers safeObjectAtIndex:index];
    if ([table isKindOfClass:[UIView class]]) {
        return;
    }
    
    switch (index) {
        case 0:
        {
            ZMRankView *view = [[ZMRankView alloc] initWithFrame:CGRectMake(kScreenWidth * index, 0, kScreenWidth, self.scrollView.height)];
            view.backgroundColor = [UIColor redColor];
            view.trendType = trendTypeDay;
            [self.scrollView addSubview:view];
            //将当前视图存到数组中
            [self.rankViewControllers replaceObjectAtIndex:index withObject:view];
        }
            break;
        case 1:
        {
            ZMRankView *view = [[ZMRankView alloc] initWithFrame:CGRectMake(kScreenWidth * index, 0, kScreenWidth, self.scrollView.height)];
            view.backgroundColor = [UIColor blueColor];
            view.trendType = trendTypeWeek;
            [self.scrollView addSubview:view];
            //将当前视图存到数组中
            [self.rankViewControllers replaceObjectAtIndex:index withObject:view];
        }
            break;
        case 2:
        {
            ZMRankView *view = [[ZMRankView alloc] initWithFrame:CGRectMake(kScreenWidth * index, 0, kScreenWidth, self.scrollView.height)];
            view.trendType = trendTypeMonth;
            view.backgroundColor = [UIColor grayColor];
            [self.scrollView addSubview:view];
            //将当前视图存到数组中
            [self.rankViewControllers replaceObjectAtIndex:index withObject:view];
        }
            break;
        default:
            break;
    }
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
