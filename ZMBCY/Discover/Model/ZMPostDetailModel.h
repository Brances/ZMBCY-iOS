//
//  ZMPostDetailModel.h
//  ZMBCY
//
//  Created by ZOMAKE on 2017/12/26.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "ZMBaseModel.h"
#import "ZMTagModel.h"
#import "ZMPictureMetadata.h"
#import "ZMRelatedPostModel.h"

@interface ZMPostDetailModel : ZMBaseModel

/** 帖子ID */
@property (nonatomic, copy) NSString        *pid;
/** 帖子类型 */
@property (nonatomic, assign) NSInteger     type;
/** 创建时间 */
@property (nonatomic, assign) long long     createTime;
/** 创建时间字符串 */
@property (nonatomic, copy) NSString        *createTimeString;
/** 标题 */
@property (nonatomic, copy) NSString        *richText;
/** 标题TextLayout，如果有的话 */
@property (nonatomic, strong) YYTextLayout  *richTextLayout;
/** 标题高度，如果有的话 */
@property (nonatomic, assign) CGFloat       richTextHeight;
/** 评论数量 */
@property (nonatomic, assign) NSInteger     commentCount;
/** 点赞数量 */
@property (nonatomic, assign) NSInteger     supportCount;
/** 订阅数量？ */
@property (nonatomic, assign) NSInteger     subCount;
/** 图片名称集合 */
@property (nonatomic, strong) NSArray       *imagesID;
/** 图片总高度 */
@property (nonatomic, assign) CGFloat       imagesHeight;
/** 作者ID */
@property (nonatomic, copy) NSString        *authorID;
/** 作者昵称 */
@property (nonatomic, copy) NSString        *authorNickName;
/** 作者头像 */
@property (nonatomic, copy) NSString        *authorAvatar;
/** 头像路径 */
@property (nonatomic, copy) NSString        *avatarFullUrl;
/** 是否订阅 */
@property (nonatomic, assign,getter=isSubscribed) BOOL          subscribed;
/** 圈子ID */
@property (nonatomic, copy) NSString        *circleID;
/** 圈子名称 */
@property (nonatomic, copy) NSString        *circleName;
/** 是否点赞 */
@property (nonatomic, assign) BOOL          isSupport;
/** 是否收藏 */
@property (nonatomic, assign) BOOL          isCollect;
/** 版权所有 */
@property (nonatomic, assign) BOOL          copyrighted;
/** 是否报道？ */
@property (nonatomic, assign) BOOL          isReported;
/** 标签集合 */
@property (nonatomic, strong) NSMutableArray<ZMTagModel *> *tags;
/** 是否删除 */
@property (nonatomic, assign) BOOL          deleted;
/** 是否屏蔽 */
@property (nonatomic, assign) BOOL          shield;
/**  */
@property (nonatomic, assign) NSInteger     interestState;
/** 喜欢这个动态？ */
@property (nonatomic, assign) BOOL          favoriteDynamic;
/** 显示的大图片集合 */
@property (nonatomic, strong) NSMutableArray<ZMPictureMetadata *> *downloadImgInfos;
/** 猜你喜欢帖子集合 */
@property (nonatomic, strong) NSMutableArray<ZMRelatedPostModel *> *relatedPosts;


@end
