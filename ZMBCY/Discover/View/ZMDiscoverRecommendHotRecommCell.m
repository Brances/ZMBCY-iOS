//
//  ZMDiscoverRecommendHotRecommCell.m
//  ZMBCY
//
//  Created by ZOMAKE on 2017/11/28.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "ZMDiscoverRecommendHotRecommCell.h"

@interface ZMDiscoverRecommendHotRecommCell()<UICollectionViewDataSource,WaterFlowLayoutDelegate,XRWaterfallLayoutDelegate>

/** 瀑布流*/
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation ZMDiscoverRecommendHotRecommCell

- (UICollectionView *)collectionView{
    if (!_collectionView) {
         ZMWaterFlowLayout *layout = [[ZMWaterFlowLayout alloc]init];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        [_collectionView registerClass:[ZMDiscoverRecommendHotRecommCellWater class] forCellWithReuseIdentifier:@"water"];
        layout.delegate = self;
        [self.contentView addSubview:_collectionView];
        
        
//        //创建瀑布流布局
//        XRWaterfallLayout *waterfall = [XRWaterfallLayout waterFallLayoutWithColumnCount:2];
//        //或者一次性设置
//        [waterfall setColumnSpacing:2 rowSpacing:2 sectionInset:UIEdgeInsetsMake(2, 0, 2, 0)];
//        //设置代理，实现代理方法
//        waterfall.delegate = self;
//        
//        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)collectionViewLayout:waterfall];
//        self.collectionView.backgroundColor = [UIColor whiteColor];
//        self.collectionView.dataSource = self;
//        [_collectionView registerClass:[ZMDiscoverRecommendHotRecommCellWater class] forCellWithReuseIdentifier:@"water"];
//        [self.contentView addSubview:_collectionView];
    }
    return _collectionView;
}

- (void)setDataArray:(NSArray *)dataArray{
    if (!dataArray.count) return;
    _dataArray = dataArray;
    [self collectionView];
    self.height = kScreenHeight;
    WEAKSELF;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf.collectionView reloadData];
    });
    
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

//根据item的宽度与indexPath计算每一个item的高度
- (CGFloat)waterfallLayout:(XRWaterfallLayout *)waterfallLayout itemHeightForWidth:(CGFloat)itemWidth atIndexPath:(NSIndexPath *)indexPath {
    //根据图片的原始尺寸，及显示宽度，等比例缩放来计算显示高度
    ZMHotRecommendModel *image = self.dataArray[indexPath.item];
    return image.height / image.width * itemWidth;
}

#pragma mark - WaterFlowLayoutDelegate
- (CGFloat)WaterFlowLayout:(ZMWaterFlowLayout *)WaterFlowLayout heightForRowAtIndexPath:(NSInteger )index itemWidth:(CGFloat)itemWidth{
    ZMHotRecommendModel *model = self.dataArray[index];
    
    return model.realHeight;
}
- (CGFloat)columnCountInWaterflowLayout:(ZMWaterFlowLayout *)waterflowLayout{
    return 2;
}
- (CGFloat)columnMarginInWaterflowLayout:(ZMWaterFlowLayout *)waterflowLayout{
    return 2;
}

- (CGFloat)rowMarginInWaterflowLayout:(ZMWaterFlowLayout *)waterflowLayout{
    return 2;
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
        self.layer.borderColor = [ZMColor appNavTitleGrayColor].CGColor;
        self.layer.borderWidth = 1;
    }
    return self;
}

- (void)setModel:(ZMHotRecommendModel *)model{
    if (!model) return;
    _model = model;
    NSString *string = [NSString stringWithFormat:@"%@%@?imageView&enlarge=1&quality=75&thumbnail=%.0fy%.0f&type=%@",HttpImageURLPre,model.imgId,model.width,model.height,model.imageSuffix];
    [self.thumbImageView setAnimationLoadingImage:[NSURL URLWithString:string] placeholder:placeholderFailImage];
    
}

@end