//
//  ZMNavView.h
//  
//
//  Created by Brance on 17/11/24.
//  Copyright © 2017年 Brance. All rights reserved.
//  自定义导航


@interface ZMNavView : UIView


@property (nonatomic, strong) UIView    *mainView;
@property (nonatomic, strong) UIButton  *leftButton;
@property (nonatomic, strong) UIButton  *leftTwoButton;
@property (nonatomic, strong) UIButton  *rightButton;
@property (nonatomic, strong) UIButton  *centerButton;
@property (nonatomic, strong) UILabel   *rightLabel;
@property (nonatomic, assign) BOOL      showBottomLabel;
/** 中间按钮文字 */
@property (nonatomic, strong) YYLabel   *centerLabel;

@property (nonatomic, copy) void (^ leftButtonBlock)();
@property (nonatomic, copy) void (^ cenTerButtonBlock)();
@property (nonatomic, copy) void (^ rightButtonBlock)();

@end
