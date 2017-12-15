//
//  ZMCustomGifFooter.m
//  ZMBCY
//
//  Created by Brance on 2017/12/15.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "ZMCustomGifFooter.h"

@implementation ZMCustomGifFooter

#pragma mark - 重写方法
- (void)prepare{
    [super prepare];
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 1; i <= 12; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"pull_refresh_bottom_000%zd", i]];
        [idleImages addObject:image];
    }
    [self setImages:idleImages forState:MJRefreshStateIdle];
    
    // 设置正在刷新状态的动画图片
    [self setImages:idleImages forState:MJRefreshStateRefreshing];
    //此句代码无效，没有找到原因
    [self setImages:@[[UIImage imageNamed:@"bottom_nomore"]] forState:MJRefreshStateNoMoreData];
    self.stateLabel.hidden = YES;
    
}

#pragma mark - 重新设置子控件
- (void)placeSubviews{
    [super placeSubviews];
    
    self.gifView.mj_x = (self.mj_w -  self.gifView.mj_w)/2;
    self.gifView.hidden = NO;
    if (self.state == MJRefreshStateNoMoreData) {
        self.gifView.image = [UIImage imageNamed:@"bottom_nomore"];
    }
}

@end
