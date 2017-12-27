//
//  ZMPostDetailView.m
//  ZMBCY
//
//  Created by ZOMAKE on 2017/12/26.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "ZMPostDetailView.h"
#import "ZMPostDetailModel.h"
#import "ZMPostDetailViewCell.h"

@interface ZMPostDetailView()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) YYTableView       *tableView;
@property (nonatomic, strong) ZMPostDetailModel *model;

@end

@implementation ZMPostDetailView
{
    CGFloat page;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        page = 1;
        self.backgroundColor = [ZMColor appGraySpaceColor];
    }
    return self;
}

- (void)setPostId:(NSString *)postId{
    _postId = postId;
    [self setupUI];
    [ZMLoadingView showLoadingInView:self];
}

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
    
//    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//        page ++;
//        [weakSelf loadMoreRecommendList];
//    }];
    
    //[_tableView.mj_header beginRefreshing];
    [self getPostDetailData];
}

#pragma mark - UITableViewDataSource and UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 3) {
        return 2;
    }
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (!_model) return 0;
    if (indexPath.section == 0) {
        return 70;
    }
    if (indexPath.section == 1) {
        return _model.richTextHeight;
    }else if (indexPath.section == 2){
        return _model.imagesHeight;
    }else if (indexPath.section == 3 && indexPath.row == 0){
        if (_model.tags.count) {
            return 60;
        }
        return 0;
    }
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0 && _model) {
        ZMPostDetailViewUserInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZMPostDetailViewUserInfoCell"];
        if (!cell) {
            cell = [[ZMPostDetailViewUserInfoCell alloc] initWithStyle:0 reuseIdentifier:@"ZMPostDetailViewUserInfoCell"];
        }
        cell.model = self.model;
        return cell;
    }else if (indexPath.section == 1 && _model.richTextHeight){
        ZMPostDetailViewTextContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZMPostDetailViewTextContentCell"];
        if (!cell) {
            cell = [[ZMPostDetailViewTextContentCell alloc] initWithStyle:0 reuseIdentifier:@"ZMPostDetailViewTextContentCell"];
        }
        cell.model = self.model;
        return cell;
    }else if (indexPath.section == 2 && _model.downloadImgInfos.count){
        ZMPostDetailViewImageListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZMPostDetailViewImageListCell"];
        if (!cell) {
            cell = [[ZMPostDetailViewImageListCell alloc] initWithStyle:0 reuseIdentifier:@"ZMPostDetailViewImageListCell"];
        }
        cell.model = self.model;
        return cell;
    }else if (indexPath.section == 3 && _model.tags.count && indexPath.row == 0){
        ZMPostDetailViewTagCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZMPostDetailViewTagCell"];
        if (!cell) {
            cell = [[ZMPostDetailViewTagCell alloc] initWithStyle:0 reuseIdentifier:@"ZMPostDetailViewTagCell"];
        }
        cell.model = self.model;
        return cell;
    }
    
    YYTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[YYTableViewCell alloc] initWithStyle:0 reuseIdentifier:@"cell"];
    }
    cell.backgroundColor = [ZMColor appGraySpaceColor];
    return cell;
}

#pragma mark - 帖子详情
- (void)getPostDetailData{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"postID"] = _postId;
    WEAKSELF;
    [ZMNetworkHelper requestGETWithRequestURL:PostDetailInfo parameters:param success:^(id responseObject) {
        if ([responseObject[@"result"] isKindOfClass:[NSDictionary class]]) {
            ZMPostDetailModel *model = [ZMPostDetailModel modelWithJSON:responseObject[@"result"]];
            self.model = model;
            dispatch_async(dispatch_get_main_queue(), ^{
                [ZMLoadingView hideLoadingForView:weakSelf];
                [weakSelf.tableView reloadData];
            });
        }
    } failure:^(NSError *error) {
        [ZMLoadingView hideLoadingForView:weakSelf];
    }];
    
}

@end
