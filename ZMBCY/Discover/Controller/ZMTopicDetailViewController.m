//
//  ZMTopicDetailViewController.m
//  ZMBCY
//
//  Created by ZOMAKE on 2017/12/18.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "ZMTopicDetailViewController.h"
#import "ZMTopicDetailView.h"

@interface ZMTopicDetailViewController ()

@property (nonatomic, strong) ZMTopicDetailView   *mainView;

@end

@implementation ZMTopicDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI{
    [self setupNavView];
    self.mainView = [[ZMTopicDetailView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.mainView.nav = self.navView;
    self.mainView.uid = self.uid;
    [self.view insertSubview:self.mainView belowSubview:self.navView];
}

- (void)setupNavView{
    [super setupNavView];
    self.navView.backgroundColor = [ZMColor clearColor];
    self.navView.showBottomLabel = NO;
    [self.navView.leftButton setImage:backArrowWhiteIcon forState:UIControlStateNormal];
    [self.navView.rightButton setImage:[UIImage imageNamed:@"myCollection_share~iphone"] forState:UIControlStateNormal];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
