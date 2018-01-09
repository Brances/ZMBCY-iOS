//
//  ZMProfileViewController.m
//  ZMBCY
//
//  Created by ZOMAKE on 2018/1/8.
//  Copyright © 2018年 Brance. All rights reserved.
//

#import "ZMProfileViewController.h"
#import "ZMProfileView.h"

@interface ZMProfileViewController ()

@property (nonatomic, strong) ZMProfileView       *mainView;

@end

@implementation ZMProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavView];
    [self setupMainView];
}

- (void)setupNavView{
    [super setupNavView];
    [self.navView.leftButton setImage:backArrowIcon forState:UIControlStateNormal];
    [self.navView.centerButton setTitle:@"个人资料" forState:UIControlStateNormal];
}

- (void)setupMainView{
    self.mainView = [[ZMProfileView alloc] initWithFrame:CGRectMake(0, self.navView.height, kScreenWidth, kScreenHeight - self.navView.height)];
    [self.view addSubview:self.mainView];
    [self.view insertSubview:self.mainView belowSubview:self.navView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
