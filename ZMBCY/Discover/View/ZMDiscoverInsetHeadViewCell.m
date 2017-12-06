//
//  ZMDiscoverInsetHeadViewCell.m
//  ZMBCY
//
//  Created by ZOMAKE on 2017/12/6.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "ZMDiscoverInsetHeadViewCell.h"
#import "ZMDiscoverHeadModel.h"

@interface ZMDiscoverInsetHeadViewCell()<SPPageMenuDelegate>

@end

@implementation ZMDiscoverInsetHeadViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    if (!_pageMenu) {
        SPPageMenu *pageMenu = [SPPageMenu pageMenuWithFrame:CGRectMake(0, 0 , self.width, self.height) trackerStyle:SPPageMenuTrackerStyleLineAttachment];
         pageMenu.permutationWay = SPPageMenuPermutationWayNotScrollEqualWidths;
        pageMenu.itemPadding = 45;
        pageMenu.closeTrackerFollowingMode = YES;
        pageMenu.hideLine = YES;
        pageMenu.unSelectedItemTitleColor = [ZMColor appSupportColor];
        // 传递数组，默认选中第1个
        NSMutableArray *itemArr = [NSMutableArray new];
        for (id model in dataArray) {
            if ([model isKindOfClass:[ZMDiscoverHeadModel class]]) {
                [itemArr addObject:((ZMDiscoverHeadModel *)model).title];
            }
        }
        [pageMenu setItems:itemArr selectedItemIndex:0];
        
        for (int i = 0; i < dataArray.count; i++) {
            id model = [dataArray safeObjectAtIndex:i];
            if ([model isKindOfClass:[ZMDiscoverHeadModel class]]) {
                ZMDiscoverHeadModel *headModel = model;
                [pageMenu setTitle:headModel.title image:[UIImage imageNamed:headModel.img] imagePosition:SPItemImagePositionTop imageRatio:0.5 forItemIndex:i];
            }
        }
        pageMenu.showFuntionButton = NO;
        pageMenu.delegate = self;
        [self.contentView addSubview:pageMenu];
        _pageMenu = pageMenu;
    }
    
}

- (void)pageMenu:(SPPageMenu *)pageMenu itemSelectedAtIndex:(NSInteger)index {
    NSLog(@"%zd",index);
    //[self setupView:index];
}

@end
