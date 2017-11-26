//
//  ZMPostDetailModel.h
//  ZMBCY
//
//  Created by Brance on 2017/11/24.
//  Copyright © 2017年 Brance. All rights reserved.
//  帖子详情

#import "ZMBaseModel.h"

@interface ZMPostDetailModel : ZMBaseModel

/** 以下两个属性只有商品才有（手机壳） */
@property (nonatomic, copy) NSString    *zg_id;
/**  */
@property (nonatomic, copy) NSString    *zp_id;
/** 标题 */
@property (nonatomic, copy) NSString    *title;
/** 介绍（有此字段表明可能是文章或者是商品） */
@property (nonatomic, copy) NSString    *intro;
/** 发布时间 */
@property (nonatomic, assign) long long ctime;
/** 基础价格 */
@property (nonatomic, assign) float     basic_price;
/** 商品配图 */
@property (nonatomic, copy) NSString    *cover;
/** 作者昵称 */
@property (nonatomic, copy) NSString    *work;
/** 是否订阅？ */
@property (nonatomic, assign) BOOL      have_ding;
/** 订阅数量? */
@property (nonatomic, assign) float     ding_num;
/** 内容 */
@property (nonatomic, copy) NSString    *plain;
/** 是否关注 */
@property (nonatomic, assign)BOOL       followstate;
/** ID */
@property (nonatomic, copy) NSString    *wid;


@end
