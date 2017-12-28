//
//  ZMTopicDetailModel.h
//  ZMBCY
//
//  Created by Brance on 2017/12/20.
//  Copyright © 2017年 Brance. All rights reserved.
//  专题详情（首页-热门专题）

#import "ZMBaseModel.h"

@interface ZMTopicDetailModel : ZMBaseModel

/** id */
@property (nonatomic, copy) NSString            *tid;
/** 专题名称 */
@property (nonatomic, copy) NSString            *collect_name;
/** 专题简介 */
@property (nonatomic, copy) NSString            *collect_desc;
/** 专题帖子数量 */
@property (nonatomic, assign) NSInteger         post_count;
/** 关注数量 */
@property (nonatomic, assign) NSInteger         follow_count;
/** 作者id */
@property (nonatomic, copy) NSString            *uid;
/** 作者昵称 */
@property (nonatomic, copy) NSString            *user_name;
/** 是否关注 */
@property (nonatomic, assign,getter=isFollow) BOOL follow;
/** 更新时间 */
@property (nonatomic, assign) long              update_time;
/** 专题状态 0-开放 */
@property (nonatomic, assign) NSInteger         state;
/** 是否点赞 */
@property (nonatomic, assign) BOOL              hasSupport;
/** 喜欢数量 */
@property (nonatomic, assign) NSInteger         supportCount;
/** 浏览数量 */
@property (nonatomic, assign) NSInteger         visitCount;
/**  */
@property (nonatomic, assign) NSInteger         tab;
/** 类型 */
@property (nonatomic, assign) NSInteger         type;
/** 是否私有 */
@property (nonatomic, assign) BOOL              isPrivate;

@property (nonatomic, strong) YYTextLayout      *descLayout;
@property (nonatomic, assign) CGFloat           descHeight;
@property (nonatomic, assign) CGFloat           height;


@end
