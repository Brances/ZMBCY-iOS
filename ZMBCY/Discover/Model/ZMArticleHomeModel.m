//
//  ZMArticleHomeModel.m
//  ZMBCY
//
//  Created by ZOMAKE on 2017/12/7.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "ZMArticleHomeModel.h"

@implementation ZMArticleHomeModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"remNovels" : [ZMDiscoverArticleModel class]
            };
}

@end

@implementation ZMArticleChannelModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
                @"posts" : [ZMDiscoverArticleModel class]
            };
}

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    id posts = [self arrDispose:dic[@"posts"]];
    if ([posts isKindOfClass:[NSArray class]] && [posts lastObject]) {
        id lastId = ((NSDictionary *)[posts lastObject])[@"postId"];
        if (![lastId isKindOfClass:[NSString class]]) return NO;
        self.lastId = lastId;
    }
    return YES;
    
}

@end
