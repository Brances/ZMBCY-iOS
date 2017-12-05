//
//  ZMWorkModel.h
//  ZMBCY
//
//  Created by ZOMAKE on 2017/12/5.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "ZMBaseModel.h"

@interface ZMWorkModel : ZMBaseModel

/** 图片url后缀 */
@property (nonatomic, copy) NSString *imgId;
/** 图片全路径 */
@property (nonatomic, copy) NSString *fullUrl;
/** 帖子id */
@property (nonatomic, copy) NSString *postId;
/** type */
@property (nonatomic, assign) UInt64  type;
/** state */
@property (nonatomic, assign) UInt64  state;
/** state */
@property (nonatomic, assign) UInt64  imgCount;

@end
