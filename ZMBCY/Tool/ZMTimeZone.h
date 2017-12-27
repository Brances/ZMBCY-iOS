//
//  ZMTimeZone.h
//  ZMBCY
//
//  Created by ZOMAKE on 2017/12/27.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZMTimeZone : NSObject

/**
 *  根据时间戳字符串返回时间
 */
+ (NSString *)getCurrentTimeString:(NSString *)string;

@end
