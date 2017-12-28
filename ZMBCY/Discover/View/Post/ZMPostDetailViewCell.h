//
//  ZMPostDetailViewCell.h
//  ZMBCY
//
//  Created by Brance on 2017/12/26.
//  Copyright © 2017年 Brance. All rights reserved.
//  帖子

#import "YYTableViewCell.h"
#import "ZMPostDetailModel.h"
#import "ZMDiscoverArticleTagView.h"
#import "ZMPostDetailPraiseAuthorModel.h"
#import "ZMDiscoverHeadModel.h"

@interface ZMPostDetailViewCell : YYTableViewCell

@end


@interface ZMPostDetailViewUserInfoCell : YYTableViewCell

@property (nonatomic, strong) UIView        *mainView;
@property (nonatomic, strong) UIImageView   *thumbImageView;
@property (nonatomic, strong) UILabel       *nameLabel;
@property (nonatomic, strong) UILabel       *creatTimeLabel;
@property (nonatomic, strong) UILabel       *circleNameLabel;
@property (nonatomic, strong) UIButton      *followButton;
@property (nonatomic, strong) UIImageView   *bottomLine;

@property (nonatomic, strong) ZMPostDetailModel *model;

@end

//正文标题，如果有的话
@interface ZMPostDetailViewTextContentCell : YYTableViewCell

@property (nonatomic, strong) UIView        *mainView;
@property (nonatomic, strong) YYLabel       *nameLabel;

@property (nonatomic, strong) ZMPostDetailModel *model;

@end

//正文图片列表，如果有的话
@interface ZMPostDetailViewImageListCell : YYTableViewCell

@property (nonatomic, strong) UIView            *mainView;
@property (nonatomic, strong) NSMutableArray    *imagesArray;
@property (nonatomic, strong) ZMPostDetailModel *model;

@end

//标签视图，如果有的话
@interface ZMPostDetailViewTagCell : YYTableViewCell

@property (nonatomic, strong) UIView                            *mainView;
/** 滚动标签 */
@property (nonatomic, strong) ZMDiscoverArticleTagView          *tagView;
@property (nonatomic, strong) ZMPostDetailModel                 *model;

@end

//点赞的人
@interface ZMPostDetailViewPraiseCell : YYTableViewCell

@property (nonatomic, strong) UIView        *mainView;
/** 喜欢人数 */
@property (nonatomic, strong) UILabel       *praiseLabel;
/** 右边箭头 */
@property (nonatomic, strong) UIImageView   *arrowImageView;
/** 分割线 */
@property (nonatomic, strong) UIImageView   *topLineImageView;
/** 用来统计图片左边距 */
@property (nonatomic, assign) CGFloat       marginLeft;

@property (nonatomic, strong) ZMPostDetailModel   *model;

@end

//猜你喜欢
@class ZMPostDetailViewHeaderView;
@interface ZMPostDetailViewRelatedPostsCell : YYTableViewCell

@property (nonatomic, strong) UIView                            *mainView;
@property (nonatomic, strong) UIScrollView                      *scrollView;
/** 分割线 */
@property (nonatomic, strong) UIImageView                       *topLineImageView;
@property (nonatomic, strong) ZMPostDetailViewHeaderView        *headerView;
/** 用来统计图片左边距 */
@property (nonatomic, assign) CGFloat                           marginLeft;

@property (nonatomic, strong) ZMPostDetailModel                 *model;

@end

//头部 - 猜你喜欢、全部评论、最热评论
@interface ZMPostDetailViewHeaderView : UIView

@property (nonatomic, strong) UIView        *mainView;
/** 图标 */
@property (nonatomic, strong) UIImageView    *iconImageView;
/** 文字 */
@property (nonatomic, strong) UILabel        *titleLabel;
/** 头部model */
@property (nonatomic, strong) ZMDiscoverHeadModel *model;

@end



