//
//  ZMRelatedPostModel.h
//  ZMBCY
//
//  Created by Brance on 2017/12/26.
//  Copyright © 2017年 Brance. All rights reserved.
//  猜你喜欢帖子

#import "ZMBaseModel.h"
#import "ZMAuthorModel.h"
#import "ZMPictureMetadata.h"

@interface ZMRelatedPostModel : ZMBaseModel

/** 帖子ID */
@property (nonatomic, copy) NSString        *postId;
/** 帖子标题 */
@property (nonatomic, copy) NSString        *title;
/** 简介 */
@property (nonatomic, copy) NSString        *summary;
/** 状态 */
@property (nonatomic, assign) NSInteger     state;
/** 图片数量 */
@property (nonatomic, assign) NSInteger     imgCount;
/** 类型 */
@property (nonatomic, assign) NSInteger     type;
/** 是否点赞 */
@property (nonatomic, assign) BOOL          hasPraise;
/** 排行位置 */
@property (nonatomic, assign) NSInteger     top;
/** 作者实体类信息 */
@property (nonatomic, strong) ZMAuthorModel *author;
/** 帖子封面图信息 */
@property (nonatomic, strong) ZMPictureMetadata *cover;

@end
