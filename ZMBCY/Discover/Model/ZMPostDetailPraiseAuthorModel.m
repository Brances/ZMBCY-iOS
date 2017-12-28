//
//  ZMPostDetailPraiseAuthorModel.m
//  ZMBCY
//
//  Created by ZOMAKE on 2017/12/28.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "ZMPostDetailPraiseAuthorModel.h"

@implementation ZMPostDetailPraiseAuthorModel

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    NSString *suffix = [self dispose:dic[@"avatarId"]];
    self.avatarFullUrl = [NSString stringWithFormat:@"%@%@%@webp",HttpImageURLPre,suffix,HttpImageURLSuffixScanle(@"80", @"80")];
    return YES;
}

@end
