//
//  UIView+extension.h
//  Demo-CustomView
//
//  Created by Brance on 17/8/31.
//  Copyright (c) 2017年 zizaochuangpin. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CanvasX 50.0
#define CanvasY 50.0
#define CanvasWidth 200
#define CanvasHeight 200
@interface UIView (extension)

@property (nonatomic, assign) CGFloat x;

@property (nonatomic, assign) CGFloat y;

@property (nonatomic, assign) CGFloat width;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGSize size;

@property (nonatomic, assign) CGPoint point;

@property (nonatomic, assign) CGFloat centerX;

@property (nonatomic, assign) CGFloat centerY;

/**
 *  CGAffineTransformMakeScale
 */
@property (nonatomic) CGFloat  scale;

/**
 *  CGAffineTransformMakeRotation
 */
@property (nonatomic) CGFloat  angle;

@end
