//
//  ZMHomeView.m
//  ZMBCY
//
//  Created by ZOMAKE on 2018/1/5.
//  Copyright © 2018年 Brance. All rights reserved.
//

#import "ZMHomeView.h"
#import "BaseNavigationController.h"
#import "ZMLoginViewController.h"
#import "ZMRegisterViewController.h"

@interface ZMHomeView()


@end

@implementation ZMHomeView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [ZMColor appGraySpaceColor];
        //[self setupUI];
    }
    return self;
}

- (void)setupUI{
    
    UIImage *image = [UIImage imageNamed:@"news_feed_visitor_login"];
    self.topImageView = [UIImageView new];
    self.topImageView.image = image;
    [self addSubview:self.topImageView];
    [self.topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(image.size);
        make.top.mas_equalTo(self.nav.mas_bottom).with.offset(40);
        make.centerX.mas_equalTo(self);
    }];
    
    self.tipLabel = [UILabel new];
    self.tipLabel.textAlignment = NSTextAlignmentCenter;
    self.tipLabel.font = [UIFont systemFontOfSize:15];
    self.tipLabel.text = @"登录开启GACHA之旅~";
    self.tipLabel.textColor = [ZMColor appSupportColor];
    [self addSubview:self.tipLabel];
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self.topImageView.mas_bottom).with.offset(30);
    }];
    
    self.loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.loginButton.layer.cornerRadius = 3;
    self.loginButton.layer.masksToBounds = YES;
    self.loginButton.backgroundColor = [ZMColor appMainColor];
    self.loginButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [self.loginButton setTitleColor:[ZMColor whiteColor] forState:UIControlStateNormal];
    [self addSubview:self.loginButton];
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_centerX).with.offset(-5);
        make.width.mas_equalTo(125);
        make.height.mas_equalTo(45);
        make.top.mas_equalTo(self.tipLabel.mas_bottom).with.offset(60);
    }];
    [self.loginButton addTarget:self action:@selector(clickLoginButton:) forControlEvents:UIControlEventTouchUpInside];
    
    self.registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.registerButton.layer.cornerRadius = 3;
    self.registerButton.layer.masksToBounds = YES;
    self.registerButton.backgroundColor = [ZMColor whiteColor];
    self.registerButton.layer.borderColor = [ZMColor appMainColor].CGColor;
    self.registerButton.layer.borderWidth = 0.5;
    
    self.registerButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [self.registerButton setTitleColor:[ZMColor appMainColor] forState:UIControlStateNormal];
    [self addSubview:self.registerButton];
    [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_centerX).with.offset(5);
        make.width.mas_equalTo(125);
        make.height.mas_equalTo(45);
        make.top.mas_equalTo(self.tipLabel.mas_bottom).with.offset(60);
    }];
    [self.registerButton addTarget:self action:@selector(clickRegisterButton:) forControlEvents:UIControlEventTouchUpInside];
    
    if ([ZMUserInfo shareUserInfo].isLogin) {
        self.loginButton.hidden = YES;
        self.registerButton.hidden = YES;
    }else{
        self.loginButton.hidden = NO;
        self.registerButton.hidden = NO;
    }
    
}

- (void)setNav:(ZMNavView *)nav{
    _nav = nav;
    [self setupUI];
}

#pragma mark - 跳转登录
- (void)clickLoginButton:(UIButton *)btn{
    btn.enabled = NO;
    ZMLoginViewController *vc = [[ZMLoginViewController alloc] init];
    //如果登录视图需要push的话就需要包装导航控制器
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
    [self.viewController presentViewController:nav animated:YES completion:^{
        btn.enabled = YES;
    }];
}

#pragma mark - 跳转注册
- (void)clickRegisterButton:(UIButton *)btn{
    ZMRegisterViewController *vc = [[ZMRegisterViewController alloc] init];
    [self.viewController.navigationController pushViewController:vc animated:YES];
}

- (void)showUI:(BOOL)isLogin{
    if (isLogin) {
        self.loginButton.hidden = YES;
        self.registerButton.hidden = YES;
        self.tipLabel.text = [NSString stringWithFormat:@"%@!快开启GACHA之旅~",[ZMUserInfo shareUserInfo].userName];
    }else{
        self.loginButton.hidden = NO;
        self.registerButton.hidden = NO;
        self.tipLabel.text = [NSString stringWithFormat:@"登录开启GACHA之旅~"];
    }
}

@end
