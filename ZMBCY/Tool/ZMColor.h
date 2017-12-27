//
//  ZMColor.h
//  
//
//  Created by Brance on 17/11/24.
//  Copyright © 2017年 Brance. All rights reserved.
//  颜色

#import <Foundation/Foundation.h>

@interface ZMColor : NSObject


+ (UIColor *)colorWithRed:(CGFloat)red withGreen:(CGFloat)green withBlue:(CGFloat)blue withAlpha:(CGFloat)alpha;

+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

+ (UIColor *)colorWithHexString:(NSString *)color;

+ (UIColor *)clearColor;

+ (UIColor *)whiteColor;

+ (UIColor *)blackColor;


/** app主题颜色 */
+ (UIColor *)appMainColor;

/** 文本灰色 （导航标题颜色） */
+ (UIColor *)appNavTitleGrayColor;

/** 灰色间距 #f4f4f4*/
+ (UIColor *)appGraySpaceColor;

/** 文本灰色 （副标题文本颜色）#333333 */
+ (UIColor *)appSubColor;

/** 辅助颜色  #999999 */
+ (UIColor *)appSupportColor;

/** 设计师标签 #D2D2D2 */
+ (UIColor *)appLightGrayColor;

/** 辅助蓝色 #7EC1FB */
+ (UIColor *)appSubBlueColor;

/** 分割线颜色 #DCDCDC */
+ (UIColor *)appBottomLineColor;

@end
