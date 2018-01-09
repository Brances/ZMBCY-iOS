//
//  ZMMineLoginViewCell.m
//  ZMBCY
//
//  Created by ZOMAKE on 2018/1/8.
//  Copyright © 2018年 Brance. All rights reserved.
//

#import "ZMMineLoginViewCell.h"
#import "BaseNavigationController.h"
#import "ZMProfileViewController.h"

@implementation ZMMineLoginViewCell

- (UIView *)mainView{
    if (!_mainView) {
        self.mainView = [[UIView alloc] init];
        self.mainView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.mainView];
        [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(-5);
        }];
    }
    return _mainView;
}

- (ZMMineProFileView *)profileView{
    if (!_profileView) {
        _profileView = [ZMMineProFileView new];
        _profileView.userInteractionEnabled = YES;
        UITapGestureRecognizer *ger = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickProfile)];
        [self.mainView addSubview:_profileView];
        [_profileView addGestureRecognizer:ger];
        [_profileView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(70);
        }];
    }
    return _profileView;
}

- (ZMMineLoginView *)loginView{
    if (!_loginView) {
        _loginView = [ZMMineLoginView new];
        [self.mainView addSubview:_loginView];
        [_loginView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(self.profileView.mas_bottom).with.offset(10);
            make.height.mas_equalTo(55);
        }];
    }
    return _loginView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [ZMColor appGraySpaceColor];
    }
    return self;
}

- (void)setupUI{
    if ([ZMUserInfo shareUserInfo].isLogin) {
//        [self.profileView.thumbImageView setImageWithURL:[NSURL URLWithString:[ZMUserInfo shareUserInfo].thumb] placeholder:placeholderAvatarImage];
        //获取缩略图
        AVFile *file = [AVFile fileWithURL:[ZMUserInfo shareUserInfo].thumb];
        WEAKSELF;
        [file getThumbnail:YES width:100 height:100 withBlock:^(UIImage *image, NSError *error) {
            weakSelf.profileView.thumbImageView.image = image;
        }];
        
        self.profileView.nickNameLabel.text = [ZMUserInfo shareUserInfo].userName;
        self.profileView.sexImageView.hidden = NO;
        if ([ZMUserInfo shareUserInfo].sex == 1) {
            self.profileView.sexImageView.image = [UIImage imageNamed:@"icon_female"];
        }else if ([ZMUserInfo shareUserInfo].sex == 2) {
            self.profileView.sexImageView.image = [UIImage imageNamed:@"icon_male"];
        }else{
            self.profileView.sexImageView.image = [UIImage imageNamed:@"icon_et"];
        }
        self.profileView.signLabel.text = [ZMUserInfo shareUserInfo].signature.length ? [ZMUserInfo shareUserInfo].signature : @"谜之签名不见了";
        self.loginView.loginButton.hidden = YES;
        self.loginView.registerButton.hidden = YES;
        self.loginView.mainView.hidden = NO;
        self.loginView.albumCountLabel.text = @"0";
        self.loginView.followCountLabel.text = @"0";
        self.loginView.fansCountLabel.text = @"0";
        self.loginView.lineLabel1.hidden = NO;
        self.loginView.lineLabel2.hidden = NO;
    }else{
        self.profileView.thumbImageView.image = placeholderAvatarImage;
        self.profileView.nickNameLabel.text = @"未登录";
        self.profileView.sexImageView.hidden = YES;
        self.profileView.signLabel.text = @"GACHA一下，突破异次元";
        self.loginView.loginButton.hidden = NO;
        self.loginView.registerButton.hidden = NO;
        self.loginView.mainView.hidden = YES;
        
    }
}

#pragma mark - 个人资料
- (void)clickProfile{
    if ([ZMUserInfo shareUserInfo].isLogin) {
        ZMProfileViewController *vc = [[ZMProfileViewController alloc] init];
        [self.viewController.navigationController pushViewController:vc animated:YES];
    }
}

@end


@implementation ZMMineProFileView

- (UIView *)mainView{
    if (!_mainView) {
        self.mainView = [[UIView alloc] init];
        self.mainView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.mainView];
        [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.top.mas_equalTo(0);
        }];
    }
    return _mainView;
}

- (UIImageView *)thumbImageView{
    if (!_thumbImageView) {
        _thumbImageView = [UIImageView new];
        _thumbImageView.layer.masksToBounds = YES;
        _thumbImageView.layer.cornerRadius =  70 * 0.5;
        [self.mainView addSubview:_thumbImageView];
        [_thumbImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.centerY.mas_equalTo(self.mainView);
            make.width.mas_equalTo(70);
            make.height.mas_equalTo(70);
        }];
    }
    return _thumbImageView;
}

- (UIImageView *)sexImageView{
    if (!_sexImageView) {
        _sexImageView = [UIImageView new];
        UIImage *image = [UIImage imageNamed:@"icon_et"];
        [self.mainView addSubview:_sexImageView];
        [_sexImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(image.size);
            make.right.mas_equalTo(self.thumbImageView.mas_right);
            make.bottom.mas_equalTo(self.thumbImageView.mas_bottom);
        }];
    }
    return _sexImageView;
}

-(UIImageView *)rightArrow{
    if (!_rightArrow) {
        _rightArrow = [UIImageView new];
        UIImage *image = [UIImage imageNamed:@"postDetail_arrow~iphone"];
        _rightArrow.image = image;
        [self.mainView addSubview:_rightArrow];
        [_rightArrow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(image.size);
            make.right.mas_equalTo(-20);
            make.centerY.mas_equalTo(self.mainView);
        }];
    }
    return _rightArrow;
}

- (UILabel *)nickNameLabel{
    if (!_nickNameLabel) {
        _nickNameLabel = [UILabel new];
        _nickNameLabel.font = [UIFont systemFontOfSize:18];
        _nickNameLabel.textColor = [ZMColor blackColor];
        [self.mainView addSubview:_nickNameLabel];
        [_nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.thumbImageView.mas_right).with.offset(10);
            make.bottom.mas_equalTo(self.mainView.mas_centerY).with.offset(-2);
            make.right.mas_equalTo(self.rightArrow.mas_left).with.offset(-20);
        }];
    }
    return _nickNameLabel;
}

- (UILabel *)signLabel{
    if (!_signLabel) {
        _signLabel = [UILabel new];
        _signLabel.font = [UIFont systemFontOfSize:13];
        _signLabel.textColor = [ZMColor appSupportColor];
        [self.mainView addSubview:_signLabel];
        [_signLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.thumbImageView.mas_right).with.offset(10);
            make.top.mas_equalTo(self.nickNameLabel.mas_bottom).with.offset(5);
            make.right.mas_equalTo(self.rightArrow.mas_left).with.offset(-20);
        }];
    }
    return _signLabel;
}

@end

@implementation ZMMineLoginView

- (UIButton *)loginButton{
    if (!_loginButton) {
        _loginButton= [UIButton buttonWithType:UIButtonTypeCustom];
        _loginButton.titleLabel.font = [UIFont systemFontOfSize:15];
        _loginButton.layer.masksToBounds = YES;
        _loginButton.layer.cornerRadius = 3;
        _loginButton.backgroundColor = [ZMColor appMainColor];
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [_loginButton setTitleColor:[ZMColor whiteColor] forState:UIControlStateNormal];
        [self addSubview:_loginButton];
        [_loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.right.mas_equalTo(self.mas_centerX).with.offset(-2);
            make.height.mas_equalTo(40);
            make.centerY.mas_equalTo(self);
        }];
        [_loginButton addTarget:self action:@selector(clickLoginButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}

- (UIButton *)registerButton{
    if (!_registerButton) {
        _registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _registerButton.titleLabel.font = [UIFont systemFontOfSize:15];
        _registerButton.layer.masksToBounds = YES;
        _registerButton.layer.cornerRadius = 3;
        _registerButton.layer.borderColor = [ZMColor appMainColor].CGColor;
        _registerButton.layer.borderWidth = 0.5;
        _registerButton.backgroundColor = [ZMColor whiteColor];
        [_registerButton setTitle:@"注册" forState:UIControlStateNormal];
        [_registerButton setTitleColor:[ZMColor appMainColor] forState:UIControlStateNormal];
        [self addSubview:_registerButton];
        [_registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-20);
            make.left.mas_equalTo(self.mas_centerX).with.offset(2);
            make.height.mas_equalTo(40);
            make.centerY.mas_equalTo(self);
        }];
        [_registerButton addTarget:self action:@selector(clickRegisterButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerButton;
}

- (UIView *)mainView{
    if (!_mainView) {
        self.mainView = [[UIView alloc] init];
        self.mainView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.mainView];
        [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.top.mas_equalTo(0);
        }];
        [_mainView.superview layoutIfNeeded];
    }
    return _mainView;
}

- (UILabel *)albumLabel{
    if (!_albumLabel) {
        _albumLabel = [UILabel new];
        _albumLabel.textAlignment = NSTextAlignmentCenter;
        _albumLabel.textColor = [ZMColor appSupportColor];
        _albumLabel.font = [UIFont systemFontOfSize:13];
        _albumLabel.text = @"相册";
        [self.mainView addSubview:_albumLabel];
        [_albumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(kScreenWidth/3);
            make.left.mas_equalTo(0);
            make.height.mas_equalTo(15);
            make.top.mas_equalTo((self.mainView.height - 15 * 2 - 5)/2);
        }];
    }
    return _albumLabel;
}

- (UILabel *)albumCountLabel{
    if (!_albumCountLabel) {
        _albumCountLabel = [UILabel new];
        _albumCountLabel.textAlignment = NSTextAlignmentCenter;
        _albumCountLabel.font = [UIFont systemFontOfSize:13];
        _albumCountLabel.textColor = [ZMColor blackColor];
        _albumCountLabel.text = @"0";
        [self.mainView addSubview:_albumCountLabel];
        [_albumCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.albumLabel);
            make.top.mas_equalTo(self.albumLabel.mas_bottom).with.offset(5);
        }];
    }
    return _albumCountLabel;
}

- (UILabel *)followLabel{
    if (!_followLabel) {
        _followLabel = [UILabel new];
        _followLabel.textAlignment = NSTextAlignmentCenter;
        _followLabel.textColor = [ZMColor appSupportColor];
        _followLabel.font = [UIFont systemFontOfSize:13];
        _followLabel.text = @"关注";
        [self.mainView addSubview:_followLabel];
        [_followLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(kScreenWidth/3);
            make.left.mas_equalTo(kScreenWidth/3);
            make.height.mas_equalTo(15);
            make.top.mas_equalTo((self.mainView.height - 15 * 2 - 5)/2);
        }];
    }
    return _followLabel;
}

- (UILabel *)followCountLabel{
    if (!_followCountLabel) {
        _followCountLabel = [UILabel new];
        _followCountLabel.textAlignment = NSTextAlignmentCenter;
        _followCountLabel.font = [UIFont systemFontOfSize:13];
        _followCountLabel.textColor = [ZMColor blackColor];
        [self.mainView addSubview:_followCountLabel];
        [_followCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.followLabel);
            make.top.mas_equalTo(self.followLabel.mas_bottom).with.offset(5);
        }];
    }
    return _followCountLabel;
}

- (UILabel *)fansLabel{
    if (!_fansLabel) {
        _fansLabel = [UILabel new];
        _fansLabel.textAlignment = NSTextAlignmentCenter;
        _fansLabel.textColor = [ZMColor appSupportColor];
        _fansLabel.font = [UIFont systemFontOfSize:13];
        _fansLabel.text = @"粉丝";
        [self.mainView addSubview:_fansLabel];
        [_fansLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(kScreenWidth/3);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(15);
            make.top.mas_equalTo((self.mainView.height - 15 * 2 - 5)/2);
        }];
    }
    return _fansLabel;
}

- (UILabel *)fansCountLabel{
    if (!_fansCountLabel) {
        _fansCountLabel = [UILabel new];
        _fansCountLabel.textAlignment = NSTextAlignmentCenter;
        _fansCountLabel.font = [UIFont systemFontOfSize:13];
        _fansCountLabel.textColor = [ZMColor blackColor];
        [self.mainView addSubview:_fansCountLabel];
        [_fansCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.fansLabel);
            make.top.mas_equalTo(self.fansLabel.mas_bottom).with.offset(5);
        }];
    }
    return _fansCountLabel;
}

- (UILabel *)lineLabel1{
    if (!_lineLabel1) {
        _lineLabel1 = [UILabel new];
        _lineLabel1.backgroundColor = [ZMColor appSupportColor];
        [self.mainView addSubview:_lineLabel1];
        [self.mainView bringSubviewToFront:_lineLabel1];
        [_lineLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(0.5);
            make.height.mas_equalTo(10);
            make.centerY.mas_equalTo(self.mainView);
            make.left.mas_equalTo(kScreenWidth/3);
        }];
    }
    return _lineLabel1;
}

- (UILabel *)lineLabel2{
    if (!_lineLabel2) {
        _lineLabel2 = [UILabel new];
        _lineLabel2.backgroundColor = [ZMColor appSupportColor];
        [self.mainView addSubview:_lineLabel2];
        [self.mainView bringSubviewToFront:_lineLabel2];
        [_lineLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(0.5);
            make.height.mas_equalTo(10);
            make.centerY.mas_equalTo(self.mainView);
            make.left.mas_equalTo(kScreenWidth/3*2);
        }];
    }
    return _lineLabel2;
}

#pragma mark - 跳转登录
- (void)clickLoginButton:(UIButton *)btn{
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

@end

@implementation ZMMineCollectionViewCell

- (UIView *)mainView{
    if (!_mainView) {
        self.mainView = [[UIView alloc] init];
        self.mainView.backgroundColor = [ZMColor appGraySpaceColor];
        [self.contentView addSubview:self.mainView];
        [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.top.mas_equalTo(0);
        }];
        [_mainView.superview layoutIfNeeded];
    }
    return _mainView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [ZMColor appGraySpaceColor];
        [self setupUI];
    }
    return self;
}

#pragma mark - UI初始化
- (void)setupUI{

    NSArray *textArray = @[@"我的话题",@"我的订阅",@"我的连载",@"我的G单",@"我要印周边",@"草稿箱"];
    NSArray *imageArray = @[@"personal_center_mytopic",
                           @"personal_subscribe",
                           @"personal_serial",
                           @"personal_center_GList",
                           @"personal_center_yinpin",
                           @"personal_center_drafts"
                           ];
    CGFloat width = (kScreenWidth - 1)/3;
    CGFloat height = 100;
    //UIImage *image = [UIImage imageNamed:[imageArray firstObject]];
    
    for (int i = 1; i <= textArray.count; i++) {
        UIButton *btn = [self viewWithTag:i*10];
        if (!btn) {
            btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.backgroundColor = [ZMColor whiteColor];
            btn.titleLabel.font = [UIFont systemFontOfSize:13];
            [btn setTitle:[textArray objectAtIndex:i-1] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:[imageArray objectAtIndex:i-1]] forState:UIControlStateNormal];
            [btn setTitleColor:[ZMColor appSupportColor] forState:UIControlStateNormal];
            [self.mainView addSubview:btn];
            btn.adjustsImageWhenHighlighted = NO;
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(((i-1)%3) * (width+0.5));
                make.width.mas_equalTo(width);
                make.height.mas_equalTo(height);
                make.top.mas_equalTo((i-1)/3 * (height+0.5));
            }];
            [btn.superview layoutIfNeeded];
            
            //文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
            [btn setTitleEdgeInsets:UIEdgeInsetsMake((btn.imageView.frame.size.height + 5 + (btn.height - btn.imageView.size.height - btn.titleLabel.size.height))*0.5 ,-btn.imageView.frame.size.width, 0.0,0.0)];
            //图片距离右边框距离减少图片的宽度，其它不变
            [btn setImageEdgeInsets:UIEdgeInsetsMake(-btn.titleLabel.frame.size.height-5, (btn.width - btn.imageView.size.width) * 0.5,0.0, 0.0)];
            [btn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
}

#pragma mark - 按钮
- (void)clickButton:(UIButton *)btn{
    //NSInteger tag = btn.tag;
    NSString *string = btn.titleLabel.text;
    [MBProgressHUD showPromptMessage:string];
}

@end

