//
//  ZMPostDetailView.m
//  ZMBCY
//
//  Created by Brance on 2017/12/26.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "ZMPostDetailView.h"
#import "ZMPostDetailModel.h"
#import "ZMPostDetailPraiseAuthorModel.h"
#import "ZMPostDetailViewCell.h"

@interface ZMPostDetailView()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) YYTableView       *tableView;
@property (nonatomic, strong) ZMPostDetailModel *model;
//@property (nonatomic, strong) NSMutableArray    *praiseArray;

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
    //_praiseArray = [NSMutableArray new];
    [self setupUI];
    [ZMLoadingView showLoadingInView:self];
    [self getPostDetailData];
    
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
    //WEAKSELF;
    
//    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//        page ++;
//        [weakSelf loadMoreRecommendList];
//    }];
    
    //[_tableView.mj_header beginRefreshing];
    
}

#pragma mark - UITableViewDataSource and UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 6;
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
    }else if (indexPath.section == 4 && _model.supportArray.count){
        return 65;
    }else if (indexPath.section == 5 && _model.relatedPosts.count){
        return 10 + 50 + [_model.relatedPosts firstObject].cover.realHeight + 15;
    }
    return 0;
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
    }else if (indexPath.section == 4 && _model.supportArray.count){
        ZMPostDetailViewPraiseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZMPostDetailViewPraiseCell"];
        if (!cell) {
            cell = [[ZMPostDetailViewPraiseCell alloc] initWithStyle:0 reuseIdentifier:@"ZMPostDetailViewPraiseCell"];
        }
        cell.height = [self tableView:tableView heightForRowAtIndexPath:indexPath];
        cell.width = kScreenWidth;
        cell.model = _model;
        return cell;
    }else if (indexPath.section == 5 && _model.relatedPosts.count){
        ZMPostDetailViewRelatedPostsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZMPostDetailViewRelatedPostsCell"];
        if (!cell) {
            cell = [[ZMPostDetailViewRelatedPostsCell alloc] initWithStyle:0 reuseIdentifier:@"ZMPostDetailViewRelatedPostsCell"];
        }
        cell.height = [self tableView:tableView heightForRowAtIndexPath:indexPath];
        cell.width = kScreenWidth;
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
            weakSelf.model = model;
            [weakSelf getPostPraiseListData];
            dispatch_async(dispatch_get_main_queue(), ^{
                [ZMLoadingView hideLoadingForView:weakSelf];
                [weakSelf.tableView reloadData];
            });
        }
    } failure:^(NSError *error) {
        [ZMLoadingView hideLoadingForView:weakSelf];
    }];
    
}

#pragma mark - 喜欢这个帖子的人的列表
- (void)getPostPraiseListData{
    WEAKSELF;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"postId"] = _postId;
    param[@"limit"] = @"10";
    param[@"offset"] = @"0";
    [ZMNetworkHelper requestGETWithRequestURL:PostSupportUsersList parameters:param success:^(id responseObject) {
        if ([responseObject[@"result"] isKindOfClass:[NSArray class]]) {
            NSArray *result = responseObject[@"result"];
            NSMutableArray  *temp = [NSMutableArray new];
            for (NSDictionary *dic in result) {
                ZMPostDetailPraiseAuthorModel *model = [ZMPostDetailPraiseAuthorModel modelWithJSON:dic];
                [temp addObject:model];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.model.supportArray = temp;
                [weakSelf.tableView reloadData];
            });
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showPromptMessage:@"网络错误"];
    }];
    
}

@end
