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

@end
