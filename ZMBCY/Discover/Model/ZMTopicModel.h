//
//  ZMTopicModel.h
//  ZMBCY
//
//  Created by Brance on 2017/11/27.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "ZMBaseModel.h"

@interface ZMTopicModel : ZMBaseModel

/** id */
@property (nonatomic, copy) NSString *uid;
/** 标题 */
@property (nonatomic, copy) NSString *name;
/** 封面图 */
@property (nonatomic, copy) NSString *cover;
/** 封面图后缀 */
@property (nonatomic, copy) NSString *imageSuffix;
/** 描述 */
@property (nonatomic, copy) NSString *desc;
/** 数量 */
@property (nonatomic, assign) UInt64 num;
/** 关注数量 */
@property (nonatomic, assign) UInt64 followCount;
/** 是否私有 */
@property (nonatomic, assign) BOOL   isPrivate;
/** 类型 */
@property (nonatomic, assign) UInt64 type;

@end
