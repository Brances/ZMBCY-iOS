//
//  ZMDiscoverArticleBannerModel.m
//  ZMBCY
//
//  Created by Brance on 2017/12/7.
//  Copyright © 2017年 Brance. All rights reserved.
//  

#import "ZMDiscoverArticleModel.h"

@implementation ZMDiscoverArticleModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"tags" : [ZMTagModel class]
            };
}

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    //文章配图
    NSString *article = dic[@"imgId"];
    if (article.length) {
        self.fullThumb = [NSString stringWithFormat:@"%@%@%@",HttpImageURLPre,article,@"?imageView&axis=5_0&enlarge=1&quality=75&thumbnail=180y220&type=webp"];
    }
    NSString *suffix = dic[@"circleImage"];
    if (suffix.length) {
        self.fullUrl = [NSString stringWithFormat:@"%@%@%@",HttpImageURLPre,suffix,@"?imageView&axis=5_0&enlarge=1&quality=75&thumbnail=375y500&type=webp"];
    }
    
    //标签集合值 1.circleName 2.遍历tags得到tagName，处理第一个和最后一个tag
    NSMutableString *tagMuString = [NSMutableString stringWithFormat:@"%@",self.circleName];
    id tagArray = dic[@"tags"];
    //[tagMuString appendString:self.circleName];
    
    if ([tagArray isKindOfClass:[NSArray class]]) {
        [tagArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (!([obj isKindOfClass:[NSDictionary class]] && obj[@"tagName"])) *stop = YES;
            if (idx == 0 || idx == ((NSArray *)tagArray).count - 1) {
                [tagMuString appendString:obj[@"tagName"]];
            }else{
                [tagMuString appendString:[NSString stringWithFormat:@"/%@",obj[@"tagName"]]];
            }
        }];
        self.tag = tagMuString;
    };
    //手动添加第一个标签值,把用户ID 作为tagID
    if ([dic[@"circleName"] isKindOfClass:[NSString class]] && ((NSString *)dic[@"circleName"]).length) {
        ZMTagModel *model = [[ZMTagModel alloc] init];
        model.tagName = dic[@"circleName"];
        model.tagID = self.author.uid;
        model.thumb = [NSString stringWithFormat:@"%@%@?imageView&quality=75&thumbnail=200y200&type=webp",HttpImageURLPre,dic[@"circlePic"]];
        if (self.tags.count) {
            [self.tags insertObject:model atIndex:0];
        }else{
            self.tags = [NSMutableArray new];
            [self.tags addObject:model];
        }
    }
    return YES;
}

@end
