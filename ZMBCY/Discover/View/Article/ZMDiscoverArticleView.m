//
//  ZMDiscoverArticleView.m
//  ZMBCY
//
//  Created by Brance on 2017/12/7.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "ZMDiscoverArticleView.h"
#import "ZMArticleHomeModel.h"
#import "ZMDiscoverArticleBannerViewCell.h"
#import "ZMDiscoverArticleHeadViewCell.h"
#import "ZMDiscoverHeadModel.h"
#import "ZMDiscoverArticleHeadViewCell.h"
#import "ZMDiscoverRecommendHeadView.h"
#import "ZMDiscoverArticleLayout.h"
#import "ZMDiscoverArticleCell.h"

@interface ZMDiscoverArticleView()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) YYTableView           *tableView;
@property (nonatomic, strong) ZMArticleHomeModel    *model;
@property (nonatomic, strong) NSMutableArray        *headArray;
@property (nonatomic, strong) ZMDiscoverHeadModel   *topicModel;
@property (nonatomic, strong) ZMDiscoverRecommendHeadView   *hotHeadView;
@property (nonatomic, strong) NSMutableArray        *layouts;

@end

@implementation ZMDiscoverArticleView
{
    CGFloat page;
    CGFloat pageCount;
}

- (ZMDiscoverRecommendHeadView *)hotHeadView{
    if (!_hotHeadView) {
        _hotHeadView = [[ZMDiscoverRecommendHeadView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
        ZMDiscoverHeadModel *HeadModel = [[ZMDiscoverHeadModel alloc] init];
        HeadModel.title = @"热门文章";
        HeadModel.icon  = [YYImage imageNamed:@"hot_illustration_title"];
        _hotHeadView.model = HeadModel;
    }
    return _hotHeadView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [ZMColor whiteColor];
        page = 1;
        pageCount = 20;
        self.headArray = [NSMutableArray new];
        self.layouts = [NSMutableArray new];
        //添加头部model
        for (int i = 0; i < 2; i++) {
            ZMDiscoverHeadModel *model = [[ZMDiscoverHeadModel alloc] init];
            if (i == 0) {
                model.img   = @"discover_hotAticle_hotwriter~iphone";
                model.title = @"人气写手";
            }else{
                model.img   = @"special_G_select";
                model.title = @"专题精选";
            }
            [self.headArray addObject:model];
        }
        //热门插画
        self.topicModel = [[ZMDiscoverHeadModel alloc] init];
        self.topicModel.title = @"热门文章";
        self.topicModel.icon  = [YYImage imageNamed:@"hot_illustration_title"];
        
        [self tableView];
        [ZMLoadingView showLoadingInView:self];
        [self getArticleData];
    }
    return self;
}

- (YYTableView *)tableView{
    if (!_tableView) {
        _tableView = [[YYTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate =   self;
        [self addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        }];
        WEAKSELF;
        _tableView.mj_header = [ZMCustomGifHeader headerWithRefreshingBlock:^{
            page = 1;
            [weakSelf getArticleData];
        }];
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            page ++;
            [weakSelf getNextData];
        }];
    }
    return _tableView;
}

#pragma mark - UITableViewDataSource and UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 1 && _model) {
        return self.hotHeadView;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 1 && _model) {
        return 50;
    }
    return 0.01;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    _tableView.mj_footer.hidden = _model.channelPost.posts.count == 0;
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (!_model) return 0;
    if (section == 0 || section == 1) {
        return 1;
    }
    return self.layouts.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (!_model) return 0;
    if (indexPath.section == 0) {
        return 340 * FIT_HEIGHT;
    }else if (indexPath.section == 1){
        return 70;
    }
    return ((ZMDiscoverArticleLayout *)[self.layouts safeObjectAtIndex:indexPath.row]).height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && _model.remNovels.count) {
        static NSString *banner = @"banner";
        ZMDiscoverArticleBannerViewCell *cell = [tableView dequeueReusableCellWithIdentifier:banner];
        if (!cell) {
            cell = [[ZMDiscoverArticleBannerViewCell alloc] initWithStyle:0 reuseIdentifier:banner];
        }
        cell.height = [self tableView:tableView heightForRowAtIndexPath:indexPath];
        if (self.model.remNovels.count) {
            cell.dataArray = self.model.remNovels;
        }
        return cell;
    }else if (indexPath.section == 1 && _model){
        static NSString *topic = @"topic";
        ZMDiscoverArticleHeadViewCell *cell = [tableView dequeueReusableCellWithIdentifier:topic];
        if (!cell) {
            cell = [[ZMDiscoverArticleHeadViewCell alloc] initWithStyle:0 reuseIdentifier:topic];
        }
        if (self.headArray.count) {
            [cell setDataArray:_headArray];
        }
        return cell;
    }else if (indexPath.section == 2 && _layouts.count){
        static NSString *article = @"article";
        ZMDiscoverArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:article];
        if (!cell) {
            cell = [[ZMDiscoverArticleCell alloc] initWithStyle:0 reuseIdentifier:article];
        }
        if (_layouts.count) {
            cell.layout = [self.layouts safeObjectAtIndex:indexPath.row];
        }
        return cell;
    }
    YYTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[YYTableViewCell alloc] initWithStyle:0 reuseIdentifier:@"cell"];
    }
    return cell;
}

#pragma mark - 获取文章主页数据
- (void)getArticleData{
    WEAKSELF;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"type"] = @"1";
    param[@"version"] = [NSString getNowTimeTimestamp];

    [ZMNetworkHelper requestGETWithRequestURL:DiscoveryInsetInfo parameters:param success:^(id responseObject) {
        //[MBProgressHUD hideAllHUDsForView:self animated:YES];
        if ([responseObject[@"result"] isKindOfClass:[NSDictionary class]]) {
            ZMArticleHomeModel *model = [ZMArticleHomeModel modelWithJSON:responseObject[@"result"]];
            [self.layouts removeAllObjects];
            for (ZMDiscoverArticleModel *article in model.channelPost.posts) {
                //初始化文章布局
                ZMDiscoverArticleLayout *layout = [[ZMDiscoverArticleLayout alloc] initWithStatus:article];
                [self.layouts addObject:layout];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [ZMLoadingView hideLoadingForView:weakSelf];
                self.model = model;
                [self.tableView.mj_header endRefreshing];
                [self.tableView.mj_footer resetNoMoreData];
                [self.tableView reloadData];
            });
        }
    } failure:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD showPromptMessage:@"网络错误"];
            [weakSelf.tableView.mj_header endRefreshing];
            [ZMLoadingView hideLoadingForView:weakSelf];
            if (!weakSelf.layouts.count) {
                [ZMLoadFailedView showLoadFailedInView:weakSelf topEdge:0 retryHandle:^{
                    [weakSelf getArticleData];
                }];
            }
        });
    }];
}

#pragma mark - 获取下一页文章数据
- (void)getNextData{
    WEAKSELF;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"lastId"] =    self.model.channelPost.lastId;
    param[@"pageCount"] = @(pageCount);
    param[@"type"] = @"1";
    
    //这里为了节省性能，暂时只加载5页吧，没找到优化的方法
//    if (page > 4) {
//        [self.tableView.mj_footer endRefreshingWithNoMoreData];
//        return;
//    }
    
    [ZMNetworkHelper requestGETWithRequestURL:DiscoveryInsetNextPopularPosts parameters:param success:^(id responseObject) {
        if ([responseObject[@"result"][@"posts"] isKindOfClass:[NSArray class]]) {
             NSArray *data = responseObject[@"result"][@"posts"];
            for (NSDictionary *dic in data) {
                ZMDiscoverArticleModel *model = [ZMDiscoverArticleModel modelWithJSON:dic];
                [self.model.channelPost.posts addObject:model];
                
                ZMDiscoverArticleLayout *layout = [[ZMDiscoverArticleLayout alloc] initWithStatus:model];
                [self.layouts addObject:layout];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView.mj_footer endRefreshing];
                [self.tableView reloadData];
            });
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:weakSelf animated:YES];
        [MBProgressHUD showPromptMessage:@"网络错误"];
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
    
}

@end
