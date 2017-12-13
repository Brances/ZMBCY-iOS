//
//  ZMBaseModel.h
//  ZMBCY
//
//  Created by Brance on 2017/11/24.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 数据类型，决定CELL的布局 */
typedef NS_ENUM(NSInteger,itemStyle){
    itemStyleDouble = 0, //(post)
    itemStyleSingle
};

typedef NS_ENUM(NSInteger,pageViewType){
    pageViewTypeInset = 0,
    pageViewTypeCos
};

@interface ZMBaseModel : NSObject

- (NSString *)dispose:(id)data;
- (NSArray *)arrDispose:(id)data;
- (NSDictionary *)dicDispose:(id)data;

@end

@interface NSString (ZMJsonConvert)
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
