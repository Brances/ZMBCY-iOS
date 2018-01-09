//
//  ZMMessageView.m
//  ZMBCY
//
//  Created by ZOMAKE on 2018/1/8.
//  Copyright © 2018年 Brance. All rights reserved.
//

#import "ZMMessageView.h"
#import "ZMMessageViewCell.h"

@interface ZMMessageView()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) YYTableView    *tableView;
@property (nonatomic, strong) NSArray        *dataArray;
@property (nonatomic, strong) NSArray        *imageArray;

@end

@implementation ZMMessageView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [ZMColor appGraySpaceColor];
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    self.dataArray = @[@"互动",@"人气",@"聊天",@"公告"];
    self.imageArray = @[@"message_comment",@"message_like",@"message_privateLetter",@"message_announcement"];
    _tableView = [YYTableView new];
    _tableView.backgroundColor = [ZMColor appGraySpaceColor];
    _tableView.dataSource = self;
    _tableView.delegate =   self;
    [self addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.bottom.mas_equalTo(self.mas_bottom).with.offset(0);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZMMessageViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZMMessageViewCell"];
    if (!cell) {
        cell = [[ZMMessageViewCell alloc] initWithStyle:0 reuseIdentifier:@"ZMMessageViewCell"];
    }
    cell.iconImageView.image = [UIImage imageNamed:[self.imageArray objectAtIndex:indexPath.row]];
    cell.nameLabel.text = [self.dataArray objectAtIndex:indexPath.row];
    cell.showBottomLine = YES;
    return cell;
}

@end
