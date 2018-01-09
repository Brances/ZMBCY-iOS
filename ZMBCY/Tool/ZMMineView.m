//
//  ZMMineView.m
//  ZMBCY
//
//  Created by ZOMAKE on 2018/1/8.
//  Copyright © 2018年 Brance. All rights reserved.
//

#import "ZMMineView.h"
#import "ZMMineLoginViewCell.h"

@interface ZMMineView()<UITableViewDataSource,UITableViewDelegate>


//@property (nonatomic, strong) YYTableView       *tableView;

@end

@implementation ZMMineView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [ZMColor whiteColor];
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    _tableView = [YYTableView new];
    _tableView.backgroundColor = [ZMColor appGraySpaceColor];
    _tableView.dataSource = self;
    _tableView.delegate =   self;
    [self addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.bottom.mas_equalTo(self.mas_bottom).with.offset(0);
    }];
    UIView *headView = [UIView new];
    headView.backgroundColor = [ZMColor whiteColor];
    headView.size = CGSizeMake(kScreenWidth, 64);
    _tableView.tableHeaderView = headView;
    
    //监听登录状态
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(monitorLoginState) name:KLoginStateChangeNotice object:nil];
    //监听用户资料
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateUserInfo) name:KUpdateUserInfoNotice object:nil];
}

#pragma mark - UITableViewDataSource and UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 140;
    }
    return 201;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        ZMMineLoginViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZMMineLoginViewCell"];
        if (!cell) {
            cell = [[ZMMineLoginViewCell alloc] initWithStyle:0 reuseIdentifier:@"ZMMineLoginViewCell"];
        }
        [cell setupUI];
        return cell;
    }else if (indexPath.section == 1){
        ZMMineCollectionViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZMMineCollectionViewCell"];
        if (!cell) {
            cell = [[ZMMineCollectionViewCell alloc] initWithStyle:0 reuseIdentifier:@"ZMMineCollectionViewCell"];
        }
        return cell;
    }
    
    
    YYTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[YYTableViewCell alloc] initWithStyle:0 reuseIdentifier:@"cell"];
    }
    cell.backgroundColor = [ZMColor appGraySpaceColor];
    return cell;
}

#pragma mark - 登录状态改变
- (void)monitorLoginState{
    //刷新表格咯
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

#pragma mark - 更新用户资料（头像）
- (void)updateUserInfo{
    //刷新表格咯
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
