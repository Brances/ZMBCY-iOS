//
//  ZMCommentCell.m
//  ZMBCY
//
//  Created by 卢洋 on 2017/12/28.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "ZMCommentCell.h"

@implementation ZMCommentCell

- (UIView *)mainView{
    if (!_mainView) {
        self.mainView = [[UIView alloc] init];
        self.mainView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.mainView];
        [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.top.mas_equalTo(0);
        }];
        [self.mainView.superview layoutIfNeeded];
    }
    return _mainView;
}

- (ZMCommentCellUserOperationView *)userOperationView{
    if (!_userOperationView) {
        _userOperationView = [ZMCommentCellUserOperationView new];
        [self.mainView addSubview:_userOperationView];
        [_userOperationView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(0);
            make.height.mas_equalTo(self.model.userOperationHeight);
        }];
    }
    return _userOperationView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}

- (void)setModel:(ZMCommentModel *)model{
    if (model) {
        _model = model;
        self.userOperationView.showTopLine = YES;
        self.userOperationView.likeImageView.hidden = NO;
        [self.userOperationView.thumbImageView setImageWithURL:[NSURL URLWithString:model.avatarFullUrl] placeholder:placeholderAvatarImage];
        self.userOperationView.nameLabel.text = model.nickname;
        self.userOperationView.creatTimeLabel.text = model.createTimeString;
        self.userOperationView.likeCountLabel.text = [NSString stringWithFormat:@"%ld",model.likeCount];
    }
}

@end

@implementation ZMCommentCellUserOperationView

- (UIView *)mainView{
    if (!_mainView) {
        self.mainView = [[UIView alloc] init];
        self.mainView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.mainView];
        [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.top.mas_equalTo(0);
        }];
        [self.mainView.superview layoutIfNeeded];
    }
    return _mainView;
}

- (UIImageView *)topLineImageView{
    if (!_topLineImageView) {
        _topLineImageView = [[UIImageView alloc] initWithImage:[YYImage imageWithColor:[ZMColor appBottomLineColor]]];
        [self.mainView addSubview:_topLineImageView];
        [_topLineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_equalTo(0);
            make.height.mas_equalTo(0.5);
        }];
    }
    return _topLineImageView;
}

- (void)setShowTopLine:(BOOL)showTopLine{
    self.topLineImageView.hidden = !showTopLine;
}

- (UIImageView *)thumbImageView{
    if (!_thumbImageView) {
        _thumbImageView = [UIImageView new];
        _thumbImageView.size = CGSizeMake(30, 30);
        _thumbImageView.layer.masksToBounds = YES;
        _thumbImageView.layer.cornerRadius = _thumbImageView.size.width * 0.5;
        _thumbImageView.layer.borderColor = [ZMColor appGraySpaceColor].CGColor;
        _thumbImageView.layer.borderWidth = 0.5;
        [self.mainView addSubview:_thumbImageView];
        [_thumbImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(_thumbImageView.size);
            make.left.mas_equalTo(KMarginLeft);
            make.bottom.mas_equalTo(0);
        }];
    }
    return _thumbImageView;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.textColor = [ZMColor appSubColor];
        _nameLabel.font = [UIFont systemFontOfSize:13];
        [self.mainView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.thumbImageView.mas_right).with.offset(10);
            make.top.mas_equalTo(self.thumbImageView.mas_top).with.offset(0);
        }];
    }
    return _nameLabel;
}

- (UILabel *)creatTimeLabel{
    if (!_creatTimeLabel) {
        _creatTimeLabel = [UILabel new];
        _creatTimeLabel.textColor = [ZMColor appSupportColor];
        _creatTimeLabel.font = [UIFont systemFontOfSize:11];
        [self.mainView addSubview:_creatTimeLabel];
        [_creatTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.nameLabel);
            make.top.mas_equalTo(self.nameLabel.mas_bottom).with.offset(2);
        }];
    }
    return _creatTimeLabel;
}

- (UILabel *)likeCountLabel{
    if (!_likeCountLabel) {
        _likeCountLabel = [UILabel new];
        _likeCountLabel.textColor = [ZMColor appSupportColor];
        _likeCountLabel.font = [UIFont systemFontOfSize:11];
        [self.mainView addSubview:_likeCountLabel];
        [_likeCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-KMarginRight);
            make.centerY.mas_equalTo(self.nameLabel);
        }];
    }
    return _likeCountLabel;
}

- (UIImageView *)likeImageView{
    if (!_likeImageView) {
        _likeImageView = [UIImageView new];
        UIImage *image = [UIImage imageNamed:@"ill_cos_like"];
        _likeImageView.image = image;
        [self.mainView addSubview:_likeImageView];
        [_likeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(image.size);
            make.centerY.mas_equalTo(self.likeCountLabel);
            make.right.mas_equalTo(self.likeCountLabel.mas_left).with.offset(-5);
        }];
    }
    return _likeImageView;
}


@end
