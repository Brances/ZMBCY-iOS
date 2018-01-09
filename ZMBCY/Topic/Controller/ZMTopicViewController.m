//
//  ZMTopicViewController.m
//  ZMBCY
//
//  Created by Brance on 2017/11/24.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "ZMTopicViewController.h"

@interface ZMTopicViewController ()

@end

@implementation ZMTopicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavView];
}

- (void)setupNavView{
    [super setupNavView];
    [self.navView.centerButton setTitle:@"话题" forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
