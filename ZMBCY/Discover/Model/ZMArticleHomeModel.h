//
//  ZMArticleHomeModel.h
//  ZMBCY
//
//  Created by Brance on 2017/12/7.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "ZMBaseModel.h"
#import "ZMDiscoverArticleModel.h"

@class ZMArticleChannelModel;
@interface ZMArticleHomeModel : ZMBaseModel

/** 文章频道 */
@property (nonatomic, strong) ZMArticleChannelModel             *channelPost;
/** 推荐文章章节banner集合 */
@property (nonatomic, strong) NSArray<ZMDiscoverArticleModel *> *remNovels;

@end

@interface ZMArticleChannelModel : ZMBaseModel

/** 是否可以加载更多 */
@property (nonatomic, assign) BOOL      hasMore;
/** 用于分页 */
@property (nonatomic, copy) NSString    *lastId;
/** 文章集合 */
@property (nonatomic, strong) NSMutableArray<ZMDiscoverArticleModel *> *posts;

@end
