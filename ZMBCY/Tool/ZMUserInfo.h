//
//  ZMUserInfo.h
//  ZMBCY
//
//  Created by ZOMAKE on 2018/1/6.
//  Copyright © 2018年 Brance. All rights reserved.
//

#import "ZMBaseModel.h"
#import <AVOSCloud/AVOSCloud.h>

@interface ZMUserInfo : ZMBaseModel

/** 用户ID */
@property (nonatomic, copy) NSString    *userId;
/** 昵称 */
@property (nonatomic, copy) NSString    *userName;
/** sessionToken */
@property (nonatomic, copy) NSString    *sessionToken;
/** 头像地址 */
@property (nonatomic, copy) NSString    *thumb;
/** 是否登录 */
@property (nonatomic, assign) BOOL      isLogin;
/** 邮箱 */
@property (nonatomic, copy) NSString    *email;
/** 邮箱是否验证 */
@property (nonatomic, assign) BOOL      emailVerfied;
/** 性别（0-谜之生物，1-女，2-男） */
@property (nonatomic, assign) NSInteger sex;
/** 性别名称 */
@property (nonatomic, copy) NSString    *sexName;
/** 签名 */
@property (nonatomic, copy) NSString    *signature;

/**
 *  单例
 *
 *  @return 返回ZMUserInfo
 */
+ (instancetype)shareUserInfo;

/** 保存用户信息到沙盒 */
- (void)saveUserInfoToSandbox;

/** 从沙盒中加载用户信息 */
- (void)loadUserInfoFromSandbox;

/** 解析用户信息 */
- (void)loadUserInfo:(AVObject *)user;

/** 更新用户信息 */
- (void)updateUserInfo:(AVObject *)user;

- (void)loginOut;

@end
