//
//  ZMWorksModel.m
//  ZMBCY
//
//  Created by ZOMAKE on 2017/12/5.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "ZMWorksModel.h"

@implementation ZMWorksModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"work" : [ZMWorkModel class]
            };
}

@end
