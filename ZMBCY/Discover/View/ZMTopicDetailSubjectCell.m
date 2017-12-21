//
//  ZMTopicDetailSubjectCell.m
//  ZMBCY
//
//  Created by ZOMAKE on 2017/12/20.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "ZMTopicDetailSubjectCell.h"

@interface ZMTopicDetailSubjectCell()<UICollectionViewDataSource,WaterFlowLayoutDelegate>

/** 瀑布流*/
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation ZMTopicDetailSubjectCell

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        ZMWaterFlowLayout *layout = [[ZMWaterFlowLayout alloc]init];
        WEAKSELF;
        layout.updateHeight = ^(CGFloat height){
            if (height != weakSelf.cacheHeight && self.updateCellHeight) {
                weakSelf.cacheHeight = height;
                weakSelf.updateCellHeight(height);
            }
        };
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) collectionViewLayout:layout];
        _collectionView.backgroundColor = [ZMColor appGraySpaceColor];
        _collectionView.dataSource = self;
        [_collectionView registerClass:[ZMTopicDetailSubjectCellView class] forCellWithReuseIdentifier:@"ZMTopicDetailSubjectCellView"];
        layout.delegate = self;
        [self.contentView addSubview:_collectionView];
    }
    return _collectionView;
}

- (void)setDataArray:(NSArray *)dataArray{
    if (!dataArray.count) return;
    _dataArray = dataArray;
    if (self.collectionView.height != self.cacheHeight || self.needUpdate) {
        self.collectionView.height = self.cacheHeight;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
            self.needUpdate = NO;
        });
    }
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [ZMColor appLightGrayColor];
    }
    return self;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZMTopicDetailSubjectCellView *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ZMTopicDetailSubjectCellView" forIndexPath:indexPath];
    [cell setupUIWithStyle:self.style model:[self.dataArray safeObjectAtIndex:indexPath.item]];
    return cell;
}

#pragma mark - WaterFlowLayoutDelegate
- (CGFloat)WaterFlowLayout:(ZMWaterFlowLayout *)WaterFlowLayout heightForRowAtIndexPath:(NSInteger )index itemWidth:(CGFloat)itemWidth indexPath:(NSIndexPath *)indexPath{
    ZMTopicDetailSubjectModel *model = self.dataArray[index];
    if (self.style == itemStyleSingle) {
        if (model.subjectType == subjectTypeArticle ||model.subjectState == subjectSateDelete) {
            return 0;
        }
        return [model.downloadImgInfos firstObject].realHeight + 60;
    }
    if (model.subjectType == subjectTypeArticle || model.subjectState == subjectSateDelete) {
        return (kScreenWidth - 3 * 5)/2 + model.reasonHeight;
    }
    return [model.downloadImgInfos firstObject].realHeight / 2 + model.reasonHeight;
}
- (CGFloat)columnCountInWaterflowLayout:(ZMWaterFlowLayout *)waterflowLayout{
    if (self.style == itemStyleSingle) {
        return 1;
    }
    return 2;
}
- (CGFloat)columnMarginInWaterflowLayout:(ZMWaterFlowLayout *)waterflowLayout{
    if (self.style == itemStyleSingle) {
        return 0;
    }
    return 5;
}

- (CGFloat)rowMarginInWaterflowLayout:(ZMWaterFlowLayout *)waterflowLayout{
    if (self.style == itemStyleSingle) {
        return 10;
    }
    return 5;
}

- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(ZMWaterFlowLayout *)waterflowLayout{
    if (self.style == itemStyleSingle) {
        return UIEdgeInsetsMake(5, 0, 5, 0);
    }
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

@end

@implementation ZMTopicDetailSubjectCellView

- (UIView *)mainView{
    if (!_mainView) {
        _mainView = [UIView new];
        _mainView.backgroundColor = [ZMColor colorWithHexString:@"#FAFAFA"];
        _mainView.layer.cornerRadius = 3;
        _mainView.clipsToBounds = YES;
        [self.contentView addSubview:_mainView];
        [_mainView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(0);
        }];
        [_mainView.superview layoutIfNeeded];
    }
    return _mainView;
}

- (ZMImageView *)coverImageView{
    if (!_coverImageView) {
        _coverImageView = [ZMImageView new];
        [self.mainView addSubview:_coverImageView];
        [self.mainView sendSubviewToBack:_coverImageView];
        [_coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(0);
        }];
    }
    return _coverImageView;
}

- (UIImageView *)deleteImageView{
    if (!_deleteImageView) {
        _deleteImageView = [UIImageView new];
        UIImage *image = [UIImage imageNamed:@"myCollection_deletePic~iphone"];
        _deleteImageView.image = image;
        [self.mainView addSubview:_deleteImageView];
        [self.mainView sendSubviewToBack:_deleteImageView];
        [_deleteImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(image.size);
            make.centerX.mas_equalTo(self.mainView);
            make.top.mas_equalTo(20);
        }];
    }
    return _deleteImageView;
}

- (UILabel *)articleNameLabel{
    if (!_articleNameLabel) {
        _articleNameLabel = [UILabel new];
        _articleNameLabel.numberOfLines = 2;
        _articleNameLabel.textAlignment = NSTextAlignmentCenter;
        _articleNameLabel.textColor = [ZMColor blackColor];
        _articleNameLabel.font = [UIFont systemFontOfSize:15];
        [self.mainView addSubview:_articleNameLabel];
        [_articleNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.top.mas_equalTo(10);
        }];
    }
    return _articleNameLabel;
}

- (UILabel *)articleContentLabel{
    if (!_articleContentLabel) {
        _articleContentLabel = [UILabel new];
        _articleContentLabel.numberOfLines = 0;
        _articleContentLabel.font = [UIFont systemFontOfSize:12];
        _articleContentLabel.textColor = [ZMColor appSupportColor];
        [self.mainView addSubview:_articleContentLabel];
        [_articleContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.top.mas_equalTo(self.articleNameLabel.mas_bottom).with.offset(5);
            make.bottom.mas_equalTo(self.bottomLineLabel.mas_top).with.offset(-5);
        }];
    }
    return _articleContentLabel;
}

- (UILabel *)bottomLineLabel{
    if (!_bottomLineLabel) {
        _bottomLineLabel = [UILabel new];
        _bottomLineLabel.backgroundColor = [ZMColor appSupportColor];
        [self.mainView addSubview:_bottomLineLabel];
        [_bottomLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(0.5);
            make.bottom.mas_equalTo(self.collectView.mas_top);
        }];
    }
    return _bottomLineLabel;
}

- (ZMTopicDetailSubjectCollectView *)collectView{
    if (!_collectView) {
        _collectView = [[ZMTopicDetailSubjectCollectView alloc] init];
        [self.mainView addSubview:_collectView];
        [_collectView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
        }];
    }
    return _collectView;
}

- (ZMTopicDetailSubjectUserFollowView *)followView{
    if (!_followView) {
        _followView = [ZMTopicDetailSubjectUserFollowView new];
        [self.mainView addSubview:_followView];
        [_followView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.height.mas_equalTo(60);
        }];
    }
    return _followView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [ZMColor whiteColor];
    }
    return self;
}

#pragma mark - 设置布局及数据
- (void)setupUIWithStyle:(itemStyle)style model:(id)model{
    if ([model isKindOfClass:[ZMTopicDetailSubjectModel class]]) {
        _model = model;
        ZMTopicDetailSubjectModel *subject = model;
        if (style == itemStyleSingle) {
            self.followView.hidden = NO;
            self.collectView.hidden = YES;
            self.deleteImageView.hidden = YES;
            self.coverImageView.hidden = NO;
            //2倍宽高图片质量会变大！！！wifi
            NSString *string = [NSString stringWithFormat:@"%@%@?imageView&axis_5_5&enlarge=1&quality=75&thumbnail=%.0fy%.0f&type=webp",HttpImageURLPre,[subject.downloadImgInfos firstObject].imageId,[subject.downloadImgInfos firstObject].realWidth * 2,[subject.downloadImgInfos firstObject].realHeight * 2 + 40];
            [self.coverImageView setAnimationLoadingImage:[NSURL URLWithString:string] placeholder:placeholderFailImage];
            
            [self.followView.thumbImageView setImageWithURL:[NSURL URLWithString:subject.author.portraitFullUrl] placeholder:placeholderAvatarImage];
            self.followView.nameLabel.text = subject.author.nickName;
            
            
        }else{
            self.followView.hidden = YES;
            self.collectView.hidden = NO;
            //判断帖子是否被删除
            if (subject.subjectState == subjectSateDelete) {
                self.coverImageView.hidden = YES;
                self.deleteImageView.hidden = NO;
                self.deleteImageView.image = [UIImage imageNamed:@"myCollection_deletePic~iphone"];
            }else{
                self.coverImageView.hidden = NO;
                self.deleteImageView.hidden = YES;
                //2倍宽高图片质量会变大！！！wifi
                NSString *string = [NSString stringWithFormat:@"%@%@?imageView&axis_5_5&enlarge=1&quality=75&thumbnail=%.0fy%.0f&type=webp",HttpImageURLPre,[subject.downloadImgInfos firstObject].imageId,[subject.downloadImgInfos firstObject].realWidth * 2,[subject.downloadImgInfos firstObject].realHeight * 2 + 40];
               [self.coverImageView setAnimationLoadingImage:[NSURL URLWithString:string] placeholder:placeholderFailImage];
            }
            self.collectView.nameLabel.textLayout = subject.reasonLayout;
            self.collectView.nameLabel.text = subject.reason;
            
            //准确的来说是判断字符串是否是收藏帖子
            if ([subject.reason isEqualToString:@"收藏帖子"]) {
                self.collectView.iconImageView.hidden = NO;
                [self.collectView.nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(self.collectView.iconImageView.mas_right).with.offset(5);
                    make.right.mas_equalTo(-10);
                    make.centerY.mas_equalTo(self.collectView);
                }];
            }else{
                self.collectView.iconImageView.hidden = YES;
                [self.collectView.nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.height.mas_equalTo(subject.reasonHeight);
                    make.left.mas_equalTo(10);
                    make.right.mas_equalTo(-10);
                    make.centerY.mas_equalTo(self.collectView);
                }];
            }
            //判断帖子类型是否隐藏图片视图
            if (subject.subjectType == subjectTypeArticle) {
                self.articleNameLabel.hidden = NO;
                self.articleContentLabel.hidden = NO;
                self.bottomLineLabel.hidden = NO;
                self.articleNameLabel.text = subject.title;
                self.articleContentLabel.text = subject.content;
                self.mainView.backgroundColor = [ZMColor whiteColor];
                self.coverImageView.hidden = YES;
            }else{
                self.articleNameLabel.hidden = YES;
                self.articleContentLabel.hidden = YES;
                self.bottomLineLabel.hidden = YES;
                self.mainView.backgroundColor = [ZMColor colorWithHexString:@"#FAFAFA"];
            }

            [self.collectView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(subject.reasonHeight);
            }];
        }
    }
}


@end

@implementation ZMTopicDetailSubjectCollectView

- (UIImageView *)iconImageView{
    if (!_iconImageView) {
        _iconImageView = [UIImageView new];
        UIImage *image = [UIImage imageNamed:@"favorite_0"];
        _iconImageView.image = image;
        [self addSubview:_iconImageView];
        [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(image.size);
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(self);
        }];
    }
    return _iconImageView;
}

- (YYLabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [YYLabel new];
        _nameLabel.numberOfLines = 0;
        _nameLabel.font = [UIFont systemFontOfSize:12];
        _nameLabel.textColor = [ZMColor appSupportColor];
        [self addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.iconImageView.mas_right).with.offset(5);
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(self);
        }];
    }
    return _nameLabel;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [ZMColor whiteColor];
    }
    return self;
}


@end


@implementation ZMTopicDetailSubjectUserFollowView

- (UIView *)mainView{
    if (!_mainView) {
        _mainView = [UIView new];
        _mainView.backgroundColor = [ZMColor colorWithHexString:@"#ffffff"];
        [self addSubview:_mainView];
        [_mainView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(0);
        }];
        [_mainView.superview layoutIfNeeded];
    }
    return _mainView;
}

- (UIImageView *)thumbImageView{
    if (!_thumbImageView) {
        _thumbImageView = [UIImageView new];
        _thumbImageView.layer.cornerRadius = 30 * 0.5;
        _thumbImageView.clipsToBounds = YES;
        [self.mainView addSubview:_thumbImageView];
        [_thumbImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(30, 30));
            make.left.mas_equalTo(20);
            make.centerY.mas_equalTo(self.mainView);
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
            make.left.mas_equalTo(self.thumbImageView.mas_right).with.offset(5);
            make.centerY.mas_equalTo(self.thumbImageView);
            make.right.mas_equalTo(self.followButton.mas_left).with.offset(-20);
        }];
    }
    return _nameLabel;
}

- (UIButton *)followButton{
    if (!_followButton) {
        _followButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _followButton.titleLabel.font = [UIFont systemFontOfSize:15];
        _followButton.layer.cornerRadius = 3;
        _followButton.layer.borderColor = [ZMColor appMainColor].CGColor;
        _followButton.layer.borderWidth = 1;
        [_followButton setTitle:@"关注" forState:UIControlStateNormal];
        [_followButton setTitleColor:[ZMColor appMainColor] forState:UIControlStateNormal];
        
        [self.mainView addSubview:_followButton];
        [_followButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(80, 35));
            make.centerY.mas_equalTo(self.mainView);
            make.right.mas_equalTo(-20);
        }];
    }
    return _followButton;
}

- (UILabel *)bottomLineLabel{
    if (!_bottomLineLabel) {
        _bottomLineLabel = [UILabel new];
        _bottomLineLabel.backgroundColor = [ZMColor appNavTitleGrayColor];
        [self.mainView addSubview:_bottomLineLabel];
        [_bottomLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.height.mas_equalTo(0.5);
        }];
    }
    return _bottomLineLabel;
}

- (instancetype) initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [ZMColor whiteColor];
    }
    return self;
}



@end
