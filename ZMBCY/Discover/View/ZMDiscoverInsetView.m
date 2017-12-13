//
//  ZMDiscoverInsetView.m
//  ZMBCY
//
//  Created by Brance on 2017/12/5.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "ZMDiscoverInsetView.h"
#import "ZMInsetHomeModel.h"
#import "ZMDiscoverInsetBannerViewCell.h"
#import "ZMDiscoverInsetHeadViewCell.h"
#import "ZMDiscoverHeadModel.h"
#import "ZMDiscoverInsetLayoutHeadViewCell.h"
#import "ZMDiscoverInsetWaterCollectionViewCell.h"

@interface ZMDiscoverInsetView()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView   *collectionView;
@property (nonatomic, strong) ZMInsetHomeModel   *model;
@property (nonatomic, strong) NSMutableArray     *headArray;
@property (nonatomic, strong) ZMDiscoverHeadModel *hotHeadModel;
@property (nonatomic, strong) ZMDiscoverInsetWaterCollectionViewCell *cell;

@end

@implementation ZMDiscoverInsetView
{
    CGFloat page;
    CGFloat pageCount;
    CGFloat type;
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor redColor];
        page =      1;
        pageCount = 20;
        self.headArray = [NSMutableArray new];
    }
    return self;
}

#pragma mark - setter
- (void)setPageType:(pageViewType)pageType{
    if (pageType == pageViewTypeInset) {
        type      = 2 ;
        //添加头部model
        for (int i = 0; i < 3; i++) {
            ZMDiscoverHeadModel *model = [[ZMDiscoverHeadModel alloc] init];
            if (i == 0) {
                model.img   = @"illustration_chart";
                model.title = @"插画榜";
            }else if (i == 1) {
                model.img   = @"illustration_hoter";
                model.title = @"人气画师";
            }else{
                model.img   = @"special_G_select";
                model.title = @"专题精选";
            }
            [self.headArray addObject:model];
        }
        
        //热门插画
        self.hotHeadModel = [[ZMDiscoverHeadModel alloc] init];
        self.hotHeadModel.title = @"热门插画";
        self.hotHeadModel.icon  = [YYImage imageNamed:@"hot_illustration_title"];
        [self setupUI];
   }else{
        type      = 3 ;
        //添加头部model
        for (int i = 0; i < 2; i++) {
            ZMDiscoverHeadModel *model = [[ZMDiscoverHeadModel alloc] init];
            if (i == 0) {
                model.img   = @"hot_coser";
                model.title = @"人气Coser";
            }else{
                model.img   = @"special_G_select";
                model.title = @"专题精选";
            }
            [self.headArray addObject:model];
        }
        
        //热门插画
        self.hotHeadModel = [[ZMDiscoverHeadModel alloc] init];
        self.hotHeadModel.title = @"热门COS";
        self.hotHeadModel.icon  = [YYImage imageNamed:@"hot_illustration_title"];
        
        [self setupUI];
        
    }
}

#pragma mark - 设置UI
- (void)setupUI{
    WEAKSELF;
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    //设置CollectionView的属性
    //self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0,kScreenWidth, self.height) collectionViewLayout:flowLayout];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [ZMColor appGraySpaceColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[ZMDiscoverInsetBannerViewCell class] forCellWithReuseIdentifier:@"ZMDiscoverInsetBannerViewCell"];
    [self.collectionView registerClass:[ZMDiscoverInsetHeadViewCell class] forCellWithReuseIdentifier:@"ZMDiscoverInsetHeadViewCell"];
    [self.collectionView registerClass:[ZMDiscoverInsetLayoutHeadViewCell class] forCellWithReuseIdentifier:@"ZMDiscoverInsetLayoutHeadViewCell"];
    [self.collectionView registerClass:[ZMDiscoverInsetWaterCollectionViewCell class] forCellWithReuseIdentifier:@"ZMDiscoverInsetWaterCollectionViewCell"];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"placeholer"];
    
    [self addSubview:self.collectionView];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.mas_equalTo(0);
    }];
    
    _collectionView.mj_header = [ZMCustomGifHeader headerWithRefreshingBlock:^{
        page = 1;
        [weakSelf getInsetData];
    }];
    _collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        page ++;
        [weakSelf getNextData];
    }];
    
    [ZMLoadingView showLoadingInView:self];
    [self getInsetData];
    
}
#pragma mark - UICollectionViewDataSource and UICollectionViewDelegate
#pragma mark  设置CollectionView的组数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 4;
}

#pragma mark - 设置CollectionView每组所包含的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (!_model) return 0;
    if (section == 0 || section == 1 || section == 2 || section == 3) {
        return 1;
    }
    return 1;
}

#pragma mark - 设置CollectionCell的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0 && _model) {
        static NSString *identify = @"ZMDiscoverInsetBannerViewCell";
        ZMDiscoverInsetBannerViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
        if (_model.remAccounts.count) {
            [cell setDataArray:self.model.remAccounts];
        }
        
        return cell;
    }else if(indexPath.section == 1 && _model){
        static NSString *identify = @"ZMDiscoverInsetHeadViewCell";
        ZMDiscoverInsetHeadViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
        if (_headArray.count) {
            [cell setDataArray:_headArray];
        }
        
        return cell;
    }else if (indexPath.section == 2 && _model){
        static NSString *identify = @"ZMDiscoverInsetLayoutHeadViewCell";
        ZMDiscoverInsetLayoutHeadViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
        if (_hotHeadModel) {
            cell.model = _hotHeadModel;
        }
        WEAKSELF;
        cell.headView.changeStyleBlock = ^(BOOL select){
            if (select) {
                weakSelf.cell.style = itemStyleSingle;
            }else{
                 weakSelf.cell.style = itemStyleDouble;
            }
            weakSelf.cell.needUpdate = YES;
            [weakSelf.collectionView reloadData];
        };
        
        return cell;
    }else if (indexPath.section == 3 && _model){
        static NSString *identify = @"ZMDiscoverInsetWaterCollectionViewCell";
        ZMDiscoverInsetWaterCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
        self.cell = cell;
        [cell setDataArray:self.model.channelPost.posts];
        __weak typeof(cell) weakCell = cell;
        WEAKSELF;
        cell.updateCellHeight = ^(CGFloat height){
            weakCell.height = height;
            [weakSelf mainQueueUpdateUI];
        };
        return cell;
    }

    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"placeholer" forIndexPath:indexPath];
    cell.backgroundColor = [ZMColor appGraySpaceColor];
    return cell;
    
    
}
#pragma mark - 主线程更新
- (void)mainQueueUpdateUI{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
    });
}

#pragma mark - 每个cell的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (!_model) return CGSizeMake(0, 0);
    if (indexPath.section == 0) {
        return CGSizeMake(kScreenWidth,340 * FIT_HEIGHT);
    }else if (indexPath.section == 1){
         return CGSizeMake(kScreenWidth, 70);
    }else if (indexPath.section == 2){
        return CGSizeMake(kScreenWidth, 40);
    }
    
    return CGSizeMake(kScreenWidth, self.cell.cacheHeight ? self.cell.height : 200);
}
#pragma mark - section的margin
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
#pragma mark  点击CollectionView触发事件
//-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"---------------------%ld",indexPath.row);
//}

#pragma mark - 获取插画数据
- (void)getInsetData{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"version"] = [NSString getNowTimeTimestamp];
    param[@"type"] = @(type);
    
    WEAKSELF;
    [ZMNetworkHelper requestGETWithRequestURL:DiscoveryInsetInfo parameters:param success:^(id responseObject) {
        //[MBProgressHUD hideAllHUDsForView:weakSelf animated:YES];
        if (responseObject[@"result"] && [responseObject[@"result"] isKindOfClass:[NSDictionary class]]) {
            ZMInsetHomeModel *model = [ZMInsetHomeModel modelWithJSON:responseObject[@"result"]];
            NSLog(@"当前model = %@",model);
            dispatch_async(dispatch_get_main_queue(), ^{
                [ZMLoadingView hideLoadingForView:weakSelf];
                weakSelf.model = model;
                [weakSelf.collectionView.mj_header endRefreshing];
                [weakSelf.collectionView.mj_footer resetNoMoreData];
                weakSelf.cell.needUpdate = YES;
                [weakSelf.collectionView reloadData];
            });
        }
    } failure:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD showPromptMessage:@"网络错误"];
            [weakSelf.collectionView.mj_header endRefreshing];
            [ZMLoadingView hideLoadingForView:weakSelf];
            if (!weakSelf.model) {
                [ZMLoadFailedView showLoadFailedInView:weakSelf topEdge:0 retryHandle:^{
                    [weakSelf getInsetData];
                }];
            }
        });
    }];
}

#pragma mark - 获取下一页插画数据
- (void)getNextData{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"lastId"] =    self.model.channelPost.lastId;
    param[@"pageCount"] = @(pageCount);
    param[@"type"] = @(type);
    
    //这里为了节省性能，暂时只加载5页吧，没找到优化的方法
    if (page > 4) {
         [self.collectionView.mj_footer endRefreshingWithNoMoreData];
        return;
    }
    [ZMNetworkHelper requestGETWithRequestURL:DiscoveryInsetNextPopularPosts parameters:param success:^(id responseObject) {
        
        if ([responseObject[@"result"][@"posts"] isKindOfClass:[NSArray class]]) {
            NSArray *data = responseObject[@"result"][@"posts"];
            for (NSDictionary *dic in data) {
                ZMHotInsetPostModel *model = [ZMHotInsetPostModel modelWithJSON:dic];
                [self.model.channelPost.posts addObject:model];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.collectionView.mj_footer endRefreshing];
                self.cell.needUpdate = YES;
                [self.collectionView reloadData];
            });
        }
        
    } failure:^(NSError *error) {
        [self.collectionView.mj_footer endRefreshing];
        [MBProgressHUD showPromptMessage:@"加载更多失败"];
    }];
    
}

@end
