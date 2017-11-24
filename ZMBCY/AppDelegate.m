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
    [self.window makeKeyAndVisible];
    [self customizeInterface];
    
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
