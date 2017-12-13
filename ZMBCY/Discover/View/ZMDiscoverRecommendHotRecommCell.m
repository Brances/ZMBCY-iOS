//
//  ZMDiscoverRecommendHotRecommCell.m
//  ZMBCY
//
//  Created by Brance on 2017/11/28.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "ZMDiscoverRecommendHotRecommCell.h"

@interface ZMDiscoverRecommendHotRecommCell()<UICollectionViewDataSource,WaterFlowLayoutDelegate>

/** 瀑布流*/
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation ZMDiscoverRecommendHotRecommCell

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        ZMWaterFlowLayout *layout = [[ZMWaterFlowLayout alloc]init];
        WEAKSELF;
        layout.updateHeight = ^(CGFloat height){
            if (height != weakSelf.cacheHeight && self.updateCellHeight) {
                weakSelf.cacheHeight = height;
                weakSelf.updateCellHeight(height);
            }
        };
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) collectionViewLayout:layout];
        _collectionView.backgroundColor = [ZMColor appGraySpaceColor];
        _collectionView.dataSource = self;
        [_collectionView registerClass:[ZMDiscoverRecommendHotRecommCellWater class] forCellWithReuseIdentifier:@"water"];
        layout.delegate = self;
        [self.contentView addSubview:_collectionView];
    }
    return _collectionView;
}

- (void)setDataArray:(NSArray *)dataArray{
    if (!dataArray.count) return;
    _dataArray = dataArray;
    
    if (self.collectionView.height != self.cacheHeight || self.needUpdate) {
        self.collectionView.height = self.cacheHeight;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
            self.needUpdate = NO;
        });
    }
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [ZMColor appLightGrayColor];
    }
    return self;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZMDiscoverRecommendHotRecommCellWater *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"water" forIndexPath:indexPath];
    [cell setupUIWithRecommend:self.style model:self.dataArray[indexPath.item]];
    
    return cell;
}

#pragma mark - WaterFlowLayoutDelegate
- (CGFloat)WaterFlowLayout:(ZMWaterFlowLayout *)WaterFlowLayout heightForRowAtIndexPath:(NSInteger )index itemWidth:(CGFloat)itemWidth indexPath:(NSIndexPath *)indexPath{
    ZMHotRecommendModel *model = self.dataArray[index];
    if (self.style == itemStyleSingle) {
        return model.realHeight;
    }
    return model.realHeight / 2;
}
- (CGFloat)columnCountInWaterflowLayout:(ZMWaterFlowLayout *)waterflowLayout{
    if (self.style == itemStyleSingle) {
        return 1;
    }
    return 2;
}
- (CGFloat)columnMarginInWaterflowLayout:(ZMWaterFlowLayout *)waterflowLayout{
    if (self.style == itemStyleSingle) {
        return 0;
    }
    return 2;
}

- (CGFloat)rowMarginInWaterflowLayout:(ZMWaterFlowLayout *)waterflowLayout{
    if (self.style == itemStyleSingle) {
        return 10;
    }
    return 2;
}

- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(ZMWaterFlowLayout *)waterflowLayout{
    if (self.style == itemStyleSingle) {
        return UIEdgeInsetsMake(2, 0, 2, 0);
    }
    return UIEdgeInsetsMake(0, 0, 5, 0);
}


@end

@implementation ZMDiscoverRecommendHotRecommCellWater

- (UIView *)mainView{
    if (!_mainView) {
        _mainView = [UIView new];
        _mainView.userInteractionEnabled = YES;
        [self.contentView addSubview:_mainView];
        [_mainView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(0);
        }];
        [_mainView.superview layoutIfNeeded];
    }
    return _mainView;
}

- (ZMDiscoverRecommendHotRecommCellWaterView *)view{
    if (!_view) {
        _view = [[ZMDiscoverRecommendHotRecommCellWaterView alloc] init];
        [self.mainView addSubview:_view];
        [self.mainView sendSubviewToBack:_view];
        [_view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(0);
        }];
    }
    return _view;
}

- (ZMDiscoverRecommendProfileView *)profileView{
    if (!_profileView) {
        _profileView = [[ZMDiscoverRecommendProfileView alloc] init];
        _profileView.userInteractionEnabled = YES;
        [self.mainView addSubview:_profileView];
        [self.mainView bringSubviewToFront:_profileView];
        [_profileView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_equalTo(0);
            make.height.mas_equalTo(40);
        }];
        [_profileView.superview layoutIfNeeded];
    }
    return _profileView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self view];
        [self profileView];
    }
    return self;
}

- (void)setupUIWithRecommend:(itemStyle)style model:(ZMHotRecommendModel *)model{
    if (!model) return;
    _model = model;
    self.profileView.praiseButton.selected = model.hasPraise;
    self.profileView.praiseBlock = ^(BOOL selected){
        model.hasPraise = selected;
        NSLog(@"点赞 = %d",selected);
    };
    if (model.top == 1) {
        self.view.topImageView.hidden = NO;
    }else{
        self.view.topImageView.hidden = YES;
    }
    if (style == itemStyleSingle) {
        if (model.top == 1) {
            self.view.topButton.hidden = NO;
        }
        self.view.bottomShadow.hidden = NO;
        
        self.profileView.backgroundColor = [ZMColor clearColor];
        [self.profileView.thumbImageView setImageWithURL:[NSURL URLWithString:model.author.portraitFullUrl] placeholder:placeholderAvatarImage];
        self.profileView.nameLabel.textColor = [ZMColor whiteColor];
        self.profileView.nameLabel.text = model.author.nickName;
        
        
    }else{
        self.view.topButton.hidden = YES;
        self.view.bottomShadow.hidden = YES;
        self.profileView.backgroundColor = [ZMColor whiteColor];
        self.profileView.thumbImageView.image = [UIImage imageNamed:@"discovery_search_user"];
        self.profileView.nameLabel.textColor = [ZMColor blackColor];
        self.profileView.nameLabel.text = model.author.nickName;
        
    }
    NSString *string = [NSString stringWithFormat:@"%@%@?imageView&axis_5_5&enlarge=1&quality=75&thumbnail=%.0fy%.0f&type=webp",HttpImageURLPre,model.imgId,model.realWidth,model.realHeight];
    [self.view.thumbImageView setAnimationLoadingImage:[NSURL URLWithString:string] placeholder:placeholderFailImage];
    
}

- (void)setupUIWithPost:(itemStyle)style model:(ZMHotInsetPostModel *)model{
    if ([model isKindOfClass:[ZMHotInsetPostModel class]]) {
        _postModel = model;
        self.profileView.praiseButton.selected = model.hasPraise;
        self.profileView.praiseBlock = ^(BOOL selected){
            model.hasPraise = selected;
            NSLog(@"点赞 = %d",selected);
        };
        if (model.no == 1) {
            self.view.topImageView.hidden = NO;
        }else{
            self.view.topImageView.hidden = YES;
        }
        //单行
        if (style == itemStyleSingle) {
            if (model.no == 1) {
                self.view.topButton.hidden = NO;
            }
            self.view.bottomShadow.hidden = NO;
            
            self.profileView.backgroundColor = [ZMColor clearColor];
            [self.profileView.thumbImageView setImageWithURL:[NSURL URLWithString:model.author.portraitFullUrl] placeholder:placeholderAvatarImage];
            self.profileView.nameLabel.textColor = [ZMColor whiteColor];
            self.profileView.nameLabel.text = model.author.nickName;
        }else{
            self.profileView.hidden = NO;
            self.profileView.backgroundColor = [ZMColor whiteColor];
            self.view.topButton.hidden = YES;
            self.view.bottomShadow.hidden = YES;
            
            self.profileView.thumbImageView.image = [UIImage imageNamed:@"discovery_search_user"];
            self.profileView.nameLabel.textColor = [ZMColor blackColor];
            self.profileView.nameLabel.text = model.author.nickName;
            
        }
        NSString *string = [NSString stringWithFormat:@"%@%@?imageView&axis_5_5&enlarge=1&quality=75&thumbnail=%.0fy%.0f&type=webp",HttpImageURLPre,model.imgId,model.realWidth,model.realHeight];
        [self.view.thumbImageView setAnimationLoadingImage:[NSURL URLWithString:string] placeholder:placeholderFailImage];
    }
}


@end

@implementation ZMDiscoverRecommendHotRecommCellWaterView

- (UIView *)mainView{
    if (!_mainView) {
        _mainView = [UIView new];
        _mainView.userInteractionEnabled = YES;
        [self addSubview:_mainView];
        [_mainView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(0);
        }];
        [_mainView.superview layoutIfNeeded];
    }
    return _mainView;
}

- (ZMImageView *)thumbImageView{
    if (!_thumbImageView) {
        _thumbImageView = [[ZMImageView alloc] init];
        _thumbImageView.layer.masksToBounds = YES;
        [self.mainView addSubview:_thumbImageView];
        [self.mainView sendSubviewToBack:_thumbImageView];
        [_thumbImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(0);
        }];
        [_thumbImageView.superview layoutIfNeeded];
    }
    return _thumbImageView;
}

- (UIImageView *)topImageView{
    if (!_topImageView) {
        _topImageView = [UIImageView new];
        UIImage *image = [UIImage imageNamed:@"double_line_one"];
        _topImageView.image = image;
        [self.mainView addSubview:_topImageView];
        [_topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.top.mas_equalTo(10);
            make.size.mas_equalTo(image.size);
        }];
    }
    return _topImageView;
}
- (UIButton *)topButton{
    if (!_topButton) {
        _topButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _topButton.backgroundColor = [ZMColor colorWithHexString:@"#000000" alpha:0.6];
        _topButton.userInteractionEnabled = NO;
        _topButton.layer.cornerRadius = 12;
        _topButton.layer.masksToBounds = YES;
        _topButton.titleLabel.font = [UIFont systemFontOfSize:11];
        [_topButton setTitle:@"昨日Top1" forState:UIControlStateNormal];
        [_topButton setTitleColor:[ZMColor whiteColor] forState:UIControlStateNormal];
        [self.thumbImageView addSubview:_topButton];
        [_topButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(self.topImageView.mas_bottom).with.offset(2);
            make.width.mas_equalTo([NSString getTitleWidth:@"昨日Top1" withFontSize:11] + 20);
            make.height.mas_equalTo(24);
        }];
    }
    return _topButton;
}

- (UIImageView *)bottomShadow{
    if (!_bottomShadow) {
        _bottomShadow = [UIImageView new];
        _bottomShadow.userInteractionEnabled = YES;
        UIImage *image = [UIImage imageNamed:@"glist_name_bg"];
        _bottomShadow.image = image;
        [self.mainView addSubview:_bottomShadow];
        [_bottomShadow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(self.superview.height/2);
            make.left.right.bottom.mas_equalTo(0);
        }];
    }
    return _bottomShadow;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

@end


@implementation ZMDiscoverRecommendProfileView

- (UIView *)mainView{
    if (!_mainView) {
        _mainView = [UIView new];
        _mainView.userInteractionEnabled = YES;
        [self addSubview:_mainView];
        [_mainView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(0);
            make.height.mas_equalTo(40);
        }];
        [_mainView.superview layoutIfNeeded];
    }
    return _mainView;
}

- (UIImageView *)thumbImageView{
    if (!_thumbImageView) {
        _thumbImageView = [[ZMImageView alloc] init];
        _thumbImageView.userInteractionEnabled = YES;
        _thumbImageView.layer.masksToBounds = YES;
        _thumbImageView.size = CGSizeMake(20, 20);
        _thumbImageView.layer.cornerRadius = _thumbImageView.size.width * 0.5;
        [self.mainView addSubview:_thumbImageView];
        [self.mainView sendSubviewToBack:_thumbImageView];
        [_thumbImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(12);
            make.centerY.mas_equalTo(self.mainView);
            make.size.mas_equalTo(_thumbImageView.size);
        }];
        [_thumbImageView.superview layoutIfNeeded];
    }
    return _thumbImageView;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.textColor = [ZMColor whiteColor];
        _nameLabel.font = [UIFont systemFontOfSize:13];
        [self.mainView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.thumbImageView.mas_right).with.offset(10);
            make.right.mas_equalTo(self.praiseButton.mas_left).with.offset(-5);
            make.centerY.mas_equalTo(self.mainView);
        }];
    }
    return _nameLabel;
}

- (UIButton *)praiseButton{
    if (!_praiseButton) {
        _praiseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _praiseButton.userInteractionEnabled = YES;
        [_praiseButton setImage:[UIImage imageNamed:@"ill_cos_like"] forState:UIControlStateNormal];
        [_praiseButton setImage:[UIImage imageNamed:@"ill_cos_liked"] forState:UIControlStateSelected];
        [self.mainView addSubview:_praiseButton];
        
        [_praiseButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.size.mas_equalTo(CGSizeMake(30, 30));
            make.centerY.mas_equalTo(self.mainView.mas_centerY);
        }];
        [_praiseButton addTarget:self action:@selector(clickPraiseButton:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _praiseButton;
}

#pragma mark - private - TouchUpInSide
- (void)clickPraiseButton:(UIButton *)btn{
    btn.selected = !btn.selected;
    if (self.praiseBlock) {
        self.praiseBlock(btn.selected);
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"点击事件 = %@",event);
}

@end

