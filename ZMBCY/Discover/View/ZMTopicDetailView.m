//
//  ZMTopicDetailView.m
//  ZMBCY
//
//  Created by ZOMAKE on 2017/12/18.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "ZMTopicDetailView.h"


#define kHEIGHT 220.f * FIT_WIDTH
@interface ZMTopicDetailView()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) YYTableView       *tableView;
/** 头部容器 */
@property (nonatomic, strong) UIView        *headView;
/** 头部放大图片 */
@property (nonatomic, strong) UIImageView       *headImageView;

@end

@implementation ZMTopicDetailView
-(UIView *)headView{
    if (!_headView) {
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kHEIGHT)];
        self.headView = headView;
        [self.headView addSubview:self.headImageView];
    }
    return _headView;
}
-(UIImageView *)headImageView{
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.headView.height)];
        //self.headImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.headImageView.image = [YYImage imageWithColor:[ZMColor appMainColor]];
        //[self.headView addSubview:_headImageView];
    }
    return _headImageView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //[self setupUI];
    }
    return self;
}

- (void)setUid:(NSString *)uid{
    if (uid.length) {
        [self setupUI];
    }
}

- (void)setupUI{
    self.tableView = [YYTableView new];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self addSubview:self.tableView];
    //头部视图
    self.tableView.tableHeaderView = self.headView;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];
}

#pragma mark - UITableViewDataSource UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
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
    CGPoint point = scrollView.contentOffset;
    if (point.y < 0) {
        CGRect rects = _headImageView.frame;
        rects.origin.y = point.y;
        rects.size.height = ABS(point.y) + kHEIGHT;
        NSLog(@"下拉高度 = %.2f",rects.size.height);
        _headImageView.frame = rects;
    }
}

#pragma mark - 获取专题数据
- (void)getTopicData{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"id"] = _uid;
    
    [ZMNetworkHelper requestGETWithRequestURL:DiscoverTopicCollectInfo parameters:param success:^(id responseObject) {
        
        
        
    } failure:^(NSError *error) {
        
    }];
    
}

@end
