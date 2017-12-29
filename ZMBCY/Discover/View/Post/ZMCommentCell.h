//
//  ZMCommentCell.h
//  ZMBCY
//
//  Created by Brance on 2017/12/28.
//  Copyright © 2017年 Brance. All rights reserved.
//  评论

#import "YYTableViewCell.h"
#import "ZMCommentModel.h"

@class ZMCommentCellUserOperationView,ZMCommentCellContent;
@interface ZMCommentCell : YYTableViewCell

@property (nonatomic, strong) UIView                            *mainView;
@property (nonatomic, strong) ZMCommentCellUserOperationView    *userOperationView;
@property (nonatomic, strong) ZMCommentCellContent              *content;
@property (nonatomic, strong) ZMCommentModel                    *model;

@end

//用户操作视图
@interface ZMCommentCellUserOperationView : UIView

@property (nonatomic, strong) UIView        *mainView;
@property (nonatomic, strong) UIImageView   *topLineImageView;
@property (nonatomic, assign) BOOL          showTopLine;
@property (nonatomic, strong) UIImageView   *thumbImageView;
@property (nonatomic, strong) YYLabel       *nameLabel;
@property (nonatomic, strong) UILabel       *creatTimeLabel;
@property (nonatomic, strong) UIButton      *likeImageView;
@property (nonatomic, strong) UILabel       *likeCountLabel;

@end

//正文内容
@interface  ZMCommentCellContent : UIView

@property (nonatomic, strong) UIView        *mainView;
@property (nonatomic, strong) YYLabel       *contentLabel;

@end

