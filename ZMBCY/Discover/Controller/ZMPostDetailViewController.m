//
//  ZMPostDetailViewController.m
//  ZMBCY
//
//  Created by ZOMAKE on 2017/12/26.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "ZMPostDetailViewController.h"
#import "ZMPostDetailView.h"

@interface ZMPostDetailViewController ()

@property (nonatomic, strong) ZMPostDetailView      *mainView;

@end

@implementation ZMPostDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavView];
    [self setupMainView];
}

- (void)setupNavView{
    [super setupNavView];
    [self.navView.leftButton setImage:backArrowIcon forState:UIControlStateNormal];
    [self.navView.rightButton setImage:[UIImage imageNamed:@"postDetail_share_h~iphone"] forState:UIControlStateNormal];
}

- (void)setupMainView{
    self.mainView = [[ZMPostDetailView alloc] initWithFrame:CGRectZero];
    [self.view insertSubview:self.mainView belowSubview:self.navView];
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.navView.mas_bottom).with.offset(0);
        make.bottom.mas_equalTo(self.view.mas_bottom).with.offset(-KTabBarHeight);
    }];
    [self.mainView.superview layoutIfNeeded];
    self.mainView.postId = self.postId;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
