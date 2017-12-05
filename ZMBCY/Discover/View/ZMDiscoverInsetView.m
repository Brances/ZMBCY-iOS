//
//  ZMDiscoverInsetView.m
//  ZMBCY
//
//  Created by ZOMAKE on 2017/12/5.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "ZMDiscoverInsetView.h"
#import "ZMInsetHomeModel.h"
#import "ZMDiscoverInsetBannerViewCell.h"

@interface ZMDiscoverInsetView()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView   *collectionView;
@property (nonatomic, strong) ZMInsetHomeModel   *model;

@end

@implementation ZMDiscoverInsetView
{
    CGFloat page;
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor redColor];
        page = 1;
        [self setupUI];
    }
    return self;
}

#pragma mark - 设置UI
- (void)setupUI{
    WEAKSELF;
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    //设置CollectionView的属性
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0,kScreenWidth, self.height) collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [ZMColor appLightGrayColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[ZMDiscoverInsetBannerViewCell class] forCellWithReuseIdentifier:@"ZMDiscoverInsetBannerViewCell"];
    [self addSubview:self.collectionView];
    
    
    _collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page = 1;
        [weakSelf getInsetData];
    }];
    [self getInsetData];
}
#pragma mark - UICollectionViewDataSource and UICollectionViewDelegate
#pragma mark  设置CollectionView的组数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

#pragma mark - 设置CollectionView每组所包含的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 1;
}

#pragma mark - 设置CollectionCell的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"ZMDiscoverInsetBannerViewCell";
    ZMDiscoverInsetBannerViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    if (_model.remAccounts.count) {
        [cell setDataArray:self.model.remAccounts];
    }
    
    return cell;
}

#pragma mark - 每个cell的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(kScreenWidth, 260 + 80);
}
#pragma mark - section的margin
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
#pragma mark  点击CollectionView触发事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"---------------------%ld",indexPath.row);
}


#pragma mark - 获取插画数据
- (void)getInsetData{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"version"] = [NSString getNowTimeTimestamp];
    param[@"type"] = @"2";
    
    [MBProgressHUD showMessage:@"正在加载数据中..." toView:self];
    WEAKSELF;
    [ZMNetworkHelper requestGETWithRequestURL:DiscoveryInsetInfo parameters:param success:^(id responseObject) {
        [MBProgressHUD hideAllHUDsForView:weakSelf animated:YES];
        if (responseObject[@"result"] && [responseObject[@"result"] isKindOfClass:[NSDictionary class]]) {
            ZMInsetHomeModel *model = [ZMInsetHomeModel modelWithJSON:responseObject[@"result"]];
            //self.model = model;
            NSLog(@"当前model = %@",model);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.model = model;
                [self.collectionView.mj_header endRefreshing];
                [self.collectionView.mj_footer resetNoMoreData];
                [self.collectionView reloadData];
            });
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showPromptMessage:@"网络错误"];
    }];
    
}

@end
