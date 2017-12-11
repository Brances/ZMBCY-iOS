//
//  ZMDiscoverRecommendHotRecommCell.m
//  ZMBCY
//
//  Created by Brance on 2017/11/28.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "ZMDiscoverRecommendHotRecommCell.h"

@interface ZMDiscoverRecommendHotRecommCell()<UICollectionViewDataSource,WaterFlowLayoutDelegate>

/** 瀑布流*/
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation ZMDiscoverRecommendHotRecommCell

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
        [_collectionView registerClass:[ZMDiscoverRecommendHotRecommCellWater class] forCellWithReuseIdentifier:@"water"];
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
    ZMDiscoverRecommendHotRecommCellWater *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"water" forIndexPath:indexPath];
    //cell.model = self.dataArray[indexPath.item];
    [cell setupUIWithRecommend:self.style model:self.dataArray[indexPath.item]];
    
    return cell;
}

#pragma mark - WaterFlowLayoutDelegate
- (CGFloat)WaterFlowLayout:(ZMWaterFlowLayout *)WaterFlowLayout heightForRowAtIndexPath:(NSInteger )index itemWidth:(CGFloat)itemWidth indexPath:(NSIndexPath *)indexPath{
    ZMHotRecommendModel *model = self.dataArray[index];
    if (self.style == itemStyleSingle) {
        return model.realHeight;
    }
    return model.realHeight / 2;
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
    return 2;
}

- (CGFloat)rowMarginInWaterflowLayout:(ZMWaterFlowLayout *)waterflowLayout{
    if (self.style == itemStyleSingle) {
        return 10;
    }
    return 2;
}

- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(ZMWaterFlowLayout *)waterflowLayout{
    if (self.style == itemStyleSingle) {
        return UIEdgeInsetsMake(2, 0, 2, 0);
    }
    return UIEdgeInsetsMake(0, 0, 5, 0);
}


@end

@implementation ZMDiscoverRecommendHotRecommCellWater

- (ZMDiscoverRecommendHotRecommCellWaterView *)view{
    if (!_view) {
        _view = [[ZMDiscoverRecommendHotRecommCellWaterView alloc] init];
        [self.contentView addSubview:_view];
        [_view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(0);
        }];
    }
    return _view;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setModel:(ZMHotRecommendModel *)model{
    if (!model) return;
    _model = model;
    NSString *string = [NSString stringWithFormat:@"%@%@?imageView&axis_5_5&enlarge=1&quality=75&thumbnail=%.0fy%.0f&type=webp",HttpImageURLPre,model.imgId,model.realWidth,model.realHeight];
    [self.view.thumbImageView setAnimationLoadingImage:[NSURL URLWithString:string] placeholder:placeholderFailImage];
    
}

- (void)setPostModel:(ZMHotInsetPostModel *)postModel{
    if ([postModel isKindOfClass:[ZMHotInsetPostModel class]]) {
        _postModel = postModel;
        NSString *string = [NSString stringWithFormat:@"%@%@?imageView&axis_5_5&enlarge=1&quality=75&thumbnail=%.0fy%.0f&type=webp",HttpImageURLPre,postModel.imgId,postModel.realWidth,postModel.realHeight];
        [self.view.thumbImageView setAnimationLoadingImage:[NSURL URLWithString:string] placeholder:placeholderFailImage];
    }
}

- (void)setupUIWithRecommend:(itemStyle)style model:(ZMHotRecommendModel *)model{
    if (!model) return;
    _model = model;
    if (style == itemStyleSingle && model.top == 1) {
        self.view.topImageView.hidden = NO;
        self.view.topButton.hidden = NO;
        self.view.bottomShadow.hidden = NO;
    }else{
        self.view.topImageView.hidden = YES;
        self.view.topButton.hidden = YES;
        self.view.bottomShadow.hidden = YES;
    }
    NSString *string = [NSString stringWithFormat:@"%@%@?imageView&axis_5_5&enlarge=1&quality=75&thumbnail=%.0fy%.0f&type=webp",HttpImageURLPre,model.imgId,model.realWidth,model.realHeight];
    [self.view.thumbImageView setAnimationLoadingImage:[NSURL URLWithString:string] placeholder:placeholderFailImage];
    
}

- (void)setupUIWithPost:(itemStyle)style model:(ZMHotInsetPostModel *)model{
    if ([model isKindOfClass:[ZMHotInsetPostModel class]]) {
        _postModel = model;
        NSString *string = [NSString stringWithFormat:@"%@%@?imageView&axis_5_5&enlarge=1&quality=75&thumbnail=%.0fy%.0f&type=webp",HttpImageURLPre,model.imgId,model.realWidth,model.realHeight];
        [self.view.thumbImageView setAnimationLoadingImage:[NSURL URLWithString:string] placeholder:placeholderFailImage];
    }
}


@end

@implementation ZMDiscoverRecommendHotRecommCellWaterView

- (UIView *)mainView{
    if (!_mainView) {
        _mainView = [UIView new];
        [self addSubview:_mainView];
        [_mainView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(0);
        }];
        [_mainView.superview layoutIfNeeded];
    }
    return _mainView;
}

- (ZMImageView *)thumbImageView{
    if (!_thumbImageView) {
        _thumbImageView = [[ZMImageView alloc] init];
        [self.mainView addSubview:_thumbImageView];
        [self.mainView sendSubviewToBack:_thumbImageView];
        [_thumbImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(0);
        }];
        [_thumbImageView.superview layoutIfNeeded];
    }
    return _thumbImageView;
}

- (UIImageView *)topImageView{
    if (!_topImageView) {
        _topImageView = [UIImageView new];
        UIImage *image = [UIImage imageNamed:@"double_line_one"];
        _topImageView.image = image;
        [self.mainView addSubview:_topImageView];
        [_topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.top.mas_equalTo(10);
            make.size.mas_equalTo(image.size);
        }];
    }
    return _topImageView;
}
- (UIButton *)topButton{
    if (!_topButton) {
        _topButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _topButton.backgroundColor = [ZMColor blackColor];
        _topButton.layer.cornerRadius = 10;
        _topButton.layer.masksToBounds = YES;
        _topButton.titleLabel.font = [UIFont systemFontOfSize:11];
        [_topButton setTitle:@"昨日Top1" forState:UIControlStateNormal];
        [_topButton setTitleColor:[ZMColor whiteColor] forState:UIControlStateNormal];
        [self.thumbImageView addSubview:_topButton];
        [_topButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(self.topImageView.mas_bottom).with.offset(5);
            make.width.mas_equalTo([NSString getTitleWidth:@"昨日Top1" withFontSize:11] + 10);
            make.height.mas_equalTo(25);
        }];
    }
    return _topButton;
}

- (UIImageView *)bottomShadow{
    if (!_bottomShadow) {
        _bottomShadow = [UIImageView new];
        UIImage *image = [UIImage imageNamed:@"glist_name_bg"];
        _bottomShadow.image = image;
        [self.mainView addSubview:_bottomShadow];
        [_bottomShadow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(self.superview.height/2);
            make.left.right.bottom.mas_equalTo(0);
        }];
        
    }
    return _bottomShadow;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

@end

