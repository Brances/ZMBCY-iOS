//
//  ZMDiscoverArticleHeadViewCell.h
//  ZMBCY
//
//  Created by Brance on 2017/12/7.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "YYTableViewCell.h"
#import "SPPageMenu.h"

@interface ZMDiscoverArticleHeadViewCell : YYTableViewCell

@property (nonatomic, weak) SPPageMenu         *pageMenu;
@property (nonatomic, strong) NSArray          *dataArray;

@end
