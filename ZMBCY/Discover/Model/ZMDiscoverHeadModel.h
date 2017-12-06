//
//  ZMDiscoverHeadModel.h
//  ZMBCY
//
//  Created by ZOMAKE on 2017/12/6.
//  Copyright © 2017年 Brance. All rights reserved.
//  头部model

#import "ZMBaseModel.h"

@interface ZMDiscoverHeadModel : ZMBaseModel

/** uid */
@property (nonatomic, copy) NSString    *uid;
/** 图片url */
@property (nonatomic, copy) NSString    *img;
/** 图片 */
@property (nonatomic, strong) UIImage   *icon;
/** 文字 */
@property (nonatomic, copy) NSString    *title;
/** 是否显示额外按钮 */
@property (nonatomic, assign) BOOL      show;

@end
