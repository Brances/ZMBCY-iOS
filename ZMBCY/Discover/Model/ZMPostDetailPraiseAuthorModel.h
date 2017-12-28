//
//  ZMPostDetailPraiseAuthorModel.h
//  ZMBCY
//
//  Created by ZOMAKE on 2017/12/28.
//  Copyright © 2017年 Brance. All rights reserved.
//  喜欢的人

#import "ZMBaseModel.h"

@interface ZMPostDetailPraiseAuthorModel : ZMBaseModel

@property (nonatomic, copy) NSString        *uid;
@property (nonatomic, copy) NSString        *name;
@property (nonatomic, copy) NSString        *avatarId;
@property (nonatomic, copy) NSString        *avatarFullUrl;

@end
