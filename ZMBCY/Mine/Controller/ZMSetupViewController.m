//
//  ZMSetupViewController.m
//  ZMBCY
//
//  Created by ZOMAKE on 2018/1/8.
//  Copyright © 2018年 Brance. All rights reserved.
//

#import "ZMSetupViewController.h"
#import "ZMSetupView.h"

@interface ZMSetupViewController ()

@property (nonatomic, strong) ZMSetupView       *mainView;

@end

@implementation ZMSetupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavView];
    [self setupMainView];
}

- (void)setupNavView{
    [super setupNavView];
    [self.navView.leftButton setImage:backArrowIcon forState:UIControlStateNormal];
    [self.navView.centerButton setTitle:@"设置" forState:UIControlStateNormal];
}

- (void)setupMainView{
    self.mainView = [[ZMSetupView alloc] initWithFrame:CGRectMake(0, self.navView.height, kScreenWidth, kScreenHeight - self.navView.height)];
    [self.view addSubview:self.mainView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
