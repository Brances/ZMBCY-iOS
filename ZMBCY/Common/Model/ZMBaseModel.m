//
//  ZMBaseModel.m
//  ZMBCY
//
//  Created by ZOMAKE on 2017/11/24.
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
