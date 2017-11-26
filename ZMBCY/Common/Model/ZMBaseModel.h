//
//  ZMBaseModel.h
//  ZMBCY
//
//  Created by Brance on 2017/11/24.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 数据类型，决定CELL的布局 */
typedef NS_ENUM(NSInteger,otypeData){
    otypeDataNormal = 0, //(post)
    otypeDataGoods,
};

@interface ZMBaseModel : NSObject

- (NSString *)dispose:(id)data;
- (NSArray *)arrDispose:(id)data;
- (NSDictionary *)dicDispose:(id)data;

@end
