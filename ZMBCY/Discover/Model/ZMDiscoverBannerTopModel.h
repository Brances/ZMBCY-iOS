//
//  ZMDiscoverBannerTopModel.h
//  ZMBCY
//
//  Created by ZOMAKE on 2017/12/13.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "ZMBaseModel.h"

@interface ZMDiscoverBannerTopModel : ZMBaseModel

/** 右边图片id */
@property (nonatomic, copy) NSString        *imgId;
/** 图片全路径 */
@property (nonatomic, copy) NSString        *rightFull;
/** 作者ID */
@property (nonatomic, copy) NSString        *authorID;
/** 作者昵称 */
@property (nonatomic, copy) NSString        *authorName;
/** 作者头像 */
@property (nonatomic, copy) NSString        *headPic;
/** 作者全路径*/
@property (nonatomic, copy) NSString        *headFull;
/** 链接类型  默认是0*/
@property (nonatomic, assign) UInt64        linkType;

@end
