//
//  AppDelegate.m
//  ZMBCY
//
//  Created by 卢洋 on 2017/11/23.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+Extend.h"
#import "ZMMainViewController.h"
#import <AVOSCloud/AVOSCloud.h>

@interface AppDelegate ()
@property (nonatomic, strong) ZMMainViewController *mainViewController;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    ZMMainViewController *vc = [[ZMMainViewController alloc] init];
    self.mainViewController = vc;
    self.mainViewController.selectedIndex = 1;
    self.window.rootViewController = vc;
   
    [self customizeInterface];
    
    //启用数据存储模块
    [AVOSCloud setApplicationId:@"NLO5BWz5VCo0I2yI9qbm2cLN-gzGzoHsz" clientKey:@"B5h8sjxK2tTGnCSiVeeNsols"];
    [AVAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    [AVOSCloud setAllLogsEnabled:YES];
    
    //此处加载用户sessionToken
    [[ZMUserInfo shareUserInfo] loadUserInfoFromSandbox];
    
    //根据有无sessionToken去登录
    [self goLogin];
    
    [self.window makeKeyAndVisible];
    return YES;
}

#pragma mark - 根据sessionToken去登录
- (void)goLogin{
    if ([ZMUserInfo shareUserInfo].sessionToken.length) {
        [AVUser becomeWithSessionTokenInBackground:[ZMUserInfo shareUserInfo].sessionToken block:^(AVUser * _Nullable user, NSError * _Nullable error) {
            if (user) {
                //加载用户信息
                NSLog(@"user = %@",user);
                [[ZMUserInfo shareUserInfo] loadUserInfo:user];
                //发送登录成功通知
                [[NSNotificationCenter defaultCenter] postNotificationName:KLoginStateChangeNotice object:nil];
            }
        }];
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
   
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}


- (void)applicationWillTerminate:(UIApplication *)application {
    
}


@end
