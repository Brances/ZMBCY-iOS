//
//  ZMRegisterView.m
//  ZMBCY
//
//  Created by ZOMAKE on 2018/1/6.
//  Copyright © 2018年 Brance. All rights reserved.
//

#import "ZMRegisterView.h"

@interface ZMRegisterView()

@property (nonatomic, strong) UIView        *mainView;
@property (nonatomic, strong) UIScrollView  *scrollView;
@property (nonatomic, strong) UIImageView   *bgImageView;
@property (nonatomic, strong) UIButton      *closeButton;

@property (nonatomic, strong) UIImageView   *logoImageView;
@property (nonatomic, strong) UITextField   *userNameField;
@property (nonatomic, strong) UITextField   *passwordField;
@property (nonatomic, strong) UIButton      *registerButton;
@property (nonatomic, strong) YYLabel       *closeLabel;

@property (nonatomic, strong) UILabel       *bottomLine1;
@property (nonatomic, strong) UILabel       *bottomLine2;

@end

@implementation ZMRegisterView

- (UIView *)mainView{
    if (!_mainView) {
        _mainView = [UIView new];
        _mainView.backgroundColor = [ZMColor clearColor];
        [self.scrollView addSubview:_mainView];
        [_mainView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(0);
            make.width.mas_equalTo(self.width);
            make.height.mas_equalTo(self.height + 50);
        }];
    }
    return _mainView;
}

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        [self addSubview:_scrollView];
        [self insertSubview:_scrollView aboveSubview:self.bgImageView];
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(0);
            make.width.mas_equalTo(self.width);
            make.height.mas_equalTo(self.height);
        }];
        [_scrollView.superview layoutIfNeeded];
        _scrollView.contentSize = CGSizeMake(0, _scrollView.height + 1);
    }
    return _scrollView;
}

- (UIImageView *)bgImageView{
    if (!_bgImageView) {
        _bgImageView = [UIImageView new];
        _bgImageView.image = [UIImage imageNamed:@"login_bg_640X1136"];
        [self addSubview:_bgImageView];
        [self sendSubviewToBack:_bgImageView];
        [_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(0);
        }];
    }
    return _bgImageView;
}

- (UIButton *)closeButton{
    if (!_closeButton) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *image = backArrowWhiteIcon;
        [_closeButton setImage:image forState:UIControlStateNormal];
        [self addSubview:_closeButton];
        [self bringSubviewToFront:_closeButton];
        [_closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(20 + 5);
            make.left.mas_equalTo(5);
            make.width.mas_equalTo(30);
            make.height.mas_equalTo(30);
        }];
        [_closeButton.superview layoutIfNeeded];
        [_closeButton addTarget:self action:@selector(clickLeftButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeButton;
}

- (void)setupUI{
    [self closeButton];
    [self bgImageView];
    [self mainView];
    WEAKSELF;
    self.logoImageView = [UIImageView new];
    UIImage *logoImage = [UIImage imageNamed:@"login_header"];
    self.logoImageView.image = logoImage;
    [self.mainView addSubview:self.logoImageView];
    [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(logoImage.size);
        make.centerX.mas_equalTo(self.mainView);
        make.top.mas_equalTo(CGRectGetMaxY(self.closeButton.frame) + 40);
    }];
    
    self.userNameField = [[UITextField alloc] init];
    self.userNameField.font = [UIFont systemFontOfSize:15];
    NSAttributedString *userNameString = [[NSAttributedString alloc] initWithString:@"用户名" attributes:@{NSForegroundColorAttributeName:[ZMColor appLightGrayColor],
                    NSFontAttributeName: self.userNameField.font}];
    self.userNameField.attributedPlaceholder = userNameString;
    self.userNameField.textColor = [ZMColor whiteColor];
    self.userNameField.clearButtonMode=UITextFieldViewModeWhileEditing;
    [self.mainView addSubview:self.userNameField];
    [self.userNameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(50);
        make.top.mas_equalTo(self.logoImageView.mas_bottom).with.offset(60);
    }];
    UIView *userNameMainView = [UIView new];
    
    UIImageView *userNameView = [UIImageView new];
    UIImage *userNameLeftImage = [UIImage imageNamed:@"icon_telephone"];
    userNameView.image = userNameLeftImage;
    userNameView.size = userNameLeftImage.size;
    userNameView.x = 0;
    userNameView.y = 0;
    userNameMainView.size = CGSizeMake(userNameLeftImage.size.width + 10, userNameLeftImage.size.height);
    [userNameMainView addSubview:userNameView];
    
    self.userNameField.leftView = userNameMainView;
    self.userNameField.leftViewMode = UITextFieldViewModeAlways;
    
    self.bottomLine1 = [UILabel new];
    self.bottomLine1.backgroundColor = [ZMColor appLightGrayColor];
    [self.mainView addSubview:self.bottomLine1];
    [self.bottomLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(KMarginLeft);
        make.right.mas_equalTo(-KMarginLeft);
        make.height.mas_equalTo(0.5);
        make.top.mas_equalTo(self.userNameField.mas_bottom).with.offset(1);
    }];
    
    self.passwordField = [[UITextField alloc] init];
    self.passwordField.font = [UIFont systemFontOfSize:15];
    self.passwordField.textColor = [ZMColor whiteColor];
    NSAttributedString *passwordString = [[NSAttributedString alloc] initWithString:@"密码" attributes:@{NSForegroundColorAttributeName:[ZMColor appLightGrayColor],
                    NSFontAttributeName:self.userNameField.font}];
    self.passwordField.attributedPlaceholder = passwordString;
    self.passwordField.clearButtonMode=UITextFieldViewModeWhileEditing;
    [self.mainView addSubview:self.passwordField];
    [self.passwordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(50);
        make.top.mas_equalTo(self.userNameField.mas_bottom).with.offset(1);
    }];
    UIView *passwordMainView = [UIView new];
    
    UIImageView *passwordView = [UIImageView new];
    UIImage *passwordLeftImage = [UIImage imageNamed:@"icon_lock"];
    passwordView.image = passwordLeftImage;
    passwordView.size = passwordLeftImage.size;
    passwordView.x = 0;
    passwordView.y = 0;
    passwordMainView.size = CGSizeMake(passwordLeftImage.size.width + 10, passwordLeftImage.size.height);
    [passwordMainView addSubview:passwordView];
    
    self.passwordField.leftView = passwordMainView;
    self.passwordField.leftViewMode = UITextFieldViewModeAlways;
    
    self.bottomLine2 = [UILabel new];
    self.bottomLine2.backgroundColor = [ZMColor appLightGrayColor];
    [self.mainView addSubview:self.bottomLine2];
    [self.bottomLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(KMarginLeft);
        make.right.mas_equalTo(-KMarginLeft);
        make.height.mas_equalTo(0.5);
        make.top.mas_equalTo(self.passwordField.mas_bottom).with.offset(1);
    }];
    
    //登录
    self.registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.registerButton.titleLabel.font = [UIFont systemFontOfSize:15];
    self.registerButton.layer.masksToBounds = YES;
    self.registerButton.layer.cornerRadius = 20;
    self.registerButton.backgroundColor = [ZMColor colorWithHexString:@"#55667D"];
    [self.registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [self.mainView addSubview:self.registerButton];
    [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(KMarginLeft);
        make.right.mas_equalTo(-KMarginLeft);
        make.top.mas_equalTo(self.passwordField.mas_bottom).with.offset(25);
        make.height.mas_equalTo(45);
    }];
    [self.registerButton addTarget:self action:@selector(clickRegisterButton:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 登录
- (void)clickRegisterButton:(UIButton *)btn{
    if (![self.userNameField.text stringByTrim].length) {
        [MBProgressHUD showPromptMessage:@"请输入用户名"];
        return;
    }
    if (![self.passwordField.text stringByTrim].length) {
        [MBProgressHUD showPromptMessage:@"请输入密码"];
        return;
    }
    NSString *username = self.userNameField.text;
    NSString *password = self.passwordField.text;
    
    
    
    if (username.length && password.length) {
        AVUser *user = [AVUser user];
        user.username = username;
        user.password = password;
        
//        //尝试添加头像字段
//        UIImage *head = [UIImage imageNamed:@"launch_bottom_gacha_logo"];
//        NSData *headData = UIImagePNGRepresentation(head);
//        [user setObject:headData forKey:@"thumb"];
        
        [MBProgressHUD showMessage:@"正在注册..." toView:self];
        
        WEAKSELF;
        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            [MBProgressHUD hideAllHUDsForView:weakSelf animated:YES];
            [weakSelf endEditing:YES];
            if (succeeded) {
                [MBProgressHUD showPromptMessage:@"注册成功,请手动登录"];
                [weakSelf.viewController.navigationController popViewControllerAnimated:YES];
            }else if (error){
                NSDictionary *dic = error.userInfo;
                NSLog(@"注册失败 %@", error);
                [MBProgressHUD showPromptMessage:dic[@"error"]];
            }
        }];
    }
}

#pragma mark - 退出页面
- (void)clickLeftButton:(UIButton *)btn{
    btn.enabled = NO;
    [self.viewController.navigationController popViewControllerAnimated:YES];
}

@end
