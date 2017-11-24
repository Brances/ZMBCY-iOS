//
//  AppDelegate+Extend.m
//  ZMBCY
//
//  Created by ZOMAKE on 2017/11/24.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "AppDelegate+Extend.h"

@implementation AppDelegate (Extend)

- (void)customizeInterface{
    //设置Nav的背景色和title色
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    [navigationBarAppearance setBackgroundImage:[UIImage imageWithColor:[ZMColor clearColor]] forBarMetrics:UIBarMetricsDefault];
    [navigationBarAppearance setTintColor:[ZMColor blackColor]];//返回按钮的箭头颜色
    NSDictionary *textAttributes = @{
                                     NSFontAttributeName: [UIFont systemFontOfSize:18],
                                     NSForegroundColorAttributeName: [ZMColor blackColor],
                                     };
    [navigationBarAppearance setTitleTextAttributes:textAttributes];
    //底部TabBar 样式
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
    [[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];
    [[UITabBar appearance] setShadowImage:[UIImage imageWithColor:[ZMColor colorWithHexString:@"0xf5f5f5"]]];
}

@end
