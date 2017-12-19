//
//  ZMDiscoverRecommendHeadView.h
//  ZMBCY
//
//  Created by Brance on 2017/11/26.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZMDiscoverHeadModel.h"

@interface ZMDiscoverRecommendHeadView : UIView

/** 是否显示布局按钮 */
@property (nonatomic, assign) BOOL      isShow;
/** 切换布局block yes为单列 */
@property (nonatomic, copy) void(^changeStyleBlock)(BOOL);
/** 头部model */
@property (nonatomic, strong) ZMDiscoverHeadModel *model;

- (void) setupUI:(NSString *)text;

@end
