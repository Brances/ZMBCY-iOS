//
//  NSArray+ZMAdd.h
//  Zomake
//
//  Created by Brance on 17/11/24.
//  Copyright © 2017年 ZOMAKE. All rights reserved.
//  安全获取索引中的对象

#import <Foundation/Foundation.h>

@interface NSArray (ZMAdd)

- (id)safeObjectAtIndex:(NSUInteger)index;

@end
