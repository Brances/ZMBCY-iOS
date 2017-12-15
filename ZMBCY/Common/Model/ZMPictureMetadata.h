//
//  ZMPictureMetadata.h
//  ZMBCY
//
//  Created by Brance on 2017/12/14.
//  Copyright © 2017年 Brance. All rights reserved.
//  图片元数据

#import "ZMBaseModel.h"

@interface ZMPictureMetadata : ZMBaseModel

@property (nonatomic, copy) NSString            *imageId;
/** 宽屏正方形图 */
@property (nonatomic, copy) NSString            *fullUrl;
@property (nonatomic, assign) CGFloat            width;
/* 实际宽度 * 2px */
@property (nonatomic, assign) CGFloat           realWidth;
@property (nonatomic, assign) CGFloat            height;
/* 实际高度 * 2px */
@property (nonatomic, assign) CGFloat           realHeight;
@property (nonatomic, assign) CGFloat            size;

@end
