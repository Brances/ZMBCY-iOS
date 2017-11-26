//
//  BaseNavigationController.h
//  Timeshutter
//
//  Created by Brance on 2017/11/24.
//  Copyright © 2017年 292692700@qq.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseNavigationController : UINavigationController

@property (nonatomic, assign) UIStatusBarStyle statusBarStyle;

- (void)showNavBottomLine;
- (void)hideNavBottomLine;

@end
