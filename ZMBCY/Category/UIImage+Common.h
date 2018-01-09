//
//  UIImage+Common.h
//  Zomake
//
//  Created by ZOMAKE on 2018/01/08.
//  Copyright © 2018年 ZOMAKE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Common)

+(UIImage *)imageWithColor:(UIColor *)aColor;
+(UIImage *)imageWithColor:(UIColor *)aColor withFrame:(CGRect)aFrame;
-(UIImage*)scaledToSize:(CGSize)targetSize;
-(UIImage*)scaledToSize:(CGSize)targetSize highQuality:(BOOL)highQuality;
+ (UIImage *)fixOrientation:(UIImage *)aImage;
+ (UIImage *) imageCompressFitSizeScale:(UIImage *)sourceImage targetSize:(CGSize)size;

@end
