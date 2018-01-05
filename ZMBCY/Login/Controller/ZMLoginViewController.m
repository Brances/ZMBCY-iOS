//
//  ZMLoginViewController.m
//  ZMBCY
//
//  Created by ZOMAKE on 2018/1/5.
//  Copyright © 2018年 Brance. All rights reserved.
//

#import "ZMLoginViewController.h"
#import "ZMLoginView.h"

@interface ZMLoginViewController ()

@property (nonatomic, strong) ZMLoginView       *loginView;

@end

@implementation ZMLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupMainView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)setupMainView{
    self.loginView = [[ZMLoginView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.loginView];
    [self.loginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.mas_equalTo(0+KStatusBarHeight);
    }];
    [self.loginView.superview layoutIfNeeded];
    [self.loginView setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
