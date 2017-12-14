//
//  ZMDiscoverInsetWaterCollectionViewCell.m
//  ZMBCY
//
//  Created by Brance on 2017/12/6.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "ZMDiscoverInsetWaterCollectionViewCell.h"
#import "ZMWaterFlowLayout.h"
#import "ZMDiscoverRecommendHotRecommCell.h"
#import "ZMRankingListModel.h"

@interface ZMDiscoverInsetWaterCollectionViewCell()<UICollectionViewDataSource,WaterFlowLayoutDelegate>

/** 瀑布流*/
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation ZMDiscoverInsetWaterCollectionViewCell

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
        _collectionView.userInteractionEnabled = YES;
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

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [ZMColor appLightGrayColor];
    }
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZMDiscoverRecommendHotRecommCellWater *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"water" forIndexPath:indexPath];
    //插画
    [cell setupUIWithPost:self.style model:self.dataArray[indexPath.item]];
    
    return cell;
}

#pragma mark - WaterFlowLayoutDelegate
- (CGFloat)WaterFlowLayout:(ZMWaterFlowLayout *)WaterFlowLayout heightForRowAtIndexPath:(NSInteger )index itemWidth:(CGFloat)itemWidth indexPath:(NSIndexPath *)indexPath{
    //ZMHotInsetPostModel *model = self.dataArray[index];
    id model = self.dataArray[index];
    if ([model isKindOfClass:[ZMHotInsetPostModel class]]) {
        ZMHotInsetPostModel *insetModel = model;
        if (self.style == itemStyleSingle) {
            return insetModel.realHeight;
        }
        return insetModel.realHeight / 2;
    }else if ([model isKindOfClass:[ZMRankingModel class]]){
        ZMRankingModel *rankModel = model;
        if (self.style == itemStyleSingle) {
            return rankModel.imageInfo.realHeight;
        }
        return rankModel.imageInfo.realHeight / 2;
    }
    
    return 0;
    
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
    return KWaterSpace;
}

- (CGFloat)rowMarginInWaterflowLayout:(ZMWaterFlowLayout *)waterflowLayout{
    if (self.style == itemStyleSingle) {
        return 10;
    }
    return KWaterSpace;
}

- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(ZMWaterFlowLayout *)waterflowLayout{
    if (self.style == itemStyleSingle) {
        return UIEdgeInsetsMake(0, 0, KWaterSpace, 0);
    }
    return UIEdgeInsetsMake(0, 0, 5, 0);
}

@end
