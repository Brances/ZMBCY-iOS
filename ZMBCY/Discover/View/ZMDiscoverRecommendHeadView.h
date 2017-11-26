//
//  ZMDiscoverRecommendHeadView.h
//  ZMBCY
//
//  Created by Brance on 2017/11/26.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMDiscoverRecommendHeadView : UIView

/** 容器 */
@property (nonatomic, strong)UIView       *mainView;
/** 图标 */
@property (nonatomic, strong)UIImageView  *iconImageView;
/** 文字 */
@property (nonatomic, strong)UILabel      *titleLabel;

- (void) setupUI:(NSString *)text;

@end
