//
//  ZMRankingListModel.m
//  ZMBCY
//
//  Created by Brance on 2017/12/14.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "ZMRankingListModel.h"

@implementation ZMRankingListModel
- (NSMutableArray *)rankingArray{
    if (!_rankingArray) {
        _rankingArray = [NSMutableArray new];
    }
    return _rankingArray;
}
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
    //排行榜日期集合
    for (NSDictionary *rankDic in [self arrDispose:dic[@"rankingMarks"]]) {
        [self.rankingArray addObject:[self dispose:rankDic[@"markShow"]]];
    }
    
    return YES;
}

@end

@implementation ZMRankingMarkModel


@end

@implementation ZMRankingModel

+ (NSDictionary *)modelCustomPropertyMapper{
    return @{
             @"pid":@"id"
             };
}

@end
