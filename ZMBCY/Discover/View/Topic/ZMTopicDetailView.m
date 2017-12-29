//
//  ZMTopicDetailView.m
//  ZMBCY
//
//  Created by Brance on 2017/12/18.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "ZMTopicDetailView.h"
#import "ZMTopicDetailHeaderView.h"
#import "ZMTopicDetailModel.h"
#import "ZMTopicDetailSubjectModel.h"
#import "ZMTopicDetailOperationView.h"
#import "ZMTopicDetailSubjectCell.h"

@interface ZMTopicDetailView()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) YYTableView               *tableView;
@property (nonatomic, strong) ZMTopicDetailHeaderView   *headView;
@property (nonatomic, strong) ZMTopicDetailOperationView  *operationView;
@property (nonatomic, strong) ZMTopicDetailModel        *topicModel;
@property (nonatomic, strong) NSMutableArray            *subjectArray;
@property (nonatomic, strong) ZMTopicDetailSubjectCell  *cell;


@end

@implementation ZMTopicDetailView
{
    CGFloat kHEIGHT;
    CGFloat count;
}

-(ZMTopicDetailHeaderView *)headView{
    if (!_headView) {
        ZMTopicDetailHeaderView *headView = [[ZMTopicDetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kHEIGHT)];
        self.headView = headView;
        self.headView.model = self.topicModel;
    }
    return _headView;
}

- (ZMTopicDetailOperationView *)operationView{
    if (!_operationView) {
        _operationView = [[ZMTopicDetailOperationView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 45)];
        _operationView.model = self.topicModel;
        WEAKSELF;
        _operationView.changeStyleBlock = ^(BOOL selected){
            if (selected) {
                weakSelf.cell.style = itemStyleSingle;
            }else{
                weakSelf.cell.style = itemStyleDouble;
            }
            weakSelf.cell.needUpdate = YES;
            [weakSelf.tableView reloadData];
        };
        
    }
    return _operationView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //给一个大概高度
        kHEIGHT = 220;
        count = 10;
        self.subjectArray = [NSMutableArray new];
    }
    return self;
}

- (void)setUid:(NSString *)uid{
    if (uid.length) {
        _uid = uid;
        [self setupUI];
        [ZMLoadingView showLoadingInView:self];
        [self globalTask];
    }
}

- (void)setupUI{
    self.tableView = [[YYTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];
    WEAKSELF;
    self.tableView.mj_footer = [ZMCustomGifFooter footerWithRefreshingBlock:^{
        [weakSelf getNextData];
    }];
    
}

#pragma mark - UITableViewDataSource UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (!_topicModel) return nil;
    if (section == 0) {
        return self.operationView;
    }
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (!_topicModel) return 0.01;
    if (section == 0) {
        return 45;
    }
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.cell.cacheHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0){
        static NSString *identify = @"ZMTopicDetailSubjectCell";
        ZMTopicDetailSubjectCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
        if (!cell) {
            cell = [[ZMTopicDetailSubjectCell alloc] initWithStyle:0 reuseIdentifier:identify];
        }
        self.cell = cell;
        if (self.subjectArray.count) {
            [cell setDataArray:self.subjectArray];
        }
        __weak typeof(cell) weakCell = cell;
        WEAKSELF;
        cell.updateCellHeight = ^(CGFloat height){
            weakCell.height = [self tableView:tableView heightForRowAtIndexPath:indexPath];
            [weakSelf mainQueueUpdateUI];
        };
        
        return cell;
    }
    
    static NSString *identify = @"cell";
    YYTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[YYTableViewCell alloc] initWithStyle:0 reuseIdentifier:identify];
    }
    cell.backgroundColor = [ZMColor appGraySpaceColor];
    return cell;
    
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y;
    NSLog(@"下拉位置 = %.2f",offsetY);
    if (offsetY < 0) {
        CGRect rects =  self.headView.mainView.frame;
        rects.origin.y = offsetY;
        rects.size.height = ABS(offsetY) + kHEIGHT;
        self.headView.mainView.frame = rects;
    }
    if (offsetY >= kHEIGHT - 64) {
        [self.nav.centerButton setTitle:_topicModel.collect_name forState:UIControlStateNormal];
        [self.nav.centerButton setTitleColor:[ZMColor whiteColor] forState:UIControlStateNormal];
    }else if (offsetY > 0 && offsetY <kHEIGHT){
        [self.nav.centerButton setTitle:@"" forState:UIControlStateNormal];
    }
    CGFloat minAlphaOffset = 64;
    CGFloat maxAlphaOffset = kHEIGHT - 64;
    CGFloat offset = scrollView.contentOffset.y;
    CGFloat alpha = (offset - minAlphaOffset) / (maxAlphaOffset - minAlphaOffset);
    self.nav.backgroundColor = [ZMColor colorWithHexString:@"#00DA8C" alpha:alpha];
    NSLog(@"透明度变化 = %.2f",alpha);
}

#pragma mark - 队列组
- (void)globalTask{
    //1.创建队列组
    dispatch_group_t group = dispatch_group_create();
    //2.创建队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //3.添加请求
    dispatch_group_async(group, queue, ^{
        dispatch_group_enter(group);
        WEAKSELF;
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        param[@"id"] = _uid;
        [ZMNetworkHelper requestGETWithRequestURL:DiscoverTopicCollectInfo parameters:param success:^(id responseObject) {
            if ([responseObject[@"result"] isKindOfClass:[NSDictionary class]]) {
                ZMTopicDetailModel *model = [ZMTopicDetailModel modelWithJSON:responseObject[@"result"]];
                weakSelf.topicModel = model;
                kHEIGHT = weakSelf.topicModel.height;
                weakSelf.tableView.tableHeaderView = self.headView;
            }
            dispatch_group_leave(group);
        } failure:^(NSError *error) {
            dispatch_group_leave(group);
        }];
        
        
    });
    dispatch_group_async(group, queue, ^{
        dispatch_group_enter(group);
        //帖子列表
        WEAKSELF;
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        param[@"id"] = _uid;
        param[@"count"] = @(count);
        [ZMNetworkHelper requestGETWithRequestURL:DiscoverTopicSublist parameters:param success:^(id responseObject) {
            if ([responseObject[@"result"] isKindOfClass:[NSArray class]]) {
                [weakSelf.subjectArray removeAllObjects];
                NSArray *subArray = responseObject[@"result"];
                for (NSDictionary *subDic in subArray) {
                    ZMTopicDetailSubjectModel *subModel = [ZMTopicDetailSubjectModel modelWithJSON:subDic];
                    [weakSelf.subjectArray addObject:subModel];
                }
            }
            dispatch_group_leave(group);
        } failure:^(NSError *error) {
            dispatch_group_leave(group);
        }];
    });
    
    //4.队列组所有请求完成回调刷新UI
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        [ZMLoadingView hideLoadingForView:self];
        [self.tableView reloadData];
    });
}

#pragma mark - 下一页数据
- (void)getNextData{
    WEAKSELF;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"id"] = _uid;
    param[@"count"] = @(count);
    param[@"offset"] = ((ZMTopicDetailSubjectModel *)[self.subjectArray lastObject]).post_id;
    
    [ZMNetworkHelper requestGETWithRequestURL:DiscoverTopicSublist parameters:param success:^(id responseObject) {
        if ([responseObject[@"result"] isKindOfClass:[NSArray class]]) {
            NSArray *subArray = responseObject[@"result"];
            for (NSDictionary *subDic in subArray) {
                ZMTopicDetailSubjectModel *subModel = [ZMTopicDetailSubjectModel modelWithJSON:subDic];
                [weakSelf.subjectArray addObject:subModel];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                if (subArray.count < count) {
                    [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
                }else{
                    [weakSelf.tableView.mj_footer endRefreshing];
                }
                weakSelf.cell.needUpdate = YES;
                [weakSelf.tableView reloadData];
            });
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showPromptMessage:@"网络异常"];
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark - 主线程更新
- (void)mainQueueUpdateUI{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

@end
