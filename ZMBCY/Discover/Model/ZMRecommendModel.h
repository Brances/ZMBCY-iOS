//
//  ZMRecommendModel.h
//  ZMBCY
//
//  Created by Brance on 2017/11/28.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "ZMBaseModel.h"
#import "ZMTopicModel.h"
#import "ZMCircleModel.h"
#import "ZMHotRecommendModel.h"

@interface ZMRecommendModel : ZMBaseModel

/** 轮播 */
@property (nonatomic, strong) NSMutableArray *bannerArray;
/** 热门专题 */
@property (nonatomic, strong) NSMutableArray *hotTopicArray;
/** 热门圈子 */
@property (nonatomic, strong) NSMutableArray *hotCircleArray;
/** 热推ListModel */
@property (nonatomic, strong) ZMHotRecommendListModel *recommendListModel;

@end
