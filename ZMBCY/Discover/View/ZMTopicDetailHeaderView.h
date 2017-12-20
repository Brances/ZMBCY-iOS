//
//  ZMTopicDetailHeaderView.h
//  ZMBCY
//
//  Created by Brance on 2017/12/20.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZMTopicDetailModel.h"

@interface ZMTopicDetailHeaderView : UIView

@property (nonatomic, strong) UIView        *mainView;
@property (nonatomic, strong) UIImageView   *headImageView;
@property (nonatomic, strong) UIImageView   *leftTopImageView;
@property (nonatomic, strong) UIImageView   *rightBottomImageView;
@property (nonatomic, strong) UILabel       *titleLabel;
@property (nonatomic, strong) YYLabel       *descLabel;
@property (nonatomic, strong) UIButton      *followButton;
@property (nonatomic, strong) UIImageView   *thumbImageView;
@property (nonatomic, strong) UILabel       *nickLabel;

@property (nonatomic, strong) ZMTopicDetailModel    *model;

@end
