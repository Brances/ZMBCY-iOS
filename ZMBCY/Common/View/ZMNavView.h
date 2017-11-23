//
//  ZMNavView.h
//  Zomake
//
//  Created by uzhengxiang on 16/6/20.
//  Copyright © 2016年 ZOMAKE. All rights reserved.
//  自定义导航

#import "ZMView.h"

@interface ZMNavView : ZMView

@property (nonatomic, strong) UIButton *leftButton;

@property (nonatomic, strong) UIButton *leftTwoButton;

@property (nonatomic, strong) UIButton *rightButton;

@property (nonatomic, strong) UIButton *centerButton;

@property (nonatomic, strong) UILabel *rightLabel;

@property (nonatomic, assign) BOOL isHaveLineLabel;

@property (nonatomic, assign) BOOL isWhite;

/** 中间按钮文字 */
@property (nonatomic, strong) ZMLabel *centerLabel;

@end
