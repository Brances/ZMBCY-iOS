//
//  ZMWorksModel.h
//  ZMBCY
//
//  Created by Brance on 2017/12/5.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "ZMBaseModel.h"
#import "ZMAuthorModel.h"
#import "ZMWorkModel.h"

@interface ZMWorksModel : ZMBaseModel

/** 作者 */
@property (nonatomic, strong) ZMAuthorModel  *author;
/** 作品 */
@property (nonatomic, strong) NSMutableArray<ZMWorkModel *> *work;

@end
