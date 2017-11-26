//
//  ZMPostModel.h
//  ZMBCY
//
//  Created by Brance on 2017/11/24.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "ZMBaseModel.h"

@interface ZMPostModel : ZMBaseModel

/** 帖子ID */
@property (nonatomic, copy) NSString        *wid;
/** 文章类型 */
@property (nonatomic, copy) NSString        *tl_type;
/** 帖子发布时间 */
@property (nonatomic, assign) long long     ctime;
/** 昵称 */
@property (nonatomic, copy) NSString        *real_name;
/** 作者头像 */
@property (nonatomic, copy) NSString        *work_cover;
/** 是否关注 */
@property (nonatomic, assign, readonly) BOOL wf_status;
/** 作者类型 - coser、zhipin */
@property (nonatomic, copy) NSString        *otype;
/** 数据类型 - post、goods */
@property (nonatomic, assign) otypeData     otype_data;
/** 原作者ID */
@property (nonatomic, copy) NSString        *ouid;
/** 原作者昵称 */
@property (nonatomic, copy) NSString        *ouname;
/** 原作者头像 */
@property (nonatomic, copy) NSString        *oavatar;

/** 原作者昵称 */
@property (nonatomic, copy) NSString        *uname;
/** 原作者头像 */
@property (nonatomic, copy) NSString        *avatar;

@end
