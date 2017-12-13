//
//  ZMRankViewController.m
//  ZMBCY
//
//  Created by ZOMAKE on 2017/12/13.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "ZMRankViewController.h"

@interface ZMRankViewController ()<SPPageMenuDelegate>

@property (nonatomic, weak) SPPageMenu         *pageMenu;
@property (nonatomic, strong) NSArray          *dataArr;

@end

@implementation ZMRankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI{
    
    self.dataArr = @[@"日榜",@"周榜",@"月榜"];
    SPPageMenu *pageMenu = [SPPageMenu pageMenuWithFrame:CGRectMake(0, 64 + KStatusBarHeight, kScreenWidth, pageMenuH) trackerStyle:SPPageMenuTrackerStyleLineAttachment];
    pageMenu.permutationWay = SPPageMenuPermutationWayNotScrollEqualWidths;
    pageMenu.selectedItemTitleColor =   [ZMColor blackColor];
    pageMenu.unSelectedItemTitleColor = [ZMColor appSupportColor];
    // 传递数组，默认选中第1个
    [pageMenu setItems:self.dataArr selectedItemIndex:0];
    // 设置代理
    pageMenu.delegate = self;
    [self.view addSubview:pageMenu];
    [self.view bringSubviewToFront:pageMenu];
    _pageMenu = pageMenu;
    
}

- (void)pageMenu:(SPPageMenu *)pageMenu itemSelectedAtIndex:(NSInteger)index {
    NSLog(@"%zd",index);
    //[self setupView:index];
}

- (void)pageMenu:(SPPageMenu *)pageMenu itemSelectedFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
