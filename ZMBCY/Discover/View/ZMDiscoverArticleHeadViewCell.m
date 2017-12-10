//
//  ZMDiscoverArticleHeadViewCell.m
//  ZMBCY
//
//  Created by Brance on 2017/12/7.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "ZMDiscoverArticleHeadViewCell.h"
#import "ZMDiscoverHeadModel.h"

@interface ZMDiscoverArticleHeadViewCell()<SPPageMenuDelegate>

@end

@implementation ZMDiscoverArticleHeadViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [ZMColor whiteColor];
    }
    return self;
}
- (void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    if (!_pageMenu) {
        SPPageMenu *pageMenu = [SPPageMenu pageMenuWithFrame:CGRectMake(0, 0 , kScreenWidth, 70) trackerStyle:SPPageMenuTrackerStyleLineAttachment];
        pageMenu.permutationWay = SPPageMenuPermutationWayNotScrollEqualWidths;
        //pageMenu.itemPadding = 10;
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
}

@end
