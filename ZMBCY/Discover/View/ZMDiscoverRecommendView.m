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
//@property (nonatomic, strong) NSMutableArray                *hotTopicArray;
@property (nonatomic, strong) ZMRecommendModel              *recommendModel;

@end

@implementation ZMDiscoverRecommendView

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

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
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
        [weakSelf getRecommendData];
    }];;
    
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
        return kScreenHeight;
    }
    return 60;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return self.hotHeadView;
    }else if (section == 2){
        return self.hotCircleHeadView;
    }
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1 || section == 2) {
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
        if (self.recommendModel.recommendList.count) {
            [cell setDataArray:self.recommendModel.recommendList];
        }
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
    param[@"version"] = @"1511509015";
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
                    for (NSDictionary *hotRecommend in childArray[@"data"]) {
                        ZMHotRecommendModel *hotModel = [ZMHotRecommendModel modelWithJSON:hotRecommend];
                        [model.recommendList addObject:hotModel];
                    }
                }
            }
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.recommendModel = model;
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

#pragma mark - json 字符串转字典或数组
//-  (id)toArrayOrNSDictionary:(NSString *)jsonString{
//    NSData *jsonData=[jsonString dataUsingEncoding:NSUTF8StringEncoding];
//    NSError *error = nil;
//    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData
//                                                    options:NSJSONReadingAllowFragments
//                                                      error:nil];
//    if (jsonObject != nil && error == nil){
//        return jsonObject;
//    }
//    return nil;
//}

//json格式字符串转字典：

- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) {
        
        return nil;
        
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                         options:NSJSONReadingMutableContainers
                         error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    //[self getRecommendData];
}

@end
