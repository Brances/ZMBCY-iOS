//
//  ZMDiscoverRecommendHotRecommCell.m
//  ZMBCY
//
//  Created by ZOMAKE on 2017/11/28.
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
    cell.model = self.dataArray[indexPath.item];
    return cell;
}

#pragma mark - WaterFlowLayoutDelegate
- (CGFloat)WaterFlowLayout:(ZMWaterFlowLayout *)WaterFlowLayout heightForRowAtIndexPath:(NSInteger )index itemWidth:(CGFloat)itemWidth indexPath:(NSIndexPath *)indexPath{
    ZMHotRecommendModel *model = self.dataArray[index];
    if (self.style) {
        return model.realHeight;
    }
    return model.realHeight / 2;
}
- (CGFloat)columnCountInWaterflowLayout:(ZMWaterFlowLayout *)waterflowLayout{
    if (self.style) {
        return 1;
    }
    return 2;
}
- (CGFloat)columnMarginInWaterflowLayout:(ZMWaterFlowLayout *)waterflowLayout{
    if (self.style) {
        return 0;
    }
    return 2;
}

- (CGFloat)rowMarginInWaterflowLayout:(ZMWaterFlowLayout *)waterflowLayout{
    if (self.style) {
        return 10;
    }
    return 2;
}

- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(ZMWaterFlowLayout *)waterflowLayout{
    if (self.style) {
        return UIEdgeInsetsMake(2, 0, 2, 0);
    }
    return UIEdgeInsetsMake(0, 0, 5, 0);
}


@end

@implementation ZMDiscoverRecommendHotRecommCellWater

- (ZMImageView *)thumbImageView{
    if (!_thumbImageView) {
        _thumbImageView = [[ZMImageView alloc] init];
        [self.contentView addSubview:_thumbImageView];
        [_thumbImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(0);
        }];
    }
    return _thumbImageView;
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
    NSString *string = [NSString stringWithFormat:@"%@%@?imageView&axis_5_5&enlarge=1&quality=75&thumbnail=%.0fy%.0f&type=%@",HttpImageURLPre,model.imgId,model.realWidth,model.realHeight,@"webp"];
    [self.thumbImageView setAnimationLoadingImage:[NSURL URLWithString:string] placeholder:placeholderFailImage];
    
}

- (void)setPostModel:(ZMHotInsetPostModel *)postModel{
    if ([postModel isKindOfClass:[ZMHotInsetPostModel class]]) {
        _postModel = postModel;
        NSString *string = [NSString stringWithFormat:@"%@%@?imageView&axis_5_5&enlarge=1&quality=75&thumbnail=%.0fy%.0f&type=%@",HttpImageURLPre,postModel.imgId,postModel.realWidth,postModel.realHeight,@"webp"];
        [self.thumbImageView setAnimationLoadingImage:[NSURL URLWithString:string] placeholder:placeholderFailImage];
    }
}

@end
