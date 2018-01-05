//
//  ZMPostDetailBottomToolView.m
//  ZMBCY
//
//  Created by Brance on 2017/12/29.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "ZMPostDetailBottomToolView.h"

@implementation ZMPostDetailBottomToolView

- (UIView *)mainView{
    if (!_mainView) {
        self.mainView = [[UIView alloc] init];
        self.mainView.backgroundColor = [ZMColor colorWithHexString:@"#ffffff" alpha:0.5];
        [self addSubview:self.mainView];
        [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.top.mas_equalTo(0);
        }];
        [self.mainView.superview layoutIfNeeded];
    }
    return _mainView;
}

- (UIButton *)collectButton{
    if (!_collectButton) {
        _collectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _collectButton.adjustsImageWhenHighlighted = NO;
        UIImage *image = [UIImage imageNamed:@"postDetail_collect_default~iphone"];
        [_collectButton setImage:image forState:UIControlStateNormal];
        [_collectButton setImage:[UIImage imageNamed:@"postDetail_collect~iphone"] forState:UIControlStateSelected];
        [self.mainView addSubview:_collectButton];
        [_collectButton addTarget:self action:@selector(clickCollectButton:) forControlEvents:UIControlEventTouchUpInside];
        [_collectButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.commentButton.mas_left).with.offset(-30);
            make.size.mas_equalTo(image.size);
            make.centerY.mas_equalTo(self.mainView);
        }];
        [_collectButton.superview layoutIfNeeded];
    }
    return _collectButton;
}

- (UIButton *)praiseButton{
    if (!_praiseButton) {
        _praiseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _praiseButton.adjustsImageWhenHighlighted = NO;
        UIImage *image = [UIImage imageNamed:@"postDetail_support_default~iphone"];
        [_praiseButton setBackgroundImage:[UIImage imageNamed:@"postDetail_support_default_bg~iphone"] forState:UIControlStateNormal];
        [_praiseButton setBackgroundImage:[YYImage imageWithColor:[ZMColor clearColor]] forState:UIControlStateSelected];
        
        [_praiseButton setImage:image forState:UIControlStateNormal];
        [_praiseButton setImage:[UIImage imageNamed:@"postDetail_support~iphone"] forState:UIControlStateSelected];
        [self.mainView addSubview:_praiseButton];
        [_praiseButton addTarget:self action:@selector(clickPraiseButton:) forControlEvents:UIControlEventTouchUpInside];
        [_praiseButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(self.collectButton);
            make.centerY.mas_equalTo(self.mainView);
            make.left.mas_equalTo(self.commentButton.mas_right).with.offset(30);
        }];
    }
    return _praiseButton;
}

- (UIButton *)commentButton{
    if (!_commentButton) {
        _commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _commentButton.adjustsImageWhenHighlighted = NO;
        _commentButton.titleLabel.font = [UIFont systemFontOfSize:15];
        _commentButton.layer.masksToBounds = YES;
        _commentButton.layer.cornerRadius = 20;
        _commentButton.backgroundColor = [ZMColor appSubBlueColor];
        [_commentButton setTitleColor:[ZMColor whiteColor] forState:UIControlStateNormal];
        [self.mainView addSubview:_commentButton];
        [_commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(130);
            make.height.mas_equalTo(40);
            make.centerY.centerX.mas_equalTo(self.mainView);
        }];
    }
    return _commentButton;
}

- (UILabel *)praiseCountLabel{
    if (!_praiseCountLabel) {
        _praiseCountLabel = [UILabel new];
        _praiseCountLabel.textAlignment = NSTextAlignmentCenter;
        _praiseCountLabel.layer.cornerRadius = 6;
        _praiseCountLabel.layer.masksToBounds = YES;
        _praiseCountLabel.font = [UIFont systemFontOfSize:11];
        _praiseCountLabel.backgroundColor = [ZMColor colorWithHexString:@"#666666"];
        _praiseCountLabel.textColor = [ZMColor whiteColor];
        [self.praiseButton addSubview:_praiseCountLabel];
        [_praiseCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.praiseButton.mas_right).with.offset(-10);
            make.height.mas_equalTo(15);
            make.top.mas_equalTo(2);
        }];
    }
    return _praiseCountLabel;
}

- (void)setCount:(NSString *)count{
    if (count.length) {
        self.praiseCountLabel.text = count;
        [self.praiseCountLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo([NSString getTitleWidth:count withFontSize:11] + 10);
        }];
    }
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [ZMColor clearColor];
    }
    return self;
}

#pragma mark - 收藏
- (void)clickCollectButton:(UIButton *)btn{
    btn.selected = !btn.selected;
}
#pragma mark - 点赞
- (void)clickPraiseButton:(UIButton *)btn{
    btn.selected = !btn.selected;
    if (self.clickPraiseBlock) {
        self.clickPraiseBlock(btn.selected);
    }
}

@end
