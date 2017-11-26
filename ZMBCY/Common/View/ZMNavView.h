//
//  ZMNavView.h
//  
//
//  Created by Brance on 17/11/24.
//  Copyright © 2016年 Brance. All rights reserved.
//  自定义导航


@interface ZMNavView : UIView

@property (nonatomic, strong) UIButton *leftButton;

@property (nonatomic, strong) UIButton *leftTwoButton;

@property (nonatomic, strong) UIButton *rightButton;

@property (nonatomic, strong) UIButton *centerButton;

@property (nonatomic, strong) UILabel *rightLabel;

@property (nonatomic, assign) BOOL isHaveLineLabel;

@property (nonatomic, assign) BOOL isWhite;

/** 中间按钮文字 */
@property (nonatomic, strong) YYLabel *centerLabel;

@end
