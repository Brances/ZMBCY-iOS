//
//  ZMTopicDetailSubjectModel.m
//  ZMBCY
//
//  Created by ZOMAKE on 2017/12/20.
//  Copyright © 2017年 Brance. All rights reserved.
//  

#import "ZMTopicDetailSubjectModel.h"

@implementation ZMTopicDetailSubjectModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"downloadImgInfos" : [ZMPictureMetadata class]
            };
}

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    NSString *state = [self dispose:dic[@"state"]];
    if ([state isEqualToString:@"0"]) {
        self.subjectState = subjectSateNormal;
    }else{
        self.subjectState = subjectSateDelete;
    }
    return YES;
}

@end
