//
//  ZMBaseModel.m
//  ZMBCY
//
//  Created by Brance on 2017/11/24.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "ZMBaseModel.h"

@implementation ZMBaseModel

- (NSString *)dispose:(id)data{
    if (data == nil) {
        return @"";
    }
    return [NSString stringWithFormat:@"%@",data];
}

- (NSArray *)arrDispose:(id)data{
    if ([data isKindOfClass:[NSArray class]]) {
        return data;
    }
    return [NSArray array];
}

- (NSDictionary *)dicDispose:(id)data{
    if ([data isKindOfClass:[NSDictionary class]]) {
        return data;
    }
    return [NSDictionary dictionary];
}

@end

@implementation NSString(ZMJsonConvert)

+ (NSString *)getNowTimeTimestamp{
     NSTimeInterval interval = [[NSDate date] timeIntervalSince1970] * 1000;
    return [NSString stringWithFormat:@"%.0f",interval];
}

- (id)toArrayOrNSDictionary{
    if (![self isKindOfClass:[NSString class]]) {
        NSParameterAssert(@"self is not NSString!");
    }
    NSData *jsonData=[self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData
                                                    options:NSJSONReadingAllowFragments
                                                      error:&error];
    if (jsonObject != nil && error == nil){
        return jsonObject;
    }
    return nil;
}

- (NSString *)componentSeparatedByString:(NSString *)string{
    if (![self isKindOfClass:[NSString class]]) {
        NSParameterAssert(@"self is not NSString!");
    }
    string = [string lowercaseString];
    NSArray *result=[self componentsSeparatedByString:@"."];
    if ([result.lastObject isEqualToString:@"jpeg"]) {
        return @"jpeg";
    }else if ([result.lastObject isEqualToString:@"png"]){
        return @"png";
    }else if ([result.lastObject isEqualToString:@"webp"]){
        return @"webp";
    }
    return @"png";
}

+ (CGFloat)getTitleWidth:(NSString *)title withFontSize:(CGFloat)size{
    return ceil([title sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:size]}].width);
}

+ (NSArray *)getNowMonthAndDay{
    NSString *month,*day;
    //1.获取当月的总天数
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSRange range = [calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:[NSDate date]];
    NSUInteger numberOfDaysInMonth = range.length;
    NSLog(@"%lu", (unsigned long)numberOfDaysInMonth);
    //2.获取当前年份, 月份, 号数
    unsigned unitFlags = NSYearCalendarUnit |NSMonthCalendarUnit |NSDayCalendarUnit;
    NSDateComponents *components = [calendar components:unitFlags fromDate:[NSDate date]];
    NSLog(@"%ld, %ld, %ld", (long)components.year, (long)components.month, (long)components.day);
    day = [NSString stringWithFormat:@"%ld",components.day];
    //根据月份返回英文状态字符串
    switch (components.month) {
        case 1:
            month = @"Jan";
            break;
        case 2:
             month = @"Feb";
            break;
        case 3:
            month = @"Mar";
            break;
        case 4:
            month = @"Apr";
            break;
        case 5:
            month = @"May";
            break;
        case 6:
            month = @"Jun";
            break;
        case 7:
            month = @"Jul";
            break;
        case 8:
            month = @"Aug";
        break;
        case 9:
            month = @"Sep";
            break;
        case 10:
            month = @"Oct";
            break;
        case 11:
            month = @"Nov";
            break;
        default:
            month = @"Dec";
            break;
    }
    
    return @[month,day];
    
}

@end
