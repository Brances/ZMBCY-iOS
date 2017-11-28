//
//  ZMHotRecommendModel.h
//  ZMBCY
//
//  Created by Brance on 2017/11/28.
//  Copyright © 2017年 Brance. All rights reserved.
//  热推

#import "ZMBaseModel.h"
#import "ZMAuthorModel.h"

@interface ZMHotRecommendModel : ZMBaseModel

/** 图片url */
@property (nonatomic, copy) NSString    *imgId;
/** 封面图后缀 */
@property (nonatomic, copy) NSString    *imageSuffix;
/** 宽度 */
@property (nonatomic, assign) CGFloat   width;
/* 实际宽度px */
@property (nonatomic, assign) CGFloat   realWidth;
/** 高度 */
@property (nonatomic, assign) CGFloat   height;
/* 实际高度px */
@property (nonatomic, assign) CGFloat   realHeight;
/** size */
@property (nonatomic, assign) CGFloat   size;
/** postId */
@property (nonatomic, copy) NSString    *postId;
/** 标题 */
@property (nonatomic, copy) NSString    *title;
/** 摘要 */
@property (nonatomic, copy) NSString    *summary;
/** 状态 */
@property (nonatomic, assign) UInt64    state;
/** 数量 */
@property (nonatomic, assign) CGFloat   imgCount;
/** 类型 */
@property (nonatomic, assign) UInt64    type;
/** 是否点赞 */
@property (nonatomic, assign) BOOL      hasPraise;
/** 排名 */
@property (nonatomic, assign) UInt64      top;
/** 作者信息 */
@property (nonatomic, strong) ZMAuthorModel *author;


@end
