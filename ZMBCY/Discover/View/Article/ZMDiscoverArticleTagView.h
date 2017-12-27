//
//  ZMDiscoverArticleTagView.h
//  ZMBCY
//
//  Created by Brance on 2017/12/8.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZMTagModel.h"

@interface ZMDiscoverArticleTagView : UIView

@property (nonatomic,strong) NSMutableArray         *btnArray;
@property (nonatomic,strong) UIScrollView           *scrollView;
@property (nonatomic,strong) NSArray<ZMTagModel *>  *baseArray;
@property (nonatomic,strong) UIButton               *lastBTN;

#pragma mark - 设置文章数据
- (void)setSpecificationButton:(NSArray *)contents;

- (void)setPostButton:(NSArray *)contents;

@end
