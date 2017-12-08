//
//  LPLoadingView.h
//  LovePlayNews
//
//  Created by tany on 16/8/24.
//  Copyright © 2016年 tany. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMLoadingView : UIView

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, assign) UIEdgeInsets edgeInset;

// 便利方法

+ (void)showLoadingInView:(UIView *)view;

+ (void)showLoadingInView:(UIView *)view edgeInset:(UIEdgeInsets)edgeInset;

+ (void)hideLoadingForView:(UIView *)view;

+ (void)hideAllLoadingForView:(UIView *)view;

+ (ZMLoadingView *)loadingForView:(UIView *)view;

+ (void)showLoadingInView:(UIView *)view topEdge:(CGFloat)topEdge;


- (void)showInView:(UIView *)view;

- (void)hide;

@end
