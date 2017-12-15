//
//  NSString+ZMNSString.h
//  ZMBCY
//
//  Created by Brance on 2017/12/14.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ZMNSString)

#pragma mark - 获取当前时间戳
+ (NSString *)getNowTimeTimestamp;
#pragma mark - 计算文字宽度
+ (CGFloat)getTitleWidth:(NSString *)title withFontSize:(CGFloat)size;
#pragma mark - 根据当前日期返回几月🐔日
+ (NSArray *)getNowMonthAndDay;
#pragma mark - 讲json字符串转为字典或数组
- (id)toArrayOrNSDictionary;
#pragma mark - 返回图片格式
- (NSString *)componentSeparatedByString:(NSString *)string;

@end
