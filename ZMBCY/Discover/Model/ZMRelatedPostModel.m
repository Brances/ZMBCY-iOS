//
//  ZMRelatedPostModel.m
//  ZMBCY
//
//  Created by Brance on 2017/12/26.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "ZMRelatedPostModel.h"
#import "ZMPictureMetadata.h"

@implementation ZMRelatedPostModel

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    //帖子封面图
    ZMPictureMetadata *picture = [ZMPictureMetadata modelWithJSON:dic];
    picture.imageId = [self dispose:dic[@"imgId"]];
    picture.fullUrl = [NSString stringWithFormat:@"%@%@?imageView&axis=5_0&enlarge=1&quality=75&thumbnail=304y405&type=webp",HttpImageURLPre,picture.imageId];
    picture.realWidth = 304 * 0.5;
    picture.realHeight = 405 * 0.5;
    self.cover = picture;
    
    return YES;
}

@end
