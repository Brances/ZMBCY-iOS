//
//  ZMCircleModel.h
//  ZMBCY
//
//  Created by Brance on 2017/11/28.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "ZMBaseModel.h"

@interface ZMCircleModel : ZMBaseModel

/** 圈子ID */
@property (nonatomic, copy) NSString *circleId;
/** 封面图 */
@property (nonatomic, copy) NSString *circlePic;
/** 封面图后缀 */
@property (nonatomic, copy) NSString *imageSuffix;
/** 圈子名称 */
@property (nonatomic, copy) NSString *circleName;
/** 人气值 */
@property (nonatomic, copy) NSString *allCount;
/** 推荐描述 */
@property (nonatomic, copy) NSString *recommendText;
/** 索引位置 */
@property (nonatomic, assign) UInt64 position;
/** 链接提示 */
@property (nonatomic, copy) NSString *alt;

@end
