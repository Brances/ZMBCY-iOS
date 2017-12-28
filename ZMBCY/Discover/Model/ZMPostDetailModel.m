//
//  ZMPostDetailModel.m
//  ZMBCY
//
//  Created by Brance on 2017/12/26.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "ZMPostDetailModel.h"
#import "ZMTimeZone.h"
#import "ZMDiscoverArticleLayout.h"

@implementation ZMPostDetailModel

+ (NSDictionary *)modelCustomPropertyMapper{
    return @{
             @"pid":@"id"
             };
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"downloadImgInfos" :  [ZMPictureMetadata class],
             @"tags":               [ZMTagModel class],
             @"relatedPosts":       [ZMRelatedPostModel class]
             };
}

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    NSString *suffix = [self dispose:dic[@"authorAvatar"]];
    self.avatarFullUrl = [NSString stringWithFormat:@"%@%@%@webp",HttpImageURLPre,suffix,HttpImageURLSuffixScanle(@"80", @"80")];
    
    //返回时间日期格式
    if ([self dispose:dic[@"createTime"]]) {
        self.createTimeString = [ZMTimeZone getCurrentTimeString:[self dispose:dic[@"createTime"]]];
    }
    //标题高度，如果有的话
    self.richTextHeight = 0;
    if ([self dispose:dic[@"richText"]].length) {
        [self layoutRichText:[self dispose:dic[@"richText"]]];
    }
    //计算图片总高度，如果有的话
    self.imagesHeight = 0;
    if (self.downloadImgInfos.count) {
        for (ZMPictureMetadata *model in self.downloadImgInfos) {
            //提前算出cell需要的高度，5是图片之间上下间距
            self.imagesHeight += model.height * kScreenWidth / model.width ;
        }
        self.imagesHeight +=  (self.downloadImgInfos.count - 1) * 5;
    }
    
    return YES;
}

#pragma mark - 计算标题高度
- (void)layoutRichText:(NSString *)text{
    if (!text.length) return;
    NSMutableAttributedString *wordText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",text]];
    wordText.alignment = NSTextAlignmentLeft;
    wordText.color = [ZMColor blackColor];
    wordText.font = [UIFont systemFontOfSize:15];
    wordText.lineBreakMode = NSLineBreakByCharWrapping;
    wordText.lineSpacing = 8;
    YYTextContainer *container = [YYTextContainer containerWithSize:CGSizeMake(kScreenWidth - 20, 9999)];
    _richTextLayout = [YYTextLayout layoutWithContainer:container text:wordText];
    WBTextLinePositionModifier *modifier = [WBTextLinePositionModifier new];
    modifier.font = [UIFont systemFontOfSize:15];
    modifier.paddingTop = 15;
    modifier.paddingBottom = 15;
    //这里计算某些文字会出问题，暂时没找到原因，改用下面的代码
    //_richTextHeight = [modifier heightForLineCount:_richTextLayout.rowCount];
    _richTextHeight = _richTextLayout.textBoundingSize.height + modifier.paddingTop + modifier.paddingBottom;
    
    NSLog(@"高度 = %.2f",_richTextHeight);
}


@end
