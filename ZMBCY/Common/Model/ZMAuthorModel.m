//
//  ZMAuthorModel.m
//  ZMBCY
//
//  Created by Brance on 2017/11/28.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "ZMAuthorModel.h"

@implementation ZMAuthorModel

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    NSString *suffix = dic[@"portrait"];
    self.portraitFullUrl = [NSString stringWithFormat:@"%@%@%@webp",HttpImageURLPre,suffix,HttpImageURLSuffixScanle(@"80", @"80")];
    return YES;
}

@end
