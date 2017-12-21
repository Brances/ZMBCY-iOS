//
//  ZMTopicDetailSubjectCell.h
//  ZMBCY
//
//  Created by ZOMAKE on 2017/12/20.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "YYTableViewCell.h"
#import "ZMWaterFlowLayout.h"
#import "ZMTopicDetailSubjectModel.h"

@class ZMTopicDetailSubjectCollectView,ZMTopicDetailSubjectUserFollowView;
@interface ZMTopicDetailSubjectCell : YYTableViewCell

@property (nonatomic, strong) NSArray   *dataArray;
@property (nonatomic, assign) CGFloat   cacheHeight;
@property (nonatomic, assign) BOOL      needUpdate;
@property (nonatomic, copy) void(^updateCellHeight)(CGFloat);
@property (nonatomic, assign) itemStyle style;

@end

@interface ZMTopicDetailSubjectCellView : UICollectionViewCell

/** 容器 */
@property (nonatomic, strong) UIView                                *mainView;
/** 图片 */
@property (nonatomic, strong) ZMImageView                           *coverImageView;
/** 已删除图片，遇到一个奇怪的bug,只能再添加一个视图 */
@property (nonatomic, strong) UIImageView                           *deleteImageView;

/** 文章标题 */
@property (nonatomic, strong) UILabel                               *articleNameLabel;
/** 文章内容 */
@property (nonatomic, strong) UILabel                               *articleContentLabel;
/** 底部分割线 */
@property (nonatomic, strong) UILabel                               *bottomLineLabel;

/** 收藏视图 */
@property (nonatomic, strong) ZMTopicDetailSubjectCollectView       *collectView;
/** 单行用户点赞视图 */
@property (nonatomic, strong) ZMTopicDetailSubjectUserFollowView    *followView;

@property (nonatomic, strong) ZMTopicDetailSubjectModel             *model;

- (void)setupUIWithStyle:(itemStyle)style model:(id)model;

@end


@interface ZMTopicDetailSubjectCollectView : UIView

@property (nonatomic, strong) UIImageView       *iconImageView;
@property (nonatomic, strong) YYLabel           *nameLabel;

@end

@interface  ZMTopicDetailSubjectUserFollowView : UIView

@property (nonatomic, strong) UIView            *mainView;
@property (nonatomic, strong) UIImageView       *thumbImageView;
@property (nonatomic, strong) UILabel           *nameLabel;
@property (nonatomic, strong) UIButton          *followButton;
@property (nonatomic, strong) UILabel           *bottomLineLabel;

@end

