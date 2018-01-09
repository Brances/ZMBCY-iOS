//
//  ZMRegisterViewController.m
//  ZMBCY
//
//  Created by ZOMAKE on 2018/1/6.
//  Copyright © 2018年 Brance. All rights reserved.
//

#import "ZMRegisterViewController.h"
#import "ZMRegisterView.h"

@interface ZMRegisterViewController ()

@property (nonatomic, strong) ZMRegisterView        *mainView;

@end

@implementation ZMRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupMainView];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)setupMainView{
    self.mainView = [[ZMRegisterView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.mainView];
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.mas_equalTo(0+KStatusBarHeight);
    }];
    [self.mainView.superview layoutIfNeeded];
    [self.mainView setupUI];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
