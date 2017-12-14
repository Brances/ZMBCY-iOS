//
//  ZMAuthorModel.m
//  ZMBCY
//
//  Created by Brance on 2017/11/28.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "ZMAuthorModel.h"

@implementation ZMAuthorModel

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    NSString *suffix = [self dispose:dic[@"portrait"]];
    self.portraitFullUrl = [NSString stringWithFormat:@"%@%@%@webp",HttpImageURLPre,suffix,HttpImageURLSuffixScanle(@"80", @"80")];
    
    //排行榜昵称，网易的api命名也不规范 🤷‍♀️
    if (dic[@"nickname"]) {
        self.nickName = [self dispose:dic[@"nickname"]];
    }
    //排行榜头像
    if (dic[@"avatarID"]) {
        self.portrait = [self dispose:dic[@"avatarID"]];
        self.portraitFullUrl = [NSString stringWithFormat:@"%@%@?imageView&quality=75&thumbnail=80x80&type=webp",HttpImageURLPre,self.portrait];
    }
    
    
    return YES;
}

@end
