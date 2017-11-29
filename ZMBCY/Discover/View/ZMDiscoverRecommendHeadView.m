//
//  ZMDiscoverRecommendHeadView.m
//  ZMBCY
//
//  Created by Brance on 2017/11/26.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "ZMDiscoverRecommendHeadView.h"

@interface ZMDiscoverRecommendHeadView()

/** 容器 */
@property (nonatomic, strong)UIView       *mainView;
/** 图标 */
@property (nonatomic, strong)UIImageView  *iconImageView;
/** 文字 */
@property (nonatomic, strong)UILabel      *titleLabel;
/** 布局按钮 */
@property (nonatomic, strong) UIButton    *styleButton;

@end

@implementation ZMDiscoverRecommendHeadView

- (instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = [ZMColor appGraySpaceColor];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [ZMColor appGraySpaceColor];
    }
    return self;
}

- (UIView *)mainView{
    if (!_mainView) {
        self.mainView = [[UIView alloc] init];
        self.mainView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.mainView];
        [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.top.mas_equalTo(2);
        }];
        [self.mainView.superview layoutIfNeeded];
    }
    return _mainView;
}

- (UIImageView *)iconImageView{
    if (!_iconImageView) {
        _iconImageView = [UIImageView new];
        _iconImageView.image = placeholderFailImage;
        [self.mainView addSubview:_iconImageView];
        [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(20, 20));
            make.centerY.mas_equalTo(self.mainView);
            make.left.mas_equalTo(10);
        }];
    }
    return _iconImageView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont systemFontOfSize:13];
        _titleLabel.textColor = [ZMColor blackColor];
        [self.mainView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.iconImageView.mas_right).with.offset(5);
            make.centerY.mas_equalTo(self.mainView);
        }];
    }
    return _titleLabel;
}

- (UIButton *)styleButton{
    if (!_styleButton) {
        _styleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _styleButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_styleButton setTitleColor:[ZMColor blackColor] forState:UIControlStateNormal];
        [_styleButton setTitleColor:[ZMColor blackColor] forState:UIControlStateSelected];
        [_styleButton setTitle:@"单列" forState:UIControlStateNormal];
        [_styleButton setTitle:@"双列" forState:UIControlStateSelected];
        [_styleButton addTarget:self action:@selector(clickChange:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.mainView addSubview:_styleButton];
        [_styleButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-5);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(30);
            make.centerY.mas_equalTo(self.mainView);
        }];
    }
    return _styleButton;
}

- (void)setIsShow:(BOOL)isShow{
    if (isShow) {
        self.styleButton.hidden = NO;
    }else{
        self.styleButton.hidden = YES;
    }
}

#pragma mark - 切换布局
- (void)clickChange:(UIButton *)btn{
    btn.selected = !btn.selected;
    if (self.changeStyleBlock) {
        self.changeStyleBlock(btn.selected);
    }
}

- (void)setupUI:(NSString *)text{
    self.titleLabel.text = text;
}

@end
