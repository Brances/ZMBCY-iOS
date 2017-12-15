//
//  ZMRankView.m
//  ZMBCY
//
//  Created by Brance on 2017/12/14.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "ZMRankView.h"
#import "ZMRankingListModel.h"
#import "ZMRankTopCollectionViewCell.h"
#import "ZMDiscoverInsetWaterCollectionViewCell.h"
#import "ZMStringPickerView.h"

@interface ZMRankView()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView          *collectionView;
@property (nonatomic, strong) ZMDiscoverInsetWaterCollectionViewCell *cell;
@property (nonatomic, strong) ZMRankingListModel        *model;

@end

@implementation ZMRankView
{
    CGFloat   offset;
    CGFloat   limit;
    CGFloat   type;
    NSString *currenMark;
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [ZMColor appGraySpaceColor];
        offset = 0;
        limit = 10;
        currenMark = @"pre";
    }
    return self;
}

- (void)setTrendType:(trendType)trendType{
    _trendType = trendType;
    if (trendType == trendTypeDay) {
        type = 0;
    }else if (trendType == trendTypeWeek){
        type = 1;
    }else{
        type = 2;
    }
    [self setupUI];
}

- (void)setupUI{
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [ZMColor appGraySpaceColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self addSubview:self.collectionView];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.mas_equalTo(0);
    }];
    WEAKSELF;
    _collectionView.mj_header = [ZMCustomGifHeader headerWithRefreshingBlock:^{
        offset = 0;
        limit = 10;
        [weakSelf getRankData];
    }];
    _collectionView.mj_footer = [ZMCustomGifFooter footerWithRefreshingBlock:^{
        offset += 10;
        limit += 10;
        [weakSelf getNextData];
    }];
    [self.collectionView registerClass:[ZMRankTopDateTitleCollectionViewCell class] forCellWithReuseIdentifier:@"ZMRankTopDateTitleCollectionViewCell"];
    [self.collectionView registerClass:[ZMRankTopCollectionViewCell class] forCellWithReuseIdentifier:@"ZMRankTopCollectionViewCell"];
    [self.collectionView registerClass:[ZMDiscoverInsetWaterCollectionViewCell class] forCellWithReuseIdentifier:@"ZMDiscoverInsetWaterCollectionViewCell"];
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"placeholer"];
    
    [ZMLoadingView showLoadingInView:self];
    [self getRankData];
}

#pragma mark - UICollectionViewDataSource and UICollectionViewDelegate
#pragma mark  设置CollectionView的组数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 3;
}

#pragma mark - 设置CollectionView每组所包含的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (!_model) return 0;
    if (section == 0) {
        return 1;
    }else if (section == 1 && _model.rankings.count > 2) {
        return 3;
    }else if (section == 2 && _model.rankings.count - 3){
        return 1;
    }
    return 1;
}

#pragma mark - 设置CollectionCell的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WEAKSELF;
    if (indexPath.section == 0 && _model) {
        static NSString *identifier = @"ZMRankTopDateTitleCollectionViewCell";
        ZMRankTopDateTitleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        cell.nameLabel.text = currenMark;
        __weak typeof(cell) weakCell = cell;
        cell.clickChangeDateBlock = ^(NSString *selectStr){
            [ZMStringPickerView showStringPickerWithTitle:@"" dataSource:weakSelf.model.rankingArray defaultSelValue:selectStr isAutoSelect:NO resultBlock:^(id selectValue) {
                NSLog(@"点击了选中字符串 = %@",selectValue);
                currenMark = selectValue;
                weakCell.nameLabel.text = selectValue;
                //刷新数据源
                offset = 0;
                limit = 10;
                [weakSelf getRankData];
            }];
        };
        return cell;
    }
    if (indexPath.section == 1 && _model) {
        static NSString *identifier = @"ZMRankTopCollectionViewCell";
        ZMRankTopCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        cell.model = [self.model.rankings safeObjectAtIndex:indexPath.row];
        return cell;
    }else if (indexPath.section == 2 && _model.rankOvers.count){
        static NSString *identify = @"ZMDiscoverInsetWaterCollectionViewCell";
        ZMDiscoverInsetWaterCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
        self.cell = cell;
        [cell setDataArray:self.model.rankOvers];
        __weak typeof(cell) weakCell = cell;
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
#pragma mark - 每个cell的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (!_model) return CGSizeMake(0, 0);
    if(indexPath.section == 0){
        return CGSizeMake(kScreenWidth,45);
    }else if (indexPath.section == 1) {
        ZMRankingModel *model = [self.model.rankings safeObjectAtIndex:indexPath.row];
        CGFloat height = kScreenWidth * model.imageInfo.height / model.imageInfo.width + 40;
        height = height > kScreenWidth * 1.4 ? kScreenWidth * 1.4 : height;
        
        return CGSizeMake(kScreenWidth,height);
    }
    return CGSizeMake(kScreenWidth, self.cell.cacheHeight ? self.cell.height : kScreenHeight);
}
#pragma mark - section的margin
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if (section == 2) {
        return UIEdgeInsetsMake(5, 0, 0, 0);
    }
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

#pragma mark - 列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout*)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

#pragma mark - 行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout*)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    if (section == 1) {
        return 5;
    }
    return 10;
}
#pragma mark - 主线程更新
- (void)mainQueueUpdateUI{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
    });
}

#pragma mark - 获取数据
- (void)getRankData{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"limit"] = @(limit);
    if (_model.currentMarkShow) {
        param[@"mark"] = [self getFormatDate:currenMark];
    }else{
        param[@"mark"] = @"pre";
    }
    param[@"type"] = @(type);
    param[@"offset"] = @(offset);
    WEAKSELF;
    [ZMNetworkHelper requestGETWithRequestURL:DiscoveryRankingList parameters:param success:^(id responseObject) {
        if ([responseObject[@"result"] isKindOfClass:[NSDictionary class]]) {
            ZMRankingListModel *model = [ZMRankingListModel modelWithJSON:responseObject[@"result"]];
           
            //添加不包括前三的帖子
            NSMutableArray *temp = [NSMutableArray arrayWithArray:model.rankings];
            [temp enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (idx < 3) {
                    [temp removeObjectAtIndex:idx];
                }
            }];
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.model = model;
                weakSelf.model.rankOvers = temp;
                currenMark = model.currentMarkShow;
                [ZMLoadingView hideLoadingForView:weakSelf];
                [weakSelf.collectionView.mj_footer resetNoMoreData];
                [weakSelf.collectionView.mj_header endRefreshing];
                [weakSelf.collectionView reloadData];
            });
            
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showPromptMessage:@"网络错误"];
        [ZMLoadingView hideLoadingForView:weakSelf];
    }];
}

#pragma mark - 获取下一页数据
- (void)getNextData{
    
    if (!self.model.hasMore) {
        [self.collectionView.mj_footer endRefreshing];
        [self.collectionView.mj_footer endRefreshingWithNoMoreData];
        return;
    }
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"limit"] = @(limit);
    //param[@"mark"] = currenMark;
    param[@"mark"] = [self getFormatDate:currenMark];
    param[@"type"] = @(type);
    param[@"offset"] = @(offset);
    
    WEAKSELF;
    [ZMNetworkHelper requestGETWithRequestURL:DiscoveryRankingList parameters:param success:^(id responseObject) {
        if ([responseObject[@"result"][@"rankings"] isKindOfClass:[NSArray class]]) {
            for (NSDictionary *rankDic in responseObject[@"result"][@"rankings"]) {
                ZMRankingModel *model = [ZMRankingModel modelWithJSON:rankDic];
                [self.model.rankOvers addObject:model];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                self.model.hasMore = [responseObject[@"result"][@"hasMore"] boolValue];
                if (self.model.hasMore) {
                    [weakSelf.collectionView.mj_footer endRefreshing];
                }else{
                    [weakSelf.collectionView.mj_footer endRefreshingWithNoMoreData];
                }
                self.cell.needUpdate = YES;
                [weakSelf.collectionView reloadData];
            });
            
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showPromptMessage:@"网络错误"];
        [weakSelf.collectionView.mj_footer endRefreshing];
    }];
    
}

#pragma mark - 格式化日期
-(NSString *)getFormatDate:(NSString *)text{
    __block NSString *format = nil;
    if (self.model.rankingMarks.count) {
        [self.model.rankingMarks enumerateObjectsUsingBlock:^(ZMRankingMarkModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([text isEqualToString:obj.markShow]) {
                format = obj.mark;
                *stop = YES;
            }
        }];
    }
    return format;
}

@end
