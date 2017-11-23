//
//  BaseNavigationController.h
//  Timeshutter
//
//  Created by ZOMAKE on 2017/5/4.
//  Copyright © 2017年 292692700@qq.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseNavigationController : UINavigationController

@property (nonatomic, assign) UIStatusBarStyle statusBarStyle;

- (void)showNavBottomLine;
- (void)hideNavBottomLine;

@end
