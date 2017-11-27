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
#import "ZMTopicModel.h"

@interface ZMDiscoverRecommendView()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) ZMDiscoverRecommendHeadView   *hotHeadView;
@property (nonatomic, strong) ZMTopicModel                  *hotTopicModel;


@end

@implementation ZMDiscoverRecommendView

- (ZMDiscoverRecommendHeadView *)hotHeadView{
    if (!_hotHeadView) {
        _hotHeadView = [[ZMDiscoverRecommendHeadView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
        [_hotHeadView setupUI:@"热门专题"];
    }
    return _hotHeadView;
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
    
    _tableView = [YYTableView new];
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
    
    [self getRecommendData];
}

#pragma mark - UITableViewDataSource and UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 119 * FIT_WIDTH;
    }else if(indexPath.section == 1){
        return 190 * FIT_WIDTH + 2 + (kScreenWidth-2)/2;
    }
    return 60;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return self.hotHeadView;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return 40;
    }
    return 0.01;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        static NSString *identfier = @"banner";
        ZMDiscoverRecommendBannerCell *cell = [tableView dequeueReusableCellWithIdentifier:identfier];
        if (!cell) {
            cell = [[ZMDiscoverRecommendBannerCell alloc] initWithStyle:0 reuseIdentifier:identfier];
        }
        [cell setupUI:@"http://gacha.nosdn.127.net/70c9f7f731f84747b4b22cfe2675f6f4.png?imageView&thumbnail=1150y366&type=png&enlarge=1&quality=100&axis=0"];
        return cell;
    }else if (indexPath.section == 1){
        static NSString *identfier = @"hotTopic";
        ZMDiscoverRecommendHotTopicCell *cell =[tableView dequeueReusableCellWithIdentifier:identfier];
        if (!cell) {
            cell = [[ZMDiscoverRecommendHotTopicCell alloc] initWithStyle:0 reuseIdentifier:identfier];
        }
        if (self.hotTopicModel) {
            cell.model = self.hotTopicModel;
        }
        return cell;
    }
    
    
    YYTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[YYTableViewCell alloc] initWithStyle:0 reuseIdentifier:@"cell"];
    }
    cell.backgroundColor = [UIColor redColor];
    return cell;
    
}


#pragma mark - 请求数据
- (void)getRecommendData{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"version"] = @"1511509015";
    [ZMNetworkHelper requestGETWithRequestURL:DiscoveryRecommendInfo parameters:param success:^(id responseObject) {
        if (responseObject[@"result"] && [responseObject[@"result"][@"discoverInfos"] isKindOfClass:[NSArray class]]) {
            NSArray *discoverInfos = responseObject[@"result"][@"discoverInfos"];
            NSLog(@"%@",discoverInfos);
            
            for (NSDictionary *dic in discoverInfos) {
                NSString *type = dic[@"itemType"];
                //热门专题
                if ([type isEqualToString:@"hotGList"]) {
                    //尝试转换为NSString
                    id str = dic[@"data"];
                    id childArray = [str toArrayOrNSDictionary];
                    for (NSDictionary *hot in childArray) {
                        ZMTopicModel *topicModel = [ZMTopicModel modelWithJSON:hot];
                        self.hotTopicModel = topicModel;
                        [self.tableView reloadData];
                        NSLog(@"是否私有=%@",topicModel);
                    }
                    //NSLog(@"字符串 = %@",childArray);
                }
                
            }
            dispatch_async(dispatch_get_main_queue(), ^{
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
