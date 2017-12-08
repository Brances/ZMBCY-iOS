//
//  LPLoadFailedView.h
//  LovePlayNews
//
//  Created by tany on 16/8/30.
//  Copyright © 2016年 tany. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMLoadFailedView : UIView

@property (nonatomic, strong) UIImageView    *failedImage;
@property (nonatomic, strong) UIButton       *refreshButton;

@property (nonatomic, assign) UIEdgeInsets edgeInset;

@property (nonatomic, copy) void (^retryHandle)(void);

+ (void)showLoadFailedInView:(UIView *)view;

+ (void)showLoadFailedInView:(UIView *)view retryHandle: (void (^)(void))retryHandle;

+ (void)showLoadFailedInView:(UIView *)view edgeInset:(UIEdgeInsets)edgeInset;
+ (void)showLoadFailedInView:(UIView *)view edgeInset:(UIEdgeInsets)edgeInset retryHandle: (void (^)(void))retryHandle;

+ (void)hideLoadFailedForView:(UIView *)view;

+ (ZMLoadFailedView *)loadFailedForView:(UIView *)view;

+ (void)showLoadFailedInView:(UIView *)view topEdge:(CGFloat)topEdge retryHandle: (void (^)(void))retryHandle;

- (void)showInView:(UIView *)view;

- (void)hide;

@end
