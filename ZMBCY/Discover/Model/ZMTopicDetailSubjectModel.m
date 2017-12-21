//
//  ZMTopicDetailSubjectModel.m
//  ZMBCY
//
//  Created by ZOMAKE on 2017/12/20.
//  Copyright © 2017年 Brance. All rights reserved.
//  

#import "ZMTopicDetailSubjectModel.h"
#import "ZMDiscoverArticleLayout.h"


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
    //帖子类型，暂时只有图片和文章
    NSString *type = [self dispose:dic[@"type"]];
    if ([type isEqualToString:@"1"]) {
        self.subjectType = subjectTypeArticle;
        [self layoutReason:self.reason];
    }else{
        self.subjectType = subjectTypeNormal;
        [self layoutReason:self.reason];
        //self.reasonHeight = 40.f;
    }
    
    return YES;
}

#pragma mark - 计算标题高度
- (void)layoutReason:(NSString *)text{
    if (!text.length) return;
    NSMutableAttributedString *wordText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",text]];
    wordText.alignment = NSTextAlignmentLeft;
    wordText.color = [ZMColor appSupportColor];
    wordText.font = [UIFont systemFontOfSize:12];
    wordText.lineBreakMode = NSLineBreakByCharWrapping;
    YYTextContainer *container = [YYTextContainer containerWithSize:CGSizeMake((kScreenWidth - 3 * 5)/2 - 20, 9999)];
    container.maximumNumberOfRows = 5;
    _reasonLayout = [YYTextLayout layoutWithContainer:container text:wordText];
    WBTextLinePositionModifier *modifier = [WBTextLinePositionModifier new];
    modifier.font = [UIFont systemFontOfSize:12];
    modifier.lineHeightMultiple = 1.5;
    modifier.paddingTop = 2;
    modifier.paddingBottom = 2;
    _reasonHeight = [modifier heightForLineCount:_reasonLayout.rowCount] < 40 ? 40 : [modifier heightForLineCount:_reasonLayout.rowCount];
    //此处文字高度可以高度自定义，可以根据行数量去约束
    NSLog(@"高度 = %.2f",_reasonHeight);
}

@end
