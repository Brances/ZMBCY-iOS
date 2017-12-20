//
//  ZMTopicDetailSubjectModel.h
//  ZMBCY
//
//  Created by ZOMAKE on 2017/12/20.
//  Copyright © 2017年 Brance. All rights reserved.
//  专题 - 帖子

#import "ZMBaseModel.h"
#import "ZMPictureMetadata.h"
#import "ZMAuthorModel.h"

@interface ZMTopicDetailSubjectModel : ZMBaseModel

/** 帖子id */
@property (nonatomic, copy) NSString        *post_id;
/** 图片id */
@property (nonatomic, copy) NSString        *pics;
/** 图片集合 */
@property (nonatomic, strong) NSArray<ZMPictureMetadata *> *downloadImgInfos;
/** 详情内容 */
@property (nonatomic, copy) NSString        *content;
/**  */
@property (nonatomic, copy) NSString        *digest;
/** 收藏帖子 */
@property (nonatomic, copy) NSString        *reason;
/** 保护 */
@property (nonatomic, assign) NSInteger     shield;
/** 帖子状态0-显示，1-删除 */
@property (nonatomic, assign) NSInteger     state;
/** 帖子状态 */
@property (nonatomic, assign) subjectSate   subjectState;

/** 类型 */
@property (nonatomic, assign) NSInteger     type;
/**  */
@property (nonatomic, assign) NSInteger     bid;
/** 作者信息 */
@property (nonatomic, strong) ZMAuthorModel *author;

@end
