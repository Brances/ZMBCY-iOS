//
//  ZMColor.h
//  Zomake
//
//  Created by uzhengxiang on 16/6/12.
//  Copyright © 2016年 ZOMAKE. All rights reserved.
//  颜色

#import <Foundation/Foundation.h>

@interface ZMColor : NSObject


+ (UIColor *)colorWithRed:(CGFloat)red withGreen:(CGFloat)green withBlue:(CGFloat)blue withAlpha:(CGFloat)alpha;

+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

+ (UIColor *)colorWithHexString:(NSString *)color;

+ (UIColor *)clearColor;

+ (UIColor *)whiteColor;

+ (UIColor *)blackColor;


/** app新主题颜色 */
+ (UIColor *)appMainTextColor;

/** 文本灰色 （导航标题颜色） */
+ (UIColor *)appNavTitleGrayColor;

/** 新主题背景蓝色 */
+ (UIColor *)appMainColor;

/** 购物车颜色 */
+ (UIColor *)shopCartRedSpot;

/** 灰色间距 #f4f4f4*/
+ (UIColor *)appGraySpaceColor;

/** 文本灰色 （副标题文本颜色）#333333 */
+ (UIColor *)appSubColor;

/** 辅助颜色  #999999 */
+ (UIColor *)appSupportColor;

/** 设计师标签 #D2D2D2 */
+ (UIColor *)appLightGrayColor;

@end
