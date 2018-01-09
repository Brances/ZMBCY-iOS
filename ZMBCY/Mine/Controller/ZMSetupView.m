//
//  ZMSetupView.m
//  ZMBCY
//
//  Created by ZOMAKE on 2018/1/8.
//  Copyright © 2018年 Brance. All rights reserved.
//

#import "ZMSetupView.h"
#import "ZMSetupViewCell.h"

@interface ZMSetupView()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) YYTableView       *tableView;
@property (nonatomic, strong) NSArray           *dataArray;

@end

@implementation ZMSetupView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    self.dataArray = @[@"清除缓存",@"关于GACHA",@"服务条款",@"意见反馈",@"评价我们"];
    _tableView = [[YYTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.backgroundColor = [ZMColor appGraySpaceColor];
    _tableView.dataSource = self;
    _tableView.delegate =   self;
    [self addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.bottom.mas_equalTo(self.mas_bottom).with.offset(0);
    }];
    
    if ([ZMUserInfo shareUserInfo].isLogin) {
        UIView *view = [UIView new];
        view.size = CGSizeMake(kScreenWidth, 60);
        UIButton *loginOutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        loginOutBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        loginOutBtn.backgroundColor = [ZMColor whiteColor];
        [loginOutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
        [loginOutBtn setTitleColor:[ZMColor blackColor] forState:UIControlStateNormal];
        [view addSubview:loginOutBtn];
        [loginOutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(40);
            make.centerY.mas_equalTo(view);
        }];
        [loginOutBtn addTarget:self action:@selector(clickLoginOut) forControlEvents:UIControlEventTouchUpInside];
        _tableView.tableFooterView = view;
    }
    
}

#pragma mark - UITableViewDataSource and UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *head = [UIView new];
    head.backgroundColor = [ZMColor appGraySpaceColor];
    return head;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZMSetupViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZMSetupViewCell"];
    if (!cell) {
        cell = [[ZMSetupViewCell alloc] initWithStyle:0 reuseIdentifier:@"ZMSetupViewCell"];
    }
    cell.nameLabel.text = [self.dataArray objectAtIndex:indexPath.row];
    if (self.dataArray.count-1 == indexPath.row) {
        cell.showBottomLine = NO;
    }else{
        cell.showBottomLine = YES;
    }
    return cell;
}

#pragma mark - 退出登录
- (void)clickLoginOut{
    [AVUser logOut];
    [[ZMUserInfo shareUserInfo] loginOut];
    [[NSNotificationCenter defaultCenter] postNotificationName:KLoginStateChangeNotice object:nil];
    [self.viewController.navigationController popViewControllerAnimated:YES];
}

@end
