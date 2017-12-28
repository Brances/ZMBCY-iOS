//
//  ZMPostDetailViewCell.m
//  ZMBCY
//
//  Created by Brance on 2017/12/26.
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
    //用来存储所有图片总高度
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
        _tagView.size = CGSizeMake(kScreenWidth, 60);
        _tagView.y = 0;
        _tagView.x = 0;
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

@implementation ZMPostDetailViewPraiseCell

- (UIView *)mainView{
    if (!_mainView) {
        _mainView = [UIView new];
        _mainView.backgroundColor = [ZMColor whiteColor];
        [self.contentView addSubview:_mainView];
        [_mainView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.bottom.mas_offset(0);
            make.top.mas_equalTo(10);
        }];
        [_mainView.superview layoutIfNeeded];
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(0);
        }];
    }
    return _mainView;
}

- (UIImageView *)topLineImageView{
    if (!_topLineImageView) {
        _topLineImageView = [[UIImageView alloc] initWithImage:[YYImage imageWithColor:[ZMColor appBottomLineColor]]];
        [self.contentView addSubview:_topLineImageView];
        [_topLineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_equalTo(0);
            make.height.mas_equalTo(0.5);
        }];
    }
    return _topLineImageView;
}

- (UIImageView *)arrowImageView{
    if (!_arrowImageView) {
        _arrowImageView = [UIImageView new];
        UIImage *image = [UIImage imageNamed:@"postDetail_arrow~iphone"];
        _arrowImageView.image = image;
        [self.mainView addSubview:_arrowImageView];
        [_arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(image.size);
            make.right.mas_equalTo(-20);
            make.centerY.mas_equalTo(self.mainView);
        }];
    }
    return _arrowImageView;
}

- (UILabel *)praiseLabel{
    if (!_praiseLabel) {
        _praiseLabel = [UILabel new];
        _praiseLabel.font = [UIFont systemFontOfSize:13];
        _praiseLabel.textColor = [ZMColor appSupportColor];
        [self.mainView addSubview:_praiseLabel];
        [_praiseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.arrowImageView.mas_left).with.offset(-5);
            make.centerY.mas_equalTo(self.mainView);
            //高度可以注释
            //make.height.mas_equalTo(15);
        }];
        [_praiseLabel.superview layoutIfNeeded];
    }
    return _praiseLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [ZMColor appGraySpaceColor];
        [self topLineImageView];
        self.marginLeft = 0;
    }
    return self;
}

- (void)setModel:(ZMPostDetailModel *)model{
    if (model.supportArray.count) {
        _model = model;
        self.praiseLabel.text = [NSString stringWithFormat:@"%ld人喜欢",(long)model.supportCount];
        //这里必须更新字符串的宽度，不然这个UILabel 默认是获取不到宽度的
        [self.praiseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo([NSString getTitleWidth:self.praiseLabel.text withFontSize:13]);
        }];
        [self.praiseLabel.superview layoutIfNeeded];
        //循环次数
        NSInteger   count = model.supportArray.count < 10 ? model.supportArray.count : 10;
        for (int i = 1; i <= count; i++) {
            UIImageView *image = [self viewWithTag:i*10];
            if (!image) {
                //如果frame超过右边标签X值，则直接跳过
                if (self.marginLeft + 8 + 28 + 10 > self.praiseLabel.x) {
                    break;
                }
                image = [UIImageView new];
                image.backgroundColor = [ZMColor appMainColor];
                image.size = CGSizeMake(28, 28);
                image.layer.cornerRadius = image.size.width * 0.5;
                image.layer.masksToBounds = YES;
                image.tag = i * 10;
                image.centerY = self.mainView.centerY;
                
                [self.mainView addSubview:image];
                [image mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(12 + self.marginLeft);
                    make.size.mas_equalTo(image.size);
                    make.centerY.mas_equalTo(self.mainView);
                }];
                [image.superview layoutIfNeeded];
                self.marginLeft = self.marginLeft + image.size.width + 8;
            }
            ZMPostDetailPraiseAuthorModel *author = [model.supportArray safeObjectAtIndex:i-1];
            [image setImageWithURL:[NSURL URLWithString:author.avatarFullUrl] placeholder:placeholderAvatarImage];
        }
    }
}


@end

@implementation ZMPostDetailViewRelatedPostsCell

- (UIImageView *)topLineImageView{
    if (!_topLineImageView) {
        _topLineImageView = [[UIImageView alloc] initWithImage:[YYImage imageWithColor:[ZMColor appBottomLineColor]]];
        [self.contentView addSubview:_topLineImageView];
        [_topLineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_equalTo(0);
            make.height.mas_equalTo(0.5);
        }];
    }
    return _topLineImageView;
}


- (UIView *)mainView{
    if (!_mainView) {
        self.mainView = [[UIView alloc] init];
        self.mainView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.mainView];
        [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.top.mas_equalTo(10);
        }];
        [self.mainView.superview layoutIfNeeded];
    }
    return _mainView;
}

- (ZMPostDetailViewHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [ZMPostDetailViewHeaderView new];
        [self.mainView addSubview:_headerView];
        [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_equalTo(0);
            make.height.mas_equalTo(50);
        }];
    }
    return _headerView;
}

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.backgroundColor = [UIColor whiteColor];
        [self.mainView addSubview:_scrollView];
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.headerView.mas_bottom).with.offset(0);
            make.bottom.mas_equalTo(-15);
            make.left.mas_equalTo(0);
            make.width.mas_equalTo(kScreenWidth);
        }];
        [_scrollView.superview layoutIfNeeded];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.contentSize = CGSizeMake(_model.relatedPosts.count * [_model.relatedPosts firstObject].cover.realWidth + 24 + (_model.relatedPosts.count - 1) * 8, 0);
    }
    return _scrollView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [ZMColor appGraySpaceColor];
        [self topLineImageView];
        ZMDiscoverHeadModel *HeadModel = [[ZMDiscoverHeadModel alloc] init];
        HeadModel.title = @"猜你喜欢";
        HeadModel.icon  = [YYImage imageNamed:@"postDetail_recommendIcon~iphone"];
        self.headerView.model = HeadModel;
        self.headerView.titleLabel.textColor = [ZMColor appSupportColor];
    }
    return self;
}

#pragma mark - 设置猜你喜欢数据
- (void)setModel:(ZMPostDetailModel *)model{
    if (model.relatedPosts.count) {
        _model = model;
        //循环次数
        NSInteger  count = model.relatedPosts.count > 5 ? 5 : model.relatedPosts.count;
        CGFloat width=0,height=0;
        
        width =   [model.relatedPosts firstObject].cover.realWidth;
        height =  [model.relatedPosts firstObject].cover.realHeight;
        
        for (int i = 1; i <= count; i++) {
            UIImageView *image = [self viewWithTag:i*10];
            if (!image) {
                image = [UIImageView new];
                image.backgroundColor = [ZMColor appMainColor];
                image.size = CGSizeMake(width, height);
                image.layer.masksToBounds = YES;
                image.layer.cornerRadius = 2;
                image.tag = i * 10;
                [self.scrollView addSubview:image];
                
                if (i == 1) {
                    [image mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.mas_equalTo(12);
                        make.width.mas_equalTo(width);
                        make.height.mas_equalTo(self.scrollView.height);
                        make.centerY.mas_equalTo(self.scrollView);
                    }];
                }else{
                    [image mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.mas_equalTo((i-1)*width + 12 + (i-1) * 8);
                        make.width.mas_equalTo(width);
                        make.height.mas_equalTo(self.scrollView.height);
                        make.centerY.mas_equalTo(self.scrollView);
                    }];
                }
                self.marginLeft = self.marginLeft + image.size.width + 8;
            }
            NSString *imageURL = [model.relatedPosts objectAtIndex:i-1].cover.fullUrl;
            [image setImageWithURL:[NSURL URLWithString:imageURL] placeholder:placeholderAvatarImage];
        }
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
}

@end


@implementation ZMPostDetailViewHeaderView

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

- (UIImageView *)iconImageView{
    if (!_iconImageView) {
        _iconImageView = [UIImageView new];
        UIImage *image = [UIImage imageNamed:@"postDetail_recommendIcon~iphone"];
        _iconImageView.image = placeholderFailImage;
        [self.mainView addSubview:_iconImageView];
        [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(image.size);
            make.centerY.mas_equalTo(self.mainView);
            make.left.mas_equalTo(10);
        }];
    }
    return _iconImageView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont boldSystemFontOfSize:13];
        _titleLabel.textColor = [ZMColor blackColor];
        [self.mainView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.iconImageView.mas_right).with.offset(8);
            make.centerY.mas_equalTo(self.mainView);
        }];
    }
    return _titleLabel;
}

- (void)setModel:(ZMDiscoverHeadModel *)model{
    if ([model isKindOfClass:[ZMDiscoverHeadModel class]]) {
        _model = model;
        self.titleLabel.text = model.title;
        self.iconImageView.image = model.icon;
    }
}

@end

