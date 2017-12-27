//
//  ZMPostDetailViewCell.h
//  ZMBCY
//
//  Created by ZOMAKE on 2017/12/26.
//  Copyright © 2017年 Brance. All rights reserved.
//  帖子

#import "YYTableViewCell.h"
#import "ZMPostDetailModel.h"
#import "ZMDiscoverArticleTagView.h"

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



@end
