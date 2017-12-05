//
//  ZMImageView.h
//  ZMBCY
//
//  Created by Brance on 2017/11/28.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMImageView : UIImageView

/** 加载图片的方式 不把这个图片加载到内存中 */
@property (nonatomic,assign) BOOL turnOffSetLayer;

- (void)setProgressAnimationStyle:(BOOL)isProgressLayer;

- (void)setAnimationLoadingImage:(NSURL *)url placeholder:(UIImage *)placeholder;

- (void)setBlurImageView;

@end

@interface ZMMaskImageView : UIImageView

@property (nonatomic, assign) BOOL isShowMask;
@property (nonatomic, strong) UIView  *maskView;

@end
