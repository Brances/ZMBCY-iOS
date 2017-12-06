//
//  ZMDiscoverInsetLayoutHeadViewCell.m
//  ZMBCY
//
//  Created by ZOMAKE on 2017/12/6.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "ZMDiscoverInsetLayoutHeadViewCell.h"

@interface ZMDiscoverInsetLayoutHeadViewCell()

@end

@implementation ZMDiscoverInsetLayoutHeadViewCell

- (ZMDiscoverRecommendHeadView *)headView{
    if (!_headView) {
        _headView = [[ZMDiscoverRecommendHeadView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        [self.contentView addSubview:_headView];
    }
    return _headView;
}

- (instancetype) initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [ZMColor whiteColor];
    }
    return self;
}

- (void)setModel:(ZMDiscoverHeadModel *)model{
    _model = model;
    self.headView.isShow = YES;
    WEAKSELF;
//    self.headView.changeStyleBlock = ^(BOOL selected){
//        if (selected) {
//            NSLog(@"选中");
//        }else{
//             NSLog(@"未选中");
//        }
//    };
    self.headView.model = model;
}

@end
