//
//  UIView+extension.m
//  Demo-CustomView
//
//  Created by uzhengxiang on 15/8/31.
//  Copyright (c) 2015年 zizaochuangpin. All rights reserved.
//

#import "UIView+extension.h"
#import <objc/runtime.h>


@implementation UIView (extension)

- (void)setX:(CGFloat)x{
    
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
    
}

- (void)setY:(CGFloat)y{
    
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
    
}

- (void)setWidth:(CGFloat)width{
    
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
    
}

- (void)setHeight:(CGFloat)height{

    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
    
}

- (void)setSize:(CGSize)size{
    
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
    
}

- (void)setPoint:(CGPoint)point{
    
    CGRect frame = self.frame;
    frame.origin = point;
    self.frame = frame;
    
}

- (CGSize)size{
    return self.frame.size;
}

- (CGPoint)point{
    return self.frame.origin;
}

- (CGFloat)x{
    
    return self.frame.origin.x;
    
}

- (CGFloat)y{

    return self.frame.origin.y;

}

- (CGFloat)width{
    
    return self.frame.size.width;
    
}

- (CGFloat)height{

    return self.frame.size.height;
    
}

- (void)setCenterX:(CGFloat)centerX{
    
    CGPoint center = self.center;
    
    center.x = centerX;
    
    self.center = center;
    
}

- (void)setCenterY:(CGFloat)centerY{
    
    CGPoint center = self.center;
    
    center.y = centerY;
    
    self.center = center;
}

- (CGFloat)centerX{
    return self.center.x;
}

- (CGFloat)centerY{
    return self.center.y;
}
NSString * const _recognizerScale = @"_recognizerScale";
- (void)setScale:(CGFloat)scale {
    
    objc_setAssociatedObject(self, (__bridge const void *)(_recognizerScale), @(scale), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.transform = CGAffineTransformMakeScale(scale, scale);
}

- (CGFloat)scale {
    
    NSNumber *scaleValue = objc_getAssociatedObject(self, (__bridge const void *)(_recognizerScale));
    return scaleValue.floatValue;
}

#pragma mark - Angle.

NSString * const _recognizerAngle = @"_recognizerAngle";

- (void)setAngle:(CGFloat)angle {
    
    objc_setAssociatedObject(self, (__bridge const void *)(_recognizerAngle), @(angle), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.transform = CGAffineTransformMakeRotation(angle);
}

- (CGFloat)angle {
    
    NSNumber *angleValue = objc_getAssociatedObject(self, (__bridge const void *)(_recognizerAngle));
    return angleValue.floatValue;
}

@end
