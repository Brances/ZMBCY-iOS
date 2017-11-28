//
//  ZMHotRecommendModel.m
//  ZMBCY
//
//  Created by Brance on 2017/11/28.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "ZMHotRecommendModel.h"

@implementation ZMHotRecommendModel

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    NSString *suffix = dic[@"imgId"];
    if (![suffix isKindOfClass:[NSString class]]) return NO;
    self.imageSuffix = [suffix componentSeparatedByString:suffix];
    if (self.width && self.height) {
        //实际宽度
        self.realWidth = (kScreenWidth - 2)/2.0;
        if ((self.height * self.realWidth / self.width) > 400) {
            self.realHeight = 400;
        }else{
            self.realHeight = self.height * self.realWidth / self.width;
        }
    }
    return YES;
}

@end
