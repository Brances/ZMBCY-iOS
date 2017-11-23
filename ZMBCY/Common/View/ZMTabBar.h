//
//  ZMTabBar.h
//  Zomake
//
//  Created by uzhengxiang on 16/6/20.
//  Copyright © 2016年 ZOMAKE. All rights reserved.
//  暂时没用到

#import <UIKit/UIKit.h>

@class ZMTabBar;

@protocol ZMTabBarDelegate <UITabBarDelegate>

@optional

- (void)tabBarDidClickPlusButton:(ZMTabBar *)tabBar;

@end

@interface ZMTabBar : UITabBar

@property (nonatomic, weak) id<ZMTabBarDelegate> delegates;

@end
