//
//  ZMCircleModel.m
//  ZMBCY
//
//  Created by Brance on 2017/11/28.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "ZMCircleModel.h"

@implementation ZMCircleModel

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    NSString *suffix = dic[@"circlePic"];
    if (![suffix isKindOfClass:[NSString class]]) return NO;
    self.imageSuffix = [suffix componentSeparatedByString:suffix];
    return YES;
}

@end
