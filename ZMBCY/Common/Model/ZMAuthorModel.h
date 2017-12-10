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
@property (nonatomic, copy) NSString *uid;
/** 头像 */
@property (nonatomic, copy) NSString *portrait;
/** 头像完整路径 */
@property (nonatomic, copy) NSString *portraitFullUrl;
/** 昵称 */
@property (nonatomic, copy) NSString *nickName;
/** 等级 */
@property (nonatomic, assign) UInt64 level;
/** 兴趣状态 */
@property (nonatomic, assign) UInt64 interestState;
/** 简介 */
@property (nonatomic, copy) NSString *signature;

@end
