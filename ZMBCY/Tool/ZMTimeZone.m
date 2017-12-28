//
//  ZMTimeZone.m
//  ZMBCY
//
//  Created by Brance on 2017/12/27.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "ZMTimeZone.h"

@implementation ZMTimeZone

+ (NSString *)getCurrentTimeString:(NSString *)string{
    
    
    // 获取当前时间戳
    NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
    NSTimeInterval time;
    NSInteger result;
    
    if (string.length >= 10) {
        //截取字符串
        result = [[string  substringToIndex:10] integerValue];
        time = currentTime - result;
    }else{
        return @"";
    }
    
    //秒
    NSInteger seconds = time;
    if (seconds < 60) {
        if (seconds <= 0) {
            //有时候会有时间的误差
            seconds = 1;
        }
        return [NSString stringWithFormat:@"%ld%@",seconds,@"秒前"];
    }
    //秒转分钟
    NSInteger minute = time/60;
    if (minute < 60) {
        return [NSString stringWithFormat:@"%ld%@",minute,@"分钟前"];
    }
    
    // 秒转小时
    NSInteger hours = time/3600;
    if (hours<24) {
        return [NSString stringWithFormat:@"%ld%@",hours,@"小时前"];
    }
    //秒转天数
    NSInteger days = time/3600/24;
    if (days < 30) {
        return [NSString stringWithFormat:@"%ld%@",days,@"天前"];
    }
    //格式化日期对象格式
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    //[formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //将要返回的字符串
    NSString *confromTimespStr = [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:result]];
    return confromTimespStr;
}

@end
