//
//  ZMAuthorModel.h
//  ZMBCY
//
//  Created by ZOMAKE on 2017/11/28.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "ZMBaseModel.h"

@interface ZMAuthorModel : ZMBaseModel

/** 用户id */
@property (nonatomic, copy) NSString *uid;
/** 头像 */
@property (nonatomic, copy) NSString *portrait;
/** 昵称 */
@property (nonatomic, copy) NSString *nickName;

@end
