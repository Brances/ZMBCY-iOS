//
//  ZMDiscoverBannerTopModel.m
//  ZMBCY
//
//  Created by ZOMAKE on 2017/12/13.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "ZMDiscoverBannerTopModel.h"

@implementation ZMDiscoverBannerTopModel

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    //文章配图
    NSString *article = dic[@"imgId"];
    if (article.length) {
        self.rightFull = [NSString stringWithFormat:@"%@%@%@",HttpImageURLPre,article,@"?imageView&enlarge=1&quality=75&thumbnail=750y490&type=webp"];
    }
    if (dic[@"headPic"]) {
        self.headFull = [NSString stringWithFormat:@"%@%@%@",HttpImageURLPre,dic[@"headPic"],@"?imageView&quality=75&thumbnail=80x80&type=webp"];
    }
    
    return YES;
    
}


@end
