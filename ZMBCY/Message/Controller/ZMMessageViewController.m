//
//  ZMMessageViewController.m
//  ZMBCY
//
//  Created by Brance on 2017/11/24.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "ZMMessageViewController.h"
#import "ZMMessageView.h"

@interface ZMMessageViewController ()

@property (nonatomic, strong) ZMMessageView     *mainView;

@end

@implementation ZMMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavView];
    [self setupMainView];
}

- (void)setupNavView{
    [super setupNavView];
    [self.navView.centerButton setTitle:@"消息" forState:UIControlStateNormal];
}

- (void)setupMainView{
    self.mainView = [[ZMMessageView alloc] initWithFrame:CGRectMake(0, self.navView.height, kScreenWidth, kScreenHeight - KTabBarHeight - self.navView.height)];
    [self.view addSubview:self.mainView];
    [self.view insertSubview:self.mainView belowSubview:self.navView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
