//
//  ZMDiscoverRecommendView.m
//  ZMBCY
//
//  Created by Brance on 2017/11/24.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "ZMDiscoverRecommendView.h"
#import "ZMDiscoverRecommendBannerCell.h"
#import "ZMDiscoverRecommendHeadView.h"
#import "ZMDiscoverRecommendHotTopicCell.h"
#import "ZMDiscoverRecommendMoreTitleCell.h"
#import "ZMDiscoverRecommendCircleCell.h"
#import "ZMDiscoverRecommendHotRecommCell.h"

#import "ZMTopicModel.h"
#import "ZMRecommendModel.h"
#import "ZMHotRecommendModel.h"

@interface ZMDiscoverRecommendView()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) ZMDiscoverRecommendHeadView   *hotHeadView;
@property (nonatomic, strong) ZMDiscoverRecommendHeadView   *hotCircleHeadView;
@property (nonatomic, strong) ZMDiscoverRecommendHeadView   *hotRecommendHeadView;
@property (nonatomic, strong) ZMRecommendModel              *recommendModel;
@property (nonatomic, strong) ZMDiscoverRecommendHotRecommCell *cell;

@end

@implementation ZMDiscoverRecommendView
{
    NSInteger page;
    itemStyle style;
}
- (ZMDiscoverRecommendHeadView *)hotHeadView{
    if (!_hotHeadView) {
        _hotHeadView = [[ZMDiscoverRecommendHeadView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
        [_hotHeadView setupUI:@"热门专题"];
    }
    return _hotHeadView;
}
- (ZMDiscoverRecommendHeadView *)hotCircleHeadView{
    if (!_hotCircleHeadView) {
        _hotCircleHeadView = [[ZMDiscoverRecommendHeadView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
        [_hotCircleHeadView setupUI:@"热门圈子"];
    }
    return _hotCircleHeadView;
}
- (ZMDiscoverRecommendHeadView *)hotRecommendHeadView{
    if (!_hotRecommendHeadView) {
        _hotRecommendHeadView = [[ZMDiscoverRecommendHeadView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
        _hotRecommendHeadView.isShow = YES;
        WEAKSELF;
        _hotRecommendHeadView.changeStyleBlock = ^(BOOL selected){
            if (selected) {
                weakSelf.cell.style = itemStyleSingle;
                weakSelf.cell.needUpdate = YES;
                [weakSelf.tableView reloadData];
            }else{
                weakSelf.cell.style = itemStyleDouble;
                weakSelf.cell.needUpdate = YES;
                [weakSelf.tableView reloadData];
            }
        };
        [_hotRecommendHeadView setupUI:@"GACHA热推"];
    }
    return _hotRecommendHeadView;
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        page = 1;
        [self setupUI];
    }
    return self;
}

#pragma mark - 设置UI
- (void)setupUI{
    
    _tableView = [[YYTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate =   self;
    [self addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    WEAKSELF;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page = 1;
        [weakSelf getRecommendData];
    }];
//    _tableView.mj_footer = [MJRefreshNormalHeader footerWithRefreshingBlock:^{
//        page ++;
//        [weakSelf loadMoreRecommendList];
//    }];
    
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        page ++;
       [weakSelf loadMoreRecommendList];
    }];
    
    [_tableView.mj_header beginRefreshing];
}

#pragma mark - UITableViewDataSource and UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 2;
    }else if (section == 2){
        return 2;
    }else if (section == 3){
        return 1;
    }
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 119 * FIT_WIDTH;
    }else if(indexPath.section == 1){
        if (indexPath.row == 0) {
            return 190 * FIT_WIDTH + 2 + (kScreenWidth-2)/2;
        }
        return 55;
    }else if (indexPath.section == 2){
        if (indexPath.row == 0) {
            float line = ceilf(self.recommendModel.hotCircleArray.count * 1.0/3);
            return (18 + 5 + 15 + 8 + 30 + 8 + (kScreenWidth - 10 - 10 - 4)/3) * line + line * 2 + 2;
        }
        return 55;
    }else if (indexPath.section == 3){
        return self.cell.cacheHeight;
    }
    return 60;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return self.hotHeadView;
    }else if (section == 2){
        return self.hotCircleHeadView;
    }else if (section == 3){
        return self.hotRecommendHeadView;
    }
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1 || section == 2 || section == 3) {
        return 40;
    }
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        ZMDiscoverRecommendBannerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"banner"];
        if (!cell) {
            cell = [[ZMDiscoverRecommendBannerCell alloc] initWithStyle:0 reuseIdentifier:@"banner"];
        }
        [cell setupUI:@"http://gacha.nosdn.127.net/70c9f7f731f84747b4b22cfe2675f6f4.png?imageView&thumbnail=1150y366&type=png&enlarge=1&quality=100&axis=0"];
        return cell;
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            ZMDiscoverRecommendHotTopicCell *cell =[tableView dequeueReusableCellWithIdentifier:@"hotTopic"];
            if (!cell) {
                cell = [[ZMDiscoverRecommendHotTopicCell alloc] initWithStyle:0 reuseIdentifier:@"hotTopic"];
            }
            if (self.recommendModel.hotTopicArray.count) {
                [cell setupUI:self.recommendModel.hotTopicArray];
            }
            return cell;
        }
    }else if (indexPath.section == 2){
        if (indexPath.row == 0) {
            ZMDiscoverRecommendCircleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CircleCell"];
            if (!cell) {
                cell = [[ZMDiscoverRecommendCircleCell alloc] initWithStyle:0 reuseIdentifier:@"CircleCell"];
            }
            if (self.recommendModel.hotCircleArray.count) {
                [cell setupUI:self.recommendModel.hotCircleArray];
            }
            
            return cell;
        }
        
    }else if (indexPath.section == 3){
        ZMDiscoverRecommendHotRecommCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZMDiscoverRecommendHotRecommCell"];
        if (!cell) {
            cell = [[ZMDiscoverRecommendHotRecommCell alloc] initWithStyle:0 reuseIdentifier:@"ZMDiscoverRecommendHotRecommCell"];
        }
        self.cell = cell;
        if (self.recommendModel.recommendListModel.data.count) {
            [cell setDataArray:self.recommendModel.recommendListModel.data];
        }
        __weak typeof(cell) weakCell = cell;
        WEAKSELF;
        cell.updateCellHeight = ^(CGFloat height){
            weakCell.height = [self tableView:tableView heightForRowAtIndexPath:indexPath];
            [weakSelf mainQueueUpdateUI];
        };
        
        return cell;
    }
    
    if (indexPath.row == 1 && (indexPath.section == 1 || indexPath.section == 2)) {
        ZMDiscoverRecommendMoreTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"more"];
        if (!cell) {
            cell = [[ZMDiscoverRecommendMoreTitleCell alloc] initWithStyle:0 reuseIdentifier:@"more"];
        }
        if (indexPath.section == 1) {
            cell.titleLabel.text = @"查看更多专题";
        }else if (indexPath.section == 2){
            cell.titleLabel.text = @"更多热门圈子";
        }
        
        return cell;
    }
    
    YYTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[YYTableViewCell alloc] initWithStyle:0 reuseIdentifier:@"cell"];
    }
    cell.backgroundColor = [ZMColor appMainColor];
    return cell;
    
}


#pragma mark - 请求数据
- (void)getRecommendData{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"version"] = @"1511926859732";
    [ZMNetworkHelper requestGETWithRequestURL:DiscoveryRecommendInfo parameters:param success:^(id responseObject) {
        if (responseObject[@"result"] && [responseObject[@"result"][@"discoverInfos"] isKindOfClass:[NSArray class]]) {
            ZMRecommendModel *model = [[ZMRecommendModel alloc] init];
            NSArray *discoverInfos = responseObject[@"result"][@"discoverInfos"];
            for (NSDictionary *dic in discoverInfos) {
                NSString *type = dic[@"itemType"];
                //热门专题
                if ([type isEqualToString:@"hotGList"]) {
                    //尝试转换为NSString
                    id str = dic[@"data"];
                    id childArray = [str toArrayOrNSDictionary];
                    for (NSDictionary *hot in childArray) {
                        ZMTopicModel *topicModel = [ZMTopicModel modelWithJSON:hot];
                        [model.hotTopicArray addObject:topicModel];
                    }
                }
                //热门圈子
                if ([type isEqualToString:@"hotCircle"]) {
                    id str = dic[@"data"];
                    NSDictionary *childArray = [str toArrayOrNSDictionary];
                    for (NSDictionary *hot in childArray[@"list"]) {
                        ZMCircleModel *circle = [ZMCircleModel modelWithJSON:hot];
                        [model.hotCircleArray addObject:circle];
                    }
                }
                //热推
                if ([type isEqualToString:@"recommendList"]) {
                    id str = dic[@"data"];
                    id childArray = [str toArrayOrNSDictionary];
                    
                    ZMHotRecommendListModel *hotListModel = [ZMHotRecommendListModel modelWithJSON:childArray];
                    model.recommendListModel = hotListModel;
                }
            }
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.recommendModel = model;
                self.cell.needUpdate = YES;
                [self.tableView.mj_header endRefreshing];
                [self.tableView.mj_footer resetNoMoreData];
                [self.tableView reloadData];
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD showPromptMessage:@"加载缓存数据"];
                [self.tableView.mj_header endRefreshing];
                [self.tableView reloadData];
            });
        }
    } failure:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView.mj_header endRefreshing];
            [self.tableView reloadData];
        });
    }];
}

#pragma mark - 加载更多
- (void)loadMoreRecommendList{
    if (!self.recommendModel.recommendListModel.hasMore || page > 3) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
        return;
    }
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"endCosId"] = self.recommendModel.recommendListModel.endCosId;
    param[@"endPicId"] = self.recommendModel.recommendListModel.endPicId;
    
    [ZMNetworkHelper requestGETWithRequestURL:DiscoveryNextNewRecommend parameters:param success:^(id responseObject) {
        if ( [responseObject[@"result"][@"data"] isKindOfClass:[NSArray class]]) {
            NSArray *data = responseObject[@"result"][@"data"];
            for (NSDictionary *dic in data) {
                ZMHotRecommendModel *model = [ZMHotRecommendModel modelWithJSON:dic];
                [self.recommendModel.recommendListModel.data addObject:model];
            }
            self.recommendModel.recommendListModel.hasMore = [responseObject[@"result"][@"hasMore"] boolValue];
            self.recommendModel.recommendListModel.endPicId = responseObject[@"result"][@"endPicId"];
            self.recommendModel.recommendListModel.endCosId = responseObject[@"result"][@"endCosId"];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView.mj_footer endRefreshing];
                self.cell.needUpdate = YES;
                [self.tableView reloadData];
            });
        }
    } failure:^(NSError *error) {
        [self.tableView.mj_footer endRefreshing];
        [MBProgressHUD showPromptMessage:@"加载更多失败"];
    }];
}

#pragma mark - 主线程更新
- (void)mainQueueUpdateUI{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
}

@end
