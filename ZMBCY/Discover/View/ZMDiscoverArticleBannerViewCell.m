//
//  ZMDiscoverArticleBannerViewCell.m
//  ZMBCY
//
//  Created by ZOMAKE on 2017/12/7.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "ZMDiscoverArticleBannerViewCell.h"
#import "ZMICarouselView.h"
#import "ZMDiscoverArticleModel.h"

@interface ZMDiscoverArticleBannerViewCell()<ZMICarouselViewDataSource,ZMICarouselViewDelegate>

@property (nonatomic, strong) ZMICarouselView *carouseView;
@property (nonatomic, strong) UIImageView     *mainView;
@property (nonatomic, strong) UILabel         *nameLabel;
@property (nonatomic, strong) UILabel         *tagLabel;
@property (nonatomic, strong) UIButton        *readButton;

@end

@implementation ZMDiscoverArticleBannerViewCell

- (ZMICarouselView *)carouseView{
    if (!_carouseView) {
        _carouseView = [ZMICarouselView icarouselViewWithFrame:CGRectMake(0, 0, kScreenWidth, self.height)];
        self.carouseView.delegate = self;
        self.carouseView.dataSource = self;
        self.carouseView.showPageControl = YES;
        self.carouseView.pageControlStyle = ZMICarouselPageContolStyleAnimated;
        self.carouseView.currentPageDotColor = [UIColor whiteColor];
        self.carouseView.pageControlAliment = ZMICarouselPageContolAligmentCenter;
        self.carouseView.autoScroll = NO;
        self.carouseView.infiniteLoop = YES;
        self.carouseView.pageControlBottomOffset = -5;
        self.carouseView.showBgMask = YES;
        [self.contentView addSubview:self.carouseView];
        [self.contentView sendSubviewToBack:self.carouseView];
    }
    return _carouseView;
}

- (UIImageView *)thumbView{
    if (!_thumbView) {
        _thumbView = [UIImageView new];
        _thumbView.layer.cornerRadius = 30 * 0.5;
        _thumbView.layer.masksToBounds = YES;
        _thumbView.layer.borderColor = [ZMColor whiteColor].CGColor;
        _thumbView.layer.borderWidth = 1;
        
        [self.contentView addSubview:_thumbView];
        [_thumbView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(10);
            make.size.mas_equalTo(CGSizeMake(30, 30));
        }];
    }
    return _thumbView;
}

- (UILabel *)nickLabel{
    if (!_nickLabel) {
        _nickLabel = [UILabel new];
        _nickLabel.font = [UIFont boldSystemFontOfSize:15];
        _nickLabel.textColor = [ZMColor whiteColor];
        [self.contentView addSubview:_nickLabel];
        [_nickLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.thumbView.mas_right).with.offset(5);
            make.centerY.mas_equalTo(self.thumbView);
        }];
    }
    return _nickLabel;
}

- (UILabel *)descLabel{
    if (!_descLabel) {
        _descLabel = [UILabel new];
        _descLabel.font = [UIFont systemFontOfSize:12];
        _descLabel.textColor = [ZMColor whiteColor];
        [self.contentView addSubview:_descLabel];
        [_descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.nickLabel);
            make.right.mas_equalTo(-20);
            make.top.mas_equalTo(self.thumbView.mas_bottom).with.offset(2);
        }];
    }
    return _descLabel;
}

- (UILabel *)remLabel{
    if (!_remLabel) {
        _remLabel = [UILabel new];
        _remLabel.font = [UIFont systemFontOfSize:13];
        _remLabel.text = @"推荐写手";
        _remLabel.textColor = [ZMColor whiteColor];
        [self.contentView addSubview:_remLabel];
        [_remLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.centerY.mas_equalTo(self.thumbView);
        }];
        [self.superview layoutIfNeeded];
        [_remLabel sizeToFit];
    }
    return _remLabel;
}

- (UIImageView *)iconView{
    if (!_iconView) {
        _iconView = [UIImageView new];
        UIImage *image = [UIImage imageNamed:@"GCDiscovery_banner_star~iphone"];
        _iconView.image = image;
        [self.contentView addSubview:_iconView];
        [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.remLabel.mas_left).with.offset(-5);
            make.centerY.mas_equalTo(self.remLabel.mas_centerY).with.offset(-1);
            make.size.mas_equalTo(image.size);
        }];
    }
    return _iconView;
}

- (UIImageView *)mainView{
    if (!_mainView) {
        _mainView = [UIImageView new];
        _mainView.image = [YYImage imageNamed:@"discovery_feature_cell_mask"];
        //_mainView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
        [self.carouseView.carousel addSubview:_mainView];
        [_mainView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(0);
        }];
    }
    return _mainView;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.font = [UIFont systemFontOfSize:15];
        _nameLabel.textColor = [ZMColor whiteColor];
        _nameLabel.numberOfLines = 2;
        
        [self.mainView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mainView.mas_left).with.offset(10);
            make.right.mas_equalTo(self.mainView.mas_right).with.offset(-10);
            make.top.mas_equalTo(self.mainView.mas_top).with.offset(30);
        }];
    }
    return _nameLabel;
}

- (UILabel *)tagLabel{
    if (!_tagLabel) {
        _tagLabel = [UILabel new];
        _tagLabel.font = [UIFont systemFontOfSize:12];
        _tagLabel.textColor = [ZMColor whiteColor];
        _tagLabel.numberOfLines = 2;
        [self.mainView addSubview:_tagLabel];
        [_tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(self.mainView.mas_centerY);
        }];
    }
    return _tagLabel;
}

- (UIButton *)readButton{
    if (!_readButton) {
        _readButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _readButton.layer.cornerRadius = 3;
        _readButton.layer.borderColor = [ZMColor whiteColor].CGColor;
        _readButton.layer.borderWidth = 1;
        [_readButton setTitle:@"立即阅读" forState:UIControlStateNormal];
        [_readButton setTitleColor:[ZMColor whiteColor] forState:UIControlStateNormal];
        _readButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [self.mainView addSubview:_readButton];
        [_readButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mainView);
            make.bottom.mas_equalTo(self.mainView.mas_bottom).with.offset(-35);
            make.size.mas_equalTo(CGSizeMake(80, 30));
        }];
    }
    return _readButton;
}

- (NSMutableArray *)imagesArray{
    if (!_imagesArray) {
        _imagesArray = [NSMutableArray new];
    }
    return _imagesArray;
}
- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [ZMColor whiteColor];
    }
    return self;
}

- (void)setDataArray:(NSArray *)dataArray{
    if (!dataArray.count) return;
    _dataArray = dataArray;
    [self.imagesArray removeAllObjects];
    for (ZMDiscoverArticleModel *model in dataArray) {
        NSString *url = model.fullUrl;
        [self.imagesArray addObject:url];
    }
    [self.carouseView reloadData];
    [self.carouseView.carousel scrollToItemAtIndex:1 animated:NO];
    [self.carouseView.carousel scrollToItemAtIndex:0 animated:NO];
    
}

#pragma mark - ZMICarouselViewDataSource
- (NSArray *)numberOfItemsInZMICarouselView{
    return self.imagesArray;
}
#pragma mark - ZMICarouselViewDelegate optional
- (void)ZMICarouselView:(ZMICarouselView *)carousel didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"点击了 = %ld",index);
}
#pragma mark - 已经滚动
- (void)ZMICarouselViews:(iCarousel *)carousel didScrollToIndex:(NSInteger)index{
    
    [self.carouseView.carousel.currentItemView addSubview:self.mainView];
    [self updateConstraintsWithView];
    self.mainView.hidden = YES;
    [UIView animateWithDuration:0.5 animations:^{
        self.mainView.hidden = NO;
    }];
    
    id model = [self.dataArray safeObjectAtIndex:index];
    if ([model isKindOfClass:[ZMDiscoverArticleModel class]]) {
        [self.thumbView setImageWithURL:[NSURL URLWithString:((ZMDiscoverArticleModel *)model).author.portraitFullUrl]  placeholder:placeholderFailImage];
        self.nickLabel.text = ((ZMDiscoverArticleModel *)model).author.nickName;
        self.descLabel.text = ((ZMDiscoverArticleModel *)model).author.signature;
        self.nameLabel.text = ((ZMDiscoverArticleModel *)model).title;
        self.tagLabel.text =  ((ZMDiscoverArticleModel *)model).tag;
        self.readButton.hidden = NO;
    }
}

- (void)updateConstraintsWithView{
    [self.mainView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];
    
    [self.nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mainView.mas_left).with.offset(10);
        make.right.mas_equalTo(self.mainView.mas_right).with.offset(-10);
        make.top.mas_equalTo(self.mainView.mas_top).with.offset(30);
        make.height.mas_equalTo(50);
    }];
   
    [self.tagLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.centerY.mas_equalTo(self.mainView.mas_centerY);
        make.height.mas_equalTo(50);
    }];
    
    [self.readButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mainView);
        make.bottom.mas_equalTo(self.mainView.mas_bottom).with.offset(-35);
        make.size.mas_equalTo(CGSizeMake(80, 30));
    }];
    //这里强制重新绘制之后不知道为啥约束出现问题 未解决~
    [self.mainView.superview layoutIfNeeded];
    [self.nameLabel.superview layoutIfNeeded];
    [self.tagLabel.superview layoutIfNeeded];
    [self.readButton.superview layoutIfNeeded];
}

@end
