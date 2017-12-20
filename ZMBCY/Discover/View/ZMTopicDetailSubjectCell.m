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
        if (model.subjectState == subjectSateDelete) {
            return 0;
        }
        return [model.downloadImgInfos firstObject].realHeight + 60;
    }else if (self.style == itemStyleDouble){
        if (model.subjectState == subjectSateDelete) {
            return (kScreenWidth - 3 * 5)/2 + 40;
        }
        return [model.downloadImgInfos firstObject].realHeight / 2 + 40;
    }
    return [model.downloadImgInfos firstObject].realHeight / 2 + 40;
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
        [self.mainView addSubview:_deleteImageView];
        [self.mainView sendSubviewToBack:_deleteImageView];
        [_deleteImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(0);
        }];
    }
    return _deleteImageView;
}

- (ZMTopicDetailSubjectCollectView *)collectView{
    if (!_collectView) {
        _collectView = [[ZMTopicDetailSubjectCollectView alloc] init];
        [self.mainView addSubview:_collectView];
        [_collectView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.height.mas_equalTo(40);
        }];
    }
    return _collectView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [ZMColor whiteColor];
        
    }
    return self;
}

- (void)setupUIWithStyle:(itemStyle)style model:(id)model{
    if ([model isKindOfClass:[ZMTopicDetailSubjectModel class]]) {
        ZMTopicDetailSubjectModel *subject = model;
        if (style == itemStyleSingle) {
            self.collectView.hidden = YES;
            self.deleteImageView.hidden = YES;
            self.coverImageView.hidden = NO;
            //2倍宽高图片质量会变大！！！wifi
            NSString *string = [NSString stringWithFormat:@"%@%@?imageView&axis_5_5&enlarge=1&quality=75&thumbnail=%.0fy%.0f&type=webp",HttpImageURLPre,[subject.downloadImgInfos firstObject].imageId,[subject.downloadImgInfos firstObject].realWidth * 2,[subject.downloadImgInfos firstObject].realHeight * 2 + 40];
            //[self.coverImageView setAnimationLoadingImage:[NSURL URLWithString:string] placeholder:placeholderFailImage];
            [self.coverImageView setImageWithURL:[NSURL URLWithString:string] placeholder:placeholderFailImage];
        }else{
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
               [self.coverImageView setImageWithURL:[NSURL URLWithString:string] placeholder:placeholderFailImage];
            }
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

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.font = [UIFont systemFontOfSize:11];
        _nameLabel.textColor = [ZMColor appSupportColor];
        [self addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.iconImageView.mas_right).with.offset(5);
            make.centerY.mas_equalTo(self);
        }];
    }
    return _nameLabel;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [ZMColor whiteColor];
        self.nameLabel.text = @"收藏帖子";
    }
    return self;
}

@end
