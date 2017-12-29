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
#import "ZMCommentModel.h"
#import "ZMPostDetailViewCell.h"
#import "ZMCommentCell.h"
#import "ZMPostDetailBottomToolView.h"

@interface ZMPostDetailView()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) YYTableView       *tableView;
@property (nonatomic, strong) ZMPostDetailModel *model;
@property (nonatomic, strong) NSMutableArray    *hotCommentArray;
@property (nonatomic, strong) NSMutableArray    *commentArray;
@property (nonatomic, strong) UIView            *hotCommentHeaderView;
@property (nonatomic, strong) UIView            *commentHeaderView;
@property (nonatomic, strong) ZMPostDetailBottomToolView    *bottomToolView;

@end

@implementation ZMPostDetailView
{
    CGFloat page,count;
}
- (UIView *)hotCommentHeaderView{
    if (!_hotCommentHeaderView) {
        _hotCommentHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 60)];
        _hotCommentHeaderView.backgroundColor = [ZMColor appGraySpaceColor];
        UIImageView *topLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5)];
        topLine.image = [YYImage imageWithColor:[ZMColor appBottomLineColor]];
        [_hotCommentHeaderView addSubview:topLine];
        UIImageView *bottomLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, _hotCommentHeaderView.height - 0.5, kScreenWidth, 0.5)];
        bottomLine.image = [YYImage imageWithColor:[ZMColor appBottomLineColor]];
        [_hotCommentHeaderView addSubview:bottomLine];
        
        ZMPostDetailViewHeaderView *view = [[ZMPostDetailViewHeaderView alloc] initWithFrame:CGRectMake(0, _hotCommentHeaderView.height - 50 - 0.5, kScreenWidth, 50)];
        ZMDiscoverHeadModel *HeadModel = [[ZMDiscoverHeadModel alloc] init];
        HeadModel.title = @"热门评论";
        HeadModel.icon  = [YYImage imageNamed:@"postDetail_section_hotCommentIcon~iphone"];
        view.model = HeadModel;
        view.titleLabel.textColor = [ZMColor appSupportColor];
        [_hotCommentHeaderView addSubview:view];
    }
    return _hotCommentHeaderView;
}
- (UIView *)commentHeaderView{
    if (!_commentHeaderView) {
        _commentHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 60)];
        _commentHeaderView.backgroundColor = [ZMColor appGraySpaceColor];
        UIImageView *topLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5)];
        topLine.image = [YYImage imageWithColor:[ZMColor appBottomLineColor]];
        [_commentHeaderView addSubview:topLine];
        UIImageView *bottomLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, _commentHeaderView.height - 0.5, kScreenWidth, 0.5)];
        bottomLine.image = [YYImage imageWithColor:[ZMColor appBottomLineColor]];
        [_commentHeaderView addSubview:bottomLine];
        
        ZMPostDetailViewHeaderView *view = [[ZMPostDetailViewHeaderView alloc] initWithFrame:CGRectMake(0, _commentHeaderView.height - 50 - 0.5, kScreenWidth, 50)];
        ZMDiscoverHeadModel *HeadModel = [[ZMDiscoverHeadModel alloc] init];
        HeadModel.title = @"全部评论";
        HeadModel.icon  = [YYImage imageNamed:@"postDetaial_section_icon~iphone"];
        view.model = HeadModel;
        view.titleLabel.textColor = [ZMColor appSupportColor];
        [_commentHeaderView addSubview:view];
    }
    return _commentHeaderView;
}

- (ZMPostDetailBottomToolView *)bottomToolView{
    if (!_bottomToolView) {
        _bottomToolView = [[ZMPostDetailBottomToolView alloc] initWithFrame:CGRectZero];
        _bottomToolView.backgroundColor = [ZMColor clearColor];
        WEAKSELF;
        _bottomToolView.clickPraiseBlock = ^(BOOL selected){
            selected ? weakSelf.model.supportCount++ : weakSelf.model.supportCount--;
            weakSelf.bottomToolView.count = [NSString stringWithFormat:@"%ld",(long)weakSelf.model.supportCount];
        };
        [self addSubview:_bottomToolView];
        [_bottomToolView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.height.mas_equalTo(60);
        }];
    }
    return _bottomToolView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [ZMColor appGraySpaceColor];
    }
    return self;
}

- (void)setPostId:(NSString *)postId{
    _postId = postId;
    count = 10;
    page = 0;
    _hotCommentArray =  [NSMutableArray new];
    _commentArray =     [NSMutableArray new];
    [self setupUI];
    
    [self getPostDetailData];
    
}

- (void)setupUI{
    
    _tableView = [[YYTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.backgroundColor = [ZMColor appGraySpaceColor];
    _tableView.dataSource = self;
    _tableView.delegate =   self;
    [self addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.bottom.mas_equalTo(self.bottomToolView.mas_top).with.offset(0);
    }];
    WEAKSELF;
    _tableView.mj_footer = [ZMCustomGifFooter footerWithRefreshingBlock:^{
        page ++;
        [weakSelf getCommentListData];
    }];
}

#pragma mark - UITableViewDataSource and UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //1-：用户、正文、图片、标签，2-：点赞的人，3-：猜你喜欢，4-：热评，5-：全部评论
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    self.tableView.mj_footer.hidden = _commentArray.count == 0;
    
    if (section == 0) {
        return 4;
    }else if (section == 1){
        return 1;
    }else if (section == 2){
        return 1;
    }else if (section == 3){
        return _hotCommentArray.count;
    }else if (section == 4){
        return _commentArray.count;
    }
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (!_model) return 0;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 70;
        }else if (indexPath.row == 1){
            return _model.richTextHeight;
        }else if (indexPath.row == 2){
            return _model.imagesHeight;
        }else if (indexPath.row == 3 && _model.tags.count){
            return 60;
        }
        return 0;
    }else if (indexPath.section == 1 && _model.supportArray.count){
        return 65;
    }else if (indexPath.section == 2 && _model.relatedPosts.count){
        return 10 + 50 + [_model.relatedPosts firstObject].cover.realHeight + 15;
    }else if (indexPath.section == 3 && _hotCommentArray.count){
        return ((ZMCommentModel *)[self.hotCommentArray safeObjectAtIndex:indexPath.row]).height;

    }else if (indexPath.section == 4 && _commentArray.count){
        return ((ZMCommentModel *)[self.commentArray safeObjectAtIndex:indexPath.row]).height;
        
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 3 && _hotCommentArray.count) {
        return self.hotCommentHeaderView;
    }else if (section == 4 && _commentArray.count) {
        return self.commentHeaderView;
    }
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 3 && _hotCommentArray.count) {
        return 60;
    }if (section == 4 && _commentArray.count) {
        return 60;
    }
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0 && _model) {
        if (indexPath.row == 0) {
            ZMPostDetailViewUserInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZMPostDetailViewUserInfoCell"];
            if (!cell) {
                cell = [[ZMPostDetailViewUserInfoCell alloc] initWithStyle:0 reuseIdentifier:@"ZMPostDetailViewUserInfoCell"];
            }
            cell.model = self.model;
            return cell;
        }else if (indexPath.row == 1 && _model.richTextHeight){
            ZMPostDetailViewTextContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZMPostDetailViewTextContentCell"];
            if (!cell) {
                cell = [[ZMPostDetailViewTextContentCell alloc] initWithStyle:0 reuseIdentifier:@"ZMPostDetailViewTextContentCell"];
            }
            cell.model = self.model;
            return cell;
        }else if (indexPath.row == 2 && _model.downloadImgInfos.count){
            ZMPostDetailViewImageListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZMPostDetailViewImageListCell"];
            if (!cell) {
                cell = [[ZMPostDetailViewImageListCell alloc] initWithStyle:0 reuseIdentifier:@"ZMPostDetailViewImageListCell"];
            }
            cell.model = self.model;
            return cell;
        }else if (indexPath.row == 3 && _model.tags.count){
            ZMPostDetailViewTagCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZMPostDetailViewTagCell"];
            if (!cell) {
                cell = [[ZMPostDetailViewTagCell alloc] initWithStyle:0 reuseIdentifier:@"ZMPostDetailViewTagCell"];
            }
            cell.model = self.model;
            return cell;
        }
    }else if (indexPath.section == 1 && _model.supportArray.count){
        ZMPostDetailViewPraiseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZMPostDetailViewPraiseCell"];
        if (!cell) {
            cell = [[ZMPostDetailViewPraiseCell alloc] initWithStyle:0 reuseIdentifier:@"ZMPostDetailViewPraiseCell"];
        }
        cell.height = [self tableView:tableView heightForRowAtIndexPath:indexPath];
        cell.width = kScreenWidth;
        cell.model = _model;
        return cell;
    }else if (indexPath.section == 2 && _model.relatedPosts.count){
        ZMPostDetailViewRelatedPostsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZMPostDetailViewRelatedPostsCell"];
        if (!cell) {
            cell = [[ZMPostDetailViewRelatedPostsCell alloc] initWithStyle:0 reuseIdentifier:@"ZMPostDetailViewRelatedPostsCell"];
        }
        cell.height = [self tableView:tableView heightForRowAtIndexPath:indexPath];
        cell.width = kScreenWidth;
        cell.model = self.model;
        return cell;
    }else if (indexPath.section == 3 && _hotCommentArray.count){
        ZMCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZMHotCommentCell"];
        if (!cell) {
            cell = [[ZMCommentCell alloc] initWithStyle:0 reuseIdentifier:@"ZMHotCommentCell"];
        }
        cell.model = (ZMCommentModel *)[self.hotCommentArray safeObjectAtIndex:indexPath.row];
        cell.userOperationView.showTopLine = indexPath.row ? YES : NO;
        return cell;
    }else if (indexPath.section == 4 && _commentArray.count){
        ZMCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZMCommentCell"];
        if (!cell) {
            cell = [[ZMCommentCell alloc] initWithStyle:0 reuseIdentifier:@"ZMCommentCell"];
        }
        cell.model = (ZMCommentModel *)[self.commentArray safeObjectAtIndex:indexPath.row];
        cell.userOperationView.showTopLine = indexPath.row ? YES : NO;
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
    if (!_model) {
        [ZMLoadingView showLoadingInView:self];
    }
    WEAKSELF;
    [ZMNetworkHelper requestGETWithRequestURL:PostDetailInfo parameters:param success:^(id responseObject) {
        if ([responseObject[@"result"] isKindOfClass:[NSDictionary class]]) {
            ZMPostDetailModel *model = [ZMPostDetailModel modelWithJSON:responseObject[@"result"]];
            weakSelf.model = model;
            [weakSelf getPostPraiseListData];
            [weakSelf getHotCommentListData];
            [weakSelf getCommentListData];
            dispatch_async(dispatch_get_main_queue(), ^{
                [ZMLoadingView hideLoadingForView:weakSelf];
                weakSelf.bottomToolView.collectButton.selected = model.isCollect;
                weakSelf.bottomToolView.praiseButton.selected = model.isSupport;
                [weakSelf.bottomToolView.commentButton setTitle:[NSString stringWithFormat:@"评论(%ld)",(long)model.commentCount] forState:UIControlStateNormal];
                weakSelf.bottomToolView.count = [NSString stringWithFormat:@"%ld",(long)model.supportCount];
                [weakSelf.tableView reloadData];
            });
        }
    } failure:^(NSError *error) {
        [ZMLoadingView hideLoadingForView:weakSelf];
        [ZMLoadFailedView showLoadFailedInView:weakSelf topEdge:0 retryHandle:^{
            [weakSelf getPostDetailData];
        }];
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

#pragma mark - 热评（可能为空）
- (void)getHotCommentListData{
    WEAKSELF;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"postID"] = _postId;
    [ZMNetworkHelper requestGETWithRequestURL:PostHotcommentsList parameters:param success:^(id responseObject) {
        if ([responseObject[@"result"] isKindOfClass:[NSArray class]]) {
            NSArray *result = responseObject[@"result"];
            for (NSDictionary *dic in result) {
                ZMCommentModel *model = [ZMCommentModel modelWithJSON:dic];
                [weakSelf.hotCommentArray addObject:model];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.tableView reloadData];
            });
        }
    } failure:^(NSError *error) {
    }];
    
}

#pragma mark - 评论列表 （可能为空）
- (void)getCommentListData{
    WEAKSELF;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"postID"] = _postId;
    param[@"commentCount"] = @(count);
    param[@"dir"] = @(page);
    
    //如果不是第一页
    if (self.commentArray.count) {
        param[@"startCommentID"] = ((ZMCommentModel *)[self.commentArray lastObject]).cid;
    }
    
    [ZMNetworkHelper requestGETWithRequestURL:PostCommentsList parameters:param success:^(id responseObject) {
         if ([responseObject[@"result"] isKindOfClass:[NSArray class]]) {
             NSArray *result = responseObject[@"result"];
             for (NSDictionary *dic in result) {
                 ZMCommentModel *model = [ZMCommentModel modelWithJSON:dic];
                 [weakSelf.commentArray addObject:model];
             }
             dispatch_async(dispatch_get_main_queue(), ^{
                 if (result.count < count) {
                     [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
                 }else{
                     [weakSelf.tableView.mj_footer endRefreshing];
                 }
                 [weakSelf.tableView reloadData];
             });
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showPromptMessage:@"网络错误"];
    }];
    
}

@end
