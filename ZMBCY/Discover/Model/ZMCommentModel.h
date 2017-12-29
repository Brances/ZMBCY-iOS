//
//  ZMCommentModel.h
//  ZMBCY
//
//  Created by Brance on 2017/12/28.
//  Copyright © 2017年 Brance. All rights reserved.
//  评论

#import "ZMBaseModel.h"

@interface ZMCommentModel : ZMBaseModel

/** ID */
@property (nonatomic, copy) NSString        *cid;
/** 帖子ID */
@property (nonatomic, copy) NSString        *postID;
/** 评论正文 */
@property (nonatomic, copy) NSString        *content;
/** 喜欢数量 */
@property (nonatomic, assign) NSInteger     likeCount;
/** 是否喜欢 */
@property (nonatomic, assign) BOOL          hasLiked;
/** 评论时间 */
@property (nonatomic, assign) long long     createTime;
/** 评论时间字符串 */
@property (nonatomic, copy) NSString        *createTimeString;
/** 用户ID */
@property (nonatomic, copy) NSString        *userID;
/** 用户昵称 */
@property (nonatomic, copy) NSString        *nickname;
/** 头像 */
@property (nonatomic, copy) NSString        *avatarID;
/** 头像全路径 */
@property (nonatomic, copy) NSString        *avatarFullUrl;
/** 被回复的人昵称 */
@property (nonatomic, copy) NSString        *atnickname;

@property (nonatomic, strong) YYTextLayout  *contentLayout;
@property (nonatomic, assign) CGFloat       userOperationHeight;
@property (nonatomic, assign) CGFloat       contentHeight;
@property (nonatomic, assign) CGFloat       height;

@end
