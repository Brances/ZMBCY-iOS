//
//  ZMViewController.m
//  ZMBCY
//
//  Created by Brance on 2017/11/24.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "ZMViewController.h"
#import "ZMNavView.h"

#if DEBUG
#import "FLEXManager.h"
#endif

@implementation ZMViewController

-(ZMNavView *)navView{
    if (!_navView) {
        ZMNavView *navView = [[ZMNavView alloc] init];
        [self.view addSubview:navView];
        navView.backgroundColor = [ZMColor whiteColor];
        self.navView = navView;
        [self.navView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(0);
            make.height.mas_equalTo(64 + KStatusBarHeight);
        }];
        [self.navView.superview layoutIfNeeded];
    }
    return _navView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //禁止自动布局
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    //设置背景颜色
    self.view.backgroundColor = [UIColor whiteColor];
    //隐藏自带的导航栏
    self.navigationController.navigationBar.hidden = YES;
}
#pragma mark - 加载自定义导航
- (void)setupNavView{
    [self navView];
}

#pragma mark - 接收到系统的内存警告时
- (void)didReceiveMemoryWarning{
    
    [super didReceiveMemoryWarning];
    /**
     *  YYWebImage 清除缓存
     */
    [[YYImageCache sharedCache].memoryCache removeAllObjects];
    
    /**
     *  UIWebView 清除缓存
     */
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    
    /**
     *  SDWebImage 清除缓存
     */
    [[SDImageCache sharedImageCache] clearMemory];
    
}
#if DEBUG
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    [super motionBegan:motion withEvent:event];
    if (motion == UIEventSubtypeMotionShake) {
        NSLog(@"开始摇一摇");
        [[FLEXManager sharedManager] toggleExplorer];
    }
}
#endif


@end
