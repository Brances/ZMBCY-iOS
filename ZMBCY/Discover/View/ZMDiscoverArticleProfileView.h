//
//  ZMDiscoverArticleProfileView.h
//  ZMBCY
//
//  Created by Brance on 2017/12/8.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMDiscoverArticleProfileView : UIView

@property (nonatomic, strong) UIView            *mainView;
@property (nonatomic, strong) UIImageView       *thumb;
@property (nonatomic, strong) YYLabel           *nickLabel;
@property (nonatomic, strong) UIButton          *praiseButton;

@property (nonatomic, copy) void(^praiseBlock)(BOOL);

@end
