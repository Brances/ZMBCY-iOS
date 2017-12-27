//
//  ZMPostDetailViewCell.m
//  ZMBCY
//
//  Created by ZOMAKE on 2017/12/26.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "ZMPostDetailViewCell.h"

@implementation ZMPostDetailViewCell


@end


@implementation ZMPostDetailViewUserInfoCell

- (UIView *)mainView{
    if (!_mainView) {
        _mainView = [UIView new];
        _mainView.backgroundColor = [ZMColor whiteColor];
        [self.contentView addSubview:_mainView];
        [_mainView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(0);
            make.bottom.mas_offset(0);
        }];
        [_mainView.superview layoutIfNeeded];
    }
    return _mainView;
}

- (UIImageView *)thumbImageView{
    if (!_thumbImageView) {
        _thumbImageView = [UIImageView new];
        _thumbImageView.layer.cornerRadius = 40 * 0.5;
        _thumbImageView.layer.masksToBounds = YES;
        [self.mainView addSubview:_thumbImageView];
        [_thumbImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(12);
            make.centerY.mas_equalTo(self.mainView);
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }];
    }
    return _thumbImageView;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.textColor = [ZMColor blackColor];
        _nameLabel.font = [UIFont systemFontOfSize:15];
        [self.mainView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.thumbImageView.mas_right).with.offset(10);
            make.top.mas_equalTo(self.thumbImageView.mas_top).with.offset(2);
            make.right.mas_equalTo(self.followButton.mas_left).with.offset(-20);
        }];
    }
    return _nameLabel;
}

- (UILabel *)creatTimeLabel{
    if (!_creatTimeLabel) {
        _creatTimeLabel = [UILabel new];
        _creatTimeLabel.textColor = [ZMColor appSupportColor];
        _creatTimeLabel.font = [UIFont systemFontOfSize:13];
        [self.mainView addSubview:_creatTimeLabel];
        [_creatTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.nameLabel);
            make.bottom.mas_equalTo(self.thumbImageView.mas_bottom).with.offset(-2);
        }];
    }
    return _creatTimeLabel;
}

- (UILabel *)circleNameLabel{
    if (!_circleNameLabel) {
        _circleNameLabel = [UILabel new];
        _circleNameLabel.textColor = [ZMColor appSubBlueColor];
        _circleNameLabel.font = [UIFont systemFontOfSize:13];
        [self.mainView addSubview:_circleNameLabel];
        [_circleNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.creatTimeLabel.mas_right).with.offset(5);
            make.centerY.mas_equalTo(self.creatTimeLabel);
            make.right.mas_equalTo(self.followButton.mas_left).with.offset(-20);
        }];
    }
    return _circleNameLabel;
}

- (UIButton *)followButton{
    if (!_followButton) {
        _followButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _followButton.layer.masksToBounds = YES;
        _followButton.layer.cornerRadius = 3;
        _followButton.backgroundColor = [ZMColor whiteColor];
        _followButton.layer.borderColor = [ZMColor appMainColor].CGColor;
        _followButton.layer.borderWidth = 1;
        [_followButton setTitle:@"关注" forState:UIControlStateNormal];
        [_followButton setTitleColor:[ZMColor appMainColor] forState:UIControlStateNormal];
        _followButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.mainView addSubview:_followButton];
        [_followButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(65);
            make.height.mas_equalTo(32);
            make.right.mas_equalTo(-12);
            make.centerY.mas_equalTo(self.thumbImageView);
        }];
    }
    return _followButton;
}

- (UIImageView *)bottomLine{
    if (!_bottomLine) {
        _bottomLine = [[UIImageView alloc] initWithImage:[YYImage imageWithColor:[ZMColor appBottomLineColor]]];
        [self.mainView addSubview:_bottomLine];
        [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(12);
            make.right.mas_equalTo(-12);
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(0.5);
        }];
        
    }
    return _bottomLine;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [ZMColor whiteColor];
        [self bottomLine];
    }
    return self;
}

- (void)setModel:(ZMPostDetailModel *)model{
    if (model) {
        _model = model;
        [self.thumbImageView setImageWithURL:[NSURL URLWithString:model.avatarFullUrl] placeholder:placeholderAvatarImage];
        self.nameLabel.text = model.authorNickName;
        self.creatTimeLabel.text = model.createTimeString;
        self.circleNameLabel.text = model.circleName;
    }
}

@end


@implementation ZMPostDetailViewTextContentCell

- (UIView *)mainView{
    if (!_mainView) {
        _mainView = [UIView new];
        _mainView.backgroundColor = [ZMColor whiteColor];
        [self.contentView addSubview:_mainView];
        [_mainView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(0);
            make.bottom.mas_offset(0);
        }];
        [_mainView.superview layoutIfNeeded];
    }
    return _mainView;
}

- (YYLabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [YYLabel new];
        _nameLabel.displaysAsynchronously = YES;
        _nameLabel.ignoreCommonProperties = YES;
        _nameLabel.fadeOnAsynchronouslyDisplay = NO;
        _nameLabel.x = 10;
        _nameLabel.y = 0;
        _nameLabel.width = kScreenWidth - 20;
        [self.mainView addSubview:_nameLabel];
    }
    return _nameLabel;
}

- (void)setModel:(ZMPostDetailModel *)model{
    if (model.richText.length) {
        self.nameLabel.textLayout = model.richTextLayout;
        self.nameLabel.height = model.richTextHeight;
    }
}

@end

@implementation ZMPostDetailViewImageListCell

- (UIView *)mainView{
    if (!_mainView) {
        _mainView = [UIView new];
        _mainView.backgroundColor = [ZMColor whiteColor];
        [self.contentView addSubview:_mainView];
        [_mainView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(0);
            make.bottom.mas_offset(0);
        }];
    }
    return _mainView;
}

- (NSMutableArray *)imagesArray{
    if (!_imagesArray) {
        _imagesArray = [NSMutableArray new];
    }
    return _imagesArray;
}

- (void)setModel:(ZMPostDetailModel *)model{
    if (!model.downloadImgInfos.count) return;
    CGFloat imageCell=0;
    for (int i = 1; i <= model.downloadImgInfos.count; i++) {
        ZMImageView *image = [self viewWithTag:i * 10];
        CGFloat height=0;
        height = kScreenWidth * [model.downloadImgInfos objectAtIndex:i-1].height / [model.downloadImgInfos objectAtIndex:i-1].width;
        if (!image) {
            image = [ZMImageView new];
            image.tag = i * 10;
            image.x = 0;
            image.y = imageCell;
            image.width = kScreenWidth;
            image.height = height;
            imageCell = imageCell + height + 5;
            [self.mainView addSubview:image];
        }
        
        NSString *url = [NSString stringWithFormat:@"%@%@?imageView&axis=5_0&enlarge=1&quality=75&thumbnail=%.0fy%.0f&type=webp",HttpImageURLPre,[model.imagesID objectAtIndex:i-1],kScreenWidth,height];
        //[image setImageWithURL:[NSURL URLWithString:url] placeholder:placeholderFailImage];
        [image setAnimationLoadingImage:[NSURL URLWithString:url] placeholder:placeholderFailImage];
    }
    
}

- (void)setupUI:(NSString *)url tag:(NSInteger)tag{
    UIImageView *image = [UIImageView new];
    image.tag = tag;
    [self.mainView addSubview:image];
    image.layer.borderColor = [ZMColor appSubBlueColor].CGColor;
    image.layer.borderWidth = 0.5;
}

@end

@implementation ZMPostDetailViewTagCell

- (UIView *)mainView{
    if (!_mainView) {
        _mainView = [UIView new];
        _mainView.backgroundColor = [ZMColor whiteColor];
        [self.contentView addSubview:_mainView];
        [_mainView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(0);
            make.bottom.mas_offset(0);
        }];
    }
    return _mainView;
}

- (ZMDiscoverArticleTagView *)tagView{
    if (!_tagView) {
        _tagView = [[ZMDiscoverArticleTagView alloc] init];
        _tagView.size = CGSizeMake(kScreenWidth - 24, 60);
        _tagView.y = 0;
        _tagView.x = 12;
        _tagView.backgroundColor = [ZMColor whiteColor];
        [self.mainView addSubview:_tagView];
    }
    return _tagView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [ZMColor whiteColor];
    }
    return self;
}

- (void)setModel:(ZMPostDetailModel *)model{
    if (model.tags.count) {
        _model = model;
        [self.tagView setPostButton:model.tags];
    }
}

@end
