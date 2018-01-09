//
//  ZMHelpUtil.h
//  ZMBCY
//
//  Created by ZOMAKE on 2018/1/9.
//  Copyright © 2018年 Brance. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZMHelpUtil : NSObject

#pragma 正则匹配邮箱号
+ (BOOL)checkMailInput:(NSString *)mail;
#pragma 正则匹配手机号
+ (BOOL)checkTelNumber:(NSString *)telNumber;

@end
