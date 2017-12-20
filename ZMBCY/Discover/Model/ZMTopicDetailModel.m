//
//  ZMTopicDetailModel.m
//  ZMBCY
//
//  Created by ZOMAKE on 2017/12/20.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "ZMTopicDetailModel.h"
#import "ZMDiscoverArticleLayout.h"

@implementation ZMTopicDetailModel

+ (NSDictionary *)modelCustomPropertyMapper{
    return @{
             @"tid":@"id"
             };
}

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    if ([self dispose:dic[@"collect_desc"]].length) {
        [self layoutText:dic[@"collect_desc"]];
    }
    self.height = 64 + KStatusBarHeight + 5 + 20 + 10 + self.descHeight + 10 + 32 + 20 + 20 + 10;
    
    return YES;
}


//计算正文内容
- (void)layoutText:(NSString *)text{
    if (!text.length) return;
    NSMutableAttributedString *wordText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",text]];
    wordText.alignment = NSTextAlignmentCenter;
    wordText.color = [ZMColor whiteColor];
    wordText.font = [UIFont systemFontOfSize:15];
    wordText.lineBreakMode = NSLineBreakByCharWrapping;
    YYTextContainer *container = [YYTextContainer containerWithSize:CGSizeMake(kScreenWidth - 60, 9999)];
    container.maximumNumberOfRows = 6;
    _descLayout = [YYTextLayout layoutWithContainer:container text:wordText];
    WBTextLinePositionModifier *modifier = [WBTextLinePositionModifier new];
    modifier.font = [UIFont systemFontOfSize:15];
    modifier.paddingTop = 2;
    modifier.paddingBottom = 2;
    _descHeight = [modifier heightForLineCount:_descLayout.rowCount];
    
}

@end
