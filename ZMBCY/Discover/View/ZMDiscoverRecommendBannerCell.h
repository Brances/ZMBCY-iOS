//
//  ZMDiscoverRecommendBannerCell.h
//  ZMBCY
//
//  Created by Brance on 2017/11/26.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "YYTableViewCell.h"

@interface ZMDiscoverRecommendBannerCell : YYTableViewCell

@property (nonatomic, strong) UIImageView *banner;

- (void)setupUI:(NSString *)url;

@end
