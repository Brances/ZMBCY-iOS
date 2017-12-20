//
//  ZMAuthorModel.h
//  ZMBCY
//
//  Created by Brance on 2017/11/28.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "ZMBaseModel.h"

@interface ZMAuthorModel : ZMBaseModel

/** 用户id */
@property (nonatomic, copy) NSString        *uid;
/** 头像 */
@property (nonatomic, copy) NSString        *portrait;
/** 头像完整路径 */
@property (nonatomic, copy) NSString        *portraitFullUrl;
/** 昵称 */
@property (nonatomic, copy) NSString        *nickName;
/** 性别 */
@property (nonatomic, assign) int           sex;
/** 验证时间 */
@property (nonatomic, assign) UInt64        expire_time;
/** 等级 */
@property (nonatomic, assign) UInt64        level;
/** 兴趣状态 */
@property (nonatomic, assign) UInt64        interestState;
/** 简介 */
@property (nonatomic, copy) NSString        *signature;
/** 微博昵称 */
@property (nonatomic, copy) NSString        *weiboNickname;
/** 微博地址 */
@property (nonatomic, copy) NSString        *weiboUrl;
/** 关系 */
@property (nonatomic, assign) int           relationType;



@end
