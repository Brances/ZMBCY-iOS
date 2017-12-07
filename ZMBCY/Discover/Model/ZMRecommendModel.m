//
//  ZMRecommendModel.m
//  ZMBCY
//
//  Created by Brance on 2017/11/28.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "ZMRecommendModel.h"

@implementation ZMRecommendModel
- (NSMutableArray *)bannerArray{
    if (!_bannerArray) {
        _bannerArray = [NSMutableArray new];
    }
    return _bannerArray;
}
- (NSMutableArray *)hotTopicArray{
    if (!_hotTopicArray) {
        _hotTopicArray = [NSMutableArray new];
    }
    return _hotTopicArray;
}
- (NSMutableArray *)hotCircleArray{
    if (!_hotCircleArray) {
        _hotCircleArray = [NSMutableArray new];
    }
    return _hotCircleArray;
}

@end
