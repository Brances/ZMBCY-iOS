//
//  AppDelegate+Extend.m
//  ZMBCY
//
//  Created by Brance on 2017/11/24.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "AppDelegate+Extend.h"

@implementation AppDelegate (Extend)

- (void)customizeInterface{
    //设置Nav的背景色和title色
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    [navigationBarAppearance setBarTintColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]];
    //[navigationBarAppearance setBackgroundImage:[UIImage imageWithColor:[ZMColor appMainColor]] forBarMetrics:UIBarMetricsDefault];
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
    
    
    
//    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
//    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:0/255.0 green:175/255.0 blue:240/255.0 alpha:1]];
//    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
//                                                           [UIColor whiteColor], NSForegroundColorAttributeName, [UIFont systemFontOfSize:21], NSFontAttributeName, nil]];
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
}

@end
