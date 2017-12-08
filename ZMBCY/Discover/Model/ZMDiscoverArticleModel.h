//
//  ZMDiscoverArticleModel.h
//  ZMBCY
//
//  Created by ZOMAKE on 2017/12/7.
//  Copyright © 2017年 Brance. All rights reserved.
//  发现-文章banner

#import "ZMBaseModel.h"
#import "ZMAuthorModel.h"
#import "ZMTagModel.h"

@interface ZMDiscoverArticleModel : ZMBaseModel

@property (nonatomic, copy) NSString        *postId;
/** 图片后缀 */
@property (nonatomic, copy) NSString        *imgId;
/** 图片全路径 */
@property (nonatomic, copy) NSString        *fullThumb;
/** 阅读量 */
@property (nonatomic, copy) NSString        *visit;
/** 是否点赞 */
@property (nonatomic, assign) BOOL          hasPraise;

@property (nonatomic, assign) UInt64        type;
@property (nonatomic, assign) UInt64        state;
@property (nonatomic, assign) UInt64        shield;
@property (nonatomic, assign) UInt64        imgCount;
@property (nonatomic, strong) ZMAuthorModel *author;
/** 圈子名称 */
@property (nonatomic, copy) NSString        *circleName;
/** 圈子ID */
@property (nonatomic, copy) NSString        *circleId;
/** 第一个标签图片 */
@property (nonatomic, copy) NSString        *circlePic;
/** banner图片后缀 */
@property (nonatomic, copy) NSString        *circleImage;
/** banner图片完整路径 */
@property (nonatomic, copy) NSString        *fullUrl;
/** 文章总结 */
@property (nonatomic, copy) NSString        *summary;
/** 文章字数统计 */
@property (nonatomic, assign) long long     wordNum;
/** 继续阅读传的章节ID */
@property (nonatomic, copy) NSString        *serialId;
/** banner标题 */
@property (nonatomic, copy) NSString        *title;
/** 标签集合 */
@property (nonatomic, strong) NSMutableArray<ZMTagModel *>  *tags;
/** 标签集合值 = circleName + tagName */
@property (nonatomic, copy) NSString        *tag;

@end



