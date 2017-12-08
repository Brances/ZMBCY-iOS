//
//  ZMTagModel.h
//  ZMBCY
//
//  Created by ZOMAKE on 2017/12/7.
//  Copyright © 2017年 Brance. All rights reserved.
//  标签

#import "ZMBaseModel.h"

@interface ZMTagModel : ZMBaseModel

@property (nonatomic, copy) NSString     *tagName;
@property (nonatomic, copy) NSString     *tagID;
/** 此属性作为文章第一个标签的背景图片url */
@property (nonatomic, copy) NSString     *thumb;

@end
