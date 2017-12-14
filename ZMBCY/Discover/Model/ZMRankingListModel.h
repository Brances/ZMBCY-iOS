//
//  ZMRankingListModel.h
//  ZMBCY
//
//  Created by ZOMAKE on 2017/12/14.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "ZMBaseModel.h"
#import "ZMPictureMetadata.h"
#import "ZMAuthorModel.h"

@class ZMRankingMarkModel,ZMRankingModel;
@interface ZMRankingListModel : ZMBaseModel

/** 是否可以加载更多 */
@property (nonatomic, assign) BOOL          hasMore;
/** 排行版类型 日周月榜 */
@property (nonatomic, assign) trendType     type;
/** 当前标记日期 */
@property (nonatomic, copy) NSString        *currentMarkShow;
/** 日期集合 */
@property (nonatomic, strong) NSArray<ZMRankingMarkModel *>    *rankingMarks;
/** 帖子集合包括前三 */
@property (nonatomic, strong) NSMutableArray<ZMRankingModel *> *rankings;
/** 去除前三的帖子集合 */
@property (nonatomic, strong) NSMutableArray                   *rankOvers;

@end


@interface ZMRankingMarkModel : ZMBaseModel

/** 格式化日期 2017-12-13 */
@property (nonatomic, copy) NSString        *mark;
/** 格式化日期 2017年12月13日 */
@property (nonatomic, copy) NSString        *markShow;


@end

@interface ZMRankingModel : ZMBaseModel

/** 帖子ID */
@property (nonatomic, copy) NSString        *uid;
/** 图片信息 */
@property (nonatomic, strong) ZMPictureMetadata *imageInfo;
/** 图片ID */
@property (nonatomic, copy) NSString        *imgId;
/** 图片数量 */
@property (nonatomic, assign) int           imgCount;
/** 浏览次数 */
@property (nonatomic, assign) UInt64        visiteNum;
/** 点赞 */
@property (nonatomic, assign) UInt64        likeNum;
/** 排名状态 */
@property (nonatomic, assign) UInt64        rankState;
@property (nonatomic, assign) UInt64        changeNum;
@property (nonatomic, assign) UInt64        rankNum;
/** 作者信息 */
@property (nonatomic, strong) ZMAuthorModel *author;
/** 状态 */
@property (nonatomic, assign) int           state;
/** 是否点赞？ */
@property (nonatomic, assign)BOOL           hasSupport;

@end
