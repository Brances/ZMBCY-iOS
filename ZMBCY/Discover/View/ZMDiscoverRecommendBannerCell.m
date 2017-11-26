//
//  ZMDiscoverRecommendBannerCell.m
//  ZMBCY
//
//  Created by Brance on 2017/11/26.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "ZMDiscoverRecommendBannerCell.h"

@implementation ZMDiscoverRecommendBannerCell

- (UIImageView *)banner{
    if (!_banner) {
        _banner = [UIImageView new];
        [self.contentView addSubview:_banner];
        [_banner mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(0);
        }];
    }
    return _banner;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}

- (void)setupUI:(NSString *)url{
    [self.banner setImageWithURL:[NSURL URLWithString:url] placeholder:[YYImage imageWithColor:[ZMColor appSubColor]]];
}

@end
