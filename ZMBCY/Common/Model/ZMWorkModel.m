//
//  ZMWorkModel.m
//  ZMBCY
//
//  Created by ZOMAKE on 2017/12/5.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "ZMWorkModel.h"

@implementation ZMWorkModel

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    NSString *suffix = dic[@"imgId"];
    self.fullUrl = [NSString stringWithFormat:@"%@%@%@webp",HttpImageURLPre,suffix,HttpImageURLSuffixScanle(@"375", @"500")];
    return YES;
}

@end
