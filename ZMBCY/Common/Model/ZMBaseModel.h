//
//  ZMBaseModel.h
//  ZMBCY
//
//  Created by Brance on 2017/11/24.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,itemStyle){
    itemStyleDouble = 0,    //两列
    itemStyleSingle         //单列
};

typedef NS_ENUM(NSInteger,pageViewType){
    pageViewTypeInset = 0,  //插画
    pageViewTypeCos         //COS
};

typedef NS_ENUM(NSInteger,trendType){
    trendTypeDay = 0,       //日榜
    trendTypeWeek,          //周榜
    trendTypeMonth          //月榜
};

@interface ZMBaseModel : NSObject

- (NSString *)dispose:(id)data;
- (NSArray *)arrDispose:(id)data;
- (NSDictionary *)dicDispose:(id)data;

@end

