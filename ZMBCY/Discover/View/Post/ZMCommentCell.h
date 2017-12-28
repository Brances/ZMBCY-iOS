//
//  ZMCommentCell.h
//  ZMBCY
//
//  Created by 卢洋 on 2017/12/28.
//  Copyright © 2017年 Brance. All rights reserved.
//  评论

#import "YYTableViewCell.h"
#import "ZMCommentModel.h"

@class ZMCommentCellUserOperationView;
@interface ZMCommentCell : YYTableViewCell

@property (nonatomic, strong) UIView                            *mainView;
@property (nonatomic, strong) ZMCommentCellUserOperationView    *userOperationView;

@property (nonatomic, strong) ZMCommentModel                    *model;

@end

//用户操作视图
@interface ZMCommentCellUserOperationView : UIView

@property (nonatomic, strong) UIView        *mainView;
@property (nonatomic, strong) UIImageView   *topLineImageView;
@property (nonatomic, assign) BOOL          showTopLine;
@property (nonatomic, strong) UIImageView   *thumbImageView;
@property (nonatomic, strong) UILabel       *nameLabel;
@property (nonatomic, strong) UILabel       *creatTimeLabel;
@property (nonatomic, strong) UIImageView   *likeImageView;
@property (nonatomic, strong) UILabel       *likeCountLabel;

@end
