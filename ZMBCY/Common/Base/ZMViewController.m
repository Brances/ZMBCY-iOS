//
//  ZMViewController.m
//  ZMBCY
//
//  Created by ZOMAKE on 2017/11/24.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "ZMViewController.h"
#if DEBUG
#import "FLEXManager.h"
#endif


@implementation ZMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //禁止自动布局
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    //设置背景颜色
    self.view.backgroundColor = [UIColor whiteColor];
    //设置状态栏颜色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
}

/** 自定义顶部导航栏 */
- (void)setupNavView{
    
    ZMNavView *navView = [[ZMNavView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64 +KStatusBarHeight)];
    navView.backgroundColor = [ZMColor whiteColor];
    self.navView = navView;
    [self.view addSubview:navView];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
/** 接收到系统的内存警告时 */
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
