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
    
//    AVObject *testObject = [AVObject objectWithClassName:@"TestObject"];
//    [testObject setObject:@"bar" forKey:@"foo"];
//    [testObject save];
    
    
    
    
    [self.window makeKeyAndVisible];
    return YES;
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
