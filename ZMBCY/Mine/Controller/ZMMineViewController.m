//
//  ZMMineViewController.m
//  ZMBCY
//
//  Created by Brance on 2017/11/24.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "ZMMineViewController.h"
#import "ZMMineView.h"
#import "ZMSetupViewController.h"

@interface ZMMineViewController ()

@property (nonatomic, strong) ZMMineView  *mainView;

@end

@implementation ZMMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavView];
    [self setupMainView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)setupNavView{
    [super setupNavView];
    self.navView.backgroundColor = [ZMColor clearColor];
    self.navView.showBottomLabel = NO;
    [self.navView.rightButton setImage:[UIImage imageNamed:@"personal_setting"] forState:UIControlStateNormal];
    [self.navView.rightButton addTarget:self action:@selector(clickSetup) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setupMainView{
    self.mainView = [[ZMMineView alloc] initWithFrame:CGRectMake(0, 0 + KStatusBarHeight, kScreenWidth, kScreenHeight - KTabBarHeight)];
    [self.view addSubview:self.mainView];
    [self.view insertSubview:self.mainView belowSubview:self.navView];
}

#pragma mark - 设置
- (void)clickSetup{
    ZMSetupViewController *vc = [[ZMSetupViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
