//
//  ZMColor.m
//  
//
//  Created by Brance on 17/11/24.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "ZMColor.h"

@implementation ZMColor

+ (UIColor *)colorWithRed:(CGFloat)red withGreen:(CGFloat)green withBlue:(CGFloat)blue withAlpha:(CGFloat)alpha{
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:alpha];
}

+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha{
    //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6)
    {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6)
    {
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}

//默认alpha值为1
+ (UIColor *)colorWithHexString:(NSString *)color{
    return [self colorWithHexString:color alpha:1.0f];
}

+ (UIColor *)clearColor{
    return [UIColor clearColor];
}

+ (UIColor *)whiteColor{
    return [UIColor whiteColor];
}

+ (UIColor *)blackColor{
    return [UIColor blackColor];
}

+ (UIColor *)appMainColor{
    return [self colorWithHexString:@"#00DA8C"];
}

+ (UIColor *)appNavTitleGrayColor{
    return [UIColor colorWithRed:113/255.0 green:113/255.0 blue:113/255.0 alpha:1];
}

+ (UIColor *)appGraySpaceColor{
    return [self colorWithHexString:@"#f4f4f4" alpha:1.0f];
}

+ (UIColor *)appSubColor{
    return [self colorWithHexString:@"#333333" alpha:1.0f];
}
+ (UIColor *)appSupportColor{
    return [self colorWithHexString:@"#999999" alpha:1.0f];
}
+ (UIColor *)appLightGrayColor{
    return [self colorWithHexString:@"#D2D2D2" alpha:1.0f];
}
+ (UIColor *)appSubBlueColor{
    return [self colorWithHexString:@"#7EC1FB" alpha:1.0f];
}
+ (UIColor *)appBottomLineColor{
    return [self colorWithHexString:@"#DCDCDC" alpha:1.0f];
}

@end
