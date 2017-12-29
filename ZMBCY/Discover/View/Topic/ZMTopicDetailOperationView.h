//
//  ZMTopicDetailOperationCell.h
//  ZMBCY
//
//  Created by Brance on 2017/12/20.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZMTopicDetailModel.h"

@interface ZMTopicDetailOperationView : UIView

@property (nonatomic, strong) UIView        *mainView;
/** 帖子icon */
@property (nonatomic, strong) UIImageView   *subjectIcon;
/** 帖子总数 */
@property (nonatomic, strong) UILabel       *subjectTotalLabel;
/** 分割线 */
@property (nonatomic, strong) UIImageView   *lineImageView;
/** 浏览次数icon */
@property (nonatomic, strong) UIImageView   *visitIcon;
/** 浏览次数 */
@property (nonatomic, strong) UILabel       *visitTotalLabel;
/** 切换布局 */
@property (nonatomic, strong) UIButton    *styleButton;
/** 切换布局block yes为单列 */
@property (nonatomic, copy) void(^changeStyleBlock)(BOOL);

@property (nonatomic, strong) ZMTopicDetailModel *model;

@end
