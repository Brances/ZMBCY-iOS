//
//  ZMDiscoverInsetBannerViewCellCollectionViewCell.m
//  ZMBCY
//
//  Created by Brance on 2017/12/5.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "ZMDiscoverInsetBannerViewCell.h"
#import "ZMICarouselView.h"
#import "ZMWorksModel.h"

@interface ZMDiscoverInsetBannerViewCell()<ZMICarouselViewDataSource,ZMICarouselViewDelegate>

@property (nonatomic, strong) ZMICarouselView *carouseView;

@end

@implementation ZMDiscoverInsetBannerViewCell

- (ZMICarouselView *)carouseView{
    if (!_carouseView) {
        _carouseView = [ZMICarouselView icarouselViewWithFrame:CGRectMake(0, 0, kScreenWidth, self.height)];
        self.carouseView.delegate = self;
        self.carouseView.dataSource = self;
        self.carouseView.showPageControl = YES;
        self.carouseView.pageControlStyle = ZMICarouselPageContolStyleAnimated;
        self.carouseView.currentPageDotColor = [UIColor whiteColor];
        self.carouseView.pageControlAliment = ZMICarouselPageContolAligmentCenter;
        self.carouseView.autoScroll = YES;
        self.carouseView.infiniteLoop = YES;
        self.carouseView.pageControlBottomOffset = -5;
        
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
        _remLabel.text = @"推荐画师";
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

- (NSMutableArray *)imagesArray{
    if (!_imagesArray) {
        _imagesArray = [NSMutableArray new];
    }
    return _imagesArray;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [ZMColor appLightGrayColor];
    }
    return self;
}

- (void)setDataArray:(NSMutableArray *)dataArray{
    if (!dataArray.count) return;
    _dataArray = dataArray;
    [self.imagesArray removeAllObjects];
    for (ZMWorksModel *model in dataArray) {
        NSString *url = ((ZMWorkModel *)[model.work safeObjectAtIndex:0]).fullUrl;
        [self.imagesArray addObject:url];
    }
    [self.carouseView reloadData];
    id model = [self.dataArray safeObjectAtIndex:0];
    if ([model isKindOfClass:[ZMWorksModel class]]) {
        [self.thumbView setImageWithURL:[NSURL URLWithString:((ZMWorksModel *)model).author.portraitFullUrl]  placeholder:placeholderFailImage];
        self.nickLabel.text = ((ZMWorksModel *)model).author.nickName;
        self.descLabel.text = ((ZMWorksModel *)model).author.signature;
        self.iconView.hidden = NO;
    }
}

#pragma mark - ZMICarouselViewDataSource
- (NSArray *)numberOfItemsInZMICarouselView{
    return self.imagesArray;
}
#pragma mark - ZMICarouselViewDelegate optional
- (void)ZMICarouselView:(ZMICarouselView *)carousel didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"点击了 = %ld",index);
    [self.viewController.navigationController pushViewController:[NSClassFromString(@"ViewController") new] animated:YES];
}
- (void)ZMICarouselViews:(iCarousel *)carousel didScrollToIndex:(NSInteger)index{
    id model = [self.dataArray safeObjectAtIndex:index];
    if ([model isKindOfClass:[ZMWorksModel class]]) {
        [self.thumbView setImageWithURL:[NSURL URLWithString:((ZMWorksModel *)model).author.portraitFullUrl]  placeholder:placeholderFailImage];
        self.nickLabel.text = ((ZMWorksModel *)model).author.nickName;
        self.descLabel.text = ((ZMWorksModel *)model).author.signature;
    }
}

@end
