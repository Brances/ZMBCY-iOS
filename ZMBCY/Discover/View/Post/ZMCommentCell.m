//
//  ZMCommentCell.m
//  ZMBCY
//
//  Created by Brance on 2017/12/28.
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

- (ZMCommentCellContent *)content{
    if (!_content) {
        _content = [ZMCommentCellContent new];
        [self.mainView addSubview:_content];
        [_content mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.userOperationView.thumbImageView.mas_right).with.offset(10);
            make.right.mas_equalTo(-20);
            make.top.mas_equalTo(self.userOperationView.mas_bottom).with.offset(0);
        }];
        [_content.superview layoutIfNeeded];
    }
    return _content;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.width = kScreenWidth;
        //self.contentView.width = kScreenWidth;
    }
    return self;
}

- (void)setModel:(ZMCommentModel *)model{
    if (model) {
        _model = model;
        self.userOperationView.likeImageView.hidden = NO;
        [self.userOperationView.thumbImageView setImageWithURL:[NSURL URLWithString:model.avatarFullUrl] placeholder:placeholderAvatarImage];
        
        //此处判断是回复帖子还是回复评论
        NSMutableAttributedString *text = nil;
        if (model.atnickname.length) {
            NSString *atStr = [NSString stringWithFormat:@" 回复了:%@",model.atnickname];
            text = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",model.nickname,atStr]];
            text.font = [UIFont systemFontOfSize:13];
            [text setColor:[ZMColor appSubColor] range:NSMakeRange(0, model.nickname.length)];
            [text setColor:[ZMColor appSupportColor] range:NSMakeRange(model.nickname.length, atStr.length)];
            
        }else{
            text = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",model.nickname]];
            text.color = [ZMColor appSubColor];
            text.font = [UIFont systemFontOfSize:13];
        }
        
        self.userOperationView.nameLabel.attributedText = text;
        self.userOperationView.creatTimeLabel.text = model.createTimeString;
        if (model.likeCount) {
            self.userOperationView.likeCountLabel.text = [NSString stringWithFormat:@"%ld",(long)model.likeCount];
        }else{
            self.userOperationView.likeCountLabel.text = @"";
        }
        self.userOperationView.likeImageView.selected = model.hasLiked;
        self.content.contentLabel.textLayout = model.contentLayout;
        self.content.contentLabel.height = model.contentHeight;
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
            make.top.right.mas_equalTo(0);
            make.left.mas_equalTo(12);
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
            make.bottom.mas_equalTo(self.mas_bottom).with.offset(-5);
        }];
    }
    return _thumbImageView;
}

- (YYLabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [YYLabel new];
        _nameLabel.textColor = [ZMColor appSubColor];
        _nameLabel.font = [UIFont systemFontOfSize:13];
        [self.mainView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.thumbImageView.mas_right).with.offset(10);
            make.top.mas_equalTo(self.thumbImageView.mas_top).with.offset(0);
            make.right.mas_equalTo(self.likeImageView.mas_left).with.offset(-20);
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
        _likeCountLabel.font = [UIFont systemFontOfSize:10];
        [self.mainView addSubview:_likeCountLabel];
        [_likeCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-KMarginRight);
            make.centerY.mas_equalTo(self.nameLabel);
        }];
    }
    return _likeCountLabel;
}

- (UIButton *)likeImageView{
    if (!_likeImageView) {
        _likeImageView = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *image = [UIImage imageNamed:@"postDetail_comment_notSupport~iphone"];
        [_likeImageView setImage:image forState:UIControlStateNormal];
        [_likeImageView setImage:[UIImage imageNamed:@"postDetail_comment_supported~iphone"] forState:UIControlStateSelected];
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


@implementation ZMCommentCellContent

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

- (YYLabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [YYLabel new];
        //_contentLabel.width = kScreenWidth - 52 - 20;
        _contentLabel.width = self.mainView.width;
        _contentLabel.x = 0;
        _contentLabel.y = 0;
        _contentLabel.fadeOnAsynchronouslyDisplay = YES;
        _contentLabel.textColor = [ZMColor blackColor];
        _contentLabel.font = [UIFont systemFontOfSize:15];
        [self.mainView addSubview:_contentLabel];
    }
    return _contentLabel;
}

@end

