//
//  ZMPopBaseView.h
//  Inklego
//
//  Created by ZOMAKE on 2017/11/21.
//  Copyright © 2017年 ZOMAKE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMPopBaseView : UIView
{
    CGFloat kPickerHeight,kTopViewHeight;
}
// 背景视图
@property (nonatomic, strong) UIView    *backgroundView;
// 顶部视图
@property (nonatomic, strong) UIView    *topView;
// 左边取消按钮
@property (nonatomic, strong) UIButton  *leftBtn;
// 右边确定按钮
@property (nonatomic, strong) UIButton  *rightBtn;
// 中间标题
@property (nonatomic, strong) UILabel   *titleLabel;
// 分割线视图
@property (nonatomic, strong) UIView    *lineView;
// 弹出视图
@property (nonatomic, strong) UIView    *alertView;

/** 初始化子视图 */
- (void)initUI;

/** 点击背景遮罩图层事件 */
- (void)didTapBackgroundView:(UITapGestureRecognizer *)sender;

/** 取消按钮的点击事件 */
- (void)clickLeftBtn;

/** 确定按钮的点击事件 */
- (void)clickRightBtn;

@end
