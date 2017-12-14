//
//  ZMRankingListModel.m
//  ZMBCY
//
//  Created by ZOMAKE on 2017/12/14.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "ZMRankingListModel.h"

@implementation ZMRankingListModel

- (NSMutableArray *)rankOvers{
    if (!_rankOvers) {
        _rankOvers = [NSMutableArray new];
    }
    return _rankOvers;
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"rankingMarks" : [ZMRankingMarkModel class],
             @"rankings"     : [ZMRankingModel class]
            };
}

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    NSInteger currenType = [dic[@"type"] integerValue];
    if (currenType == 1) {
        self.type = trendTypeWeek;
    }else if (currenType == 2){
        self.type = trendTypeMonth;
    }else{
        self.type = trendTypeDay;
    }
    
    return YES;
}

@end

@implementation ZMRankingMarkModel


@end

@implementation ZMRankingModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"uid" : @"id"
            };
}

@end
