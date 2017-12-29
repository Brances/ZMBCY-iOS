//
//  ZMCommentModel.m
//  ZMBCY
//
//  Created by Brance on 2017/12/28.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "ZMCommentModel.h"
#import "ZMTimeZone.h"
#import "ZMDiscoverArticleLayout.h"

@implementation ZMCommentModel

+ (NSDictionary *)modelCustomPropertyMapper{
    return @{
             @"cid":@"id"
             };
}

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    NSString *suffix = [self dispose:dic[@"avatarID"]];
    self.avatarFullUrl = [NSString stringWithFormat:@"%@%@%@webp",HttpImageURLPre,suffix,HttpImageURLSuffixScanle(@"80", @"80")];
    //返回时间日期格式
    if ([self dispose:dic[@"createTime"]]) {
        self.createTimeString = [ZMTimeZone getCurrentTimeString:[self dispose:dic[@"createTime"]]];
    }
    
    //计算高度
    self.userOperationHeight = 50;
    self.contentHeight = 0;
    self.height = 0;
    
    if ([self dispose:dic[@"content"]]) {
        [self layoutContentText:[self dispose:dic[@"content"]]];
        self.height = self.userOperationHeight + self.contentHeight;
    }
    
    return YES;
}

#pragma mark - 计算标题高度
- (void)layoutContentText:(NSString *)text{
    if (!text.length) return;
    NSMutableAttributedString *wordText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",text]];
    wordText.alignment = NSTextAlignmentLeft;
    wordText.color = [ZMColor blackColor];
    wordText.font = [UIFont systemFontOfSize:15];
    wordText.lineBreakMode = NSLineBreakByCharWrapping;
    wordText.lineSpacing = 8;
    YYTextContainer *container = [YYTextContainer containerWithSize:CGSizeMake(kScreenWidth - 52 - 20, 9999)];
    _contentLayout = [YYTextLayout layoutWithContainer:container text:wordText];
    WBTextLinePositionModifier *modifier = [WBTextLinePositionModifier new];
    modifier.font = [UIFont systemFontOfSize:15];
    modifier.paddingTop = 15;
    modifier.paddingBottom = 15;
    //这里计算某些文字会出问题，暂时没找到原因，改用下面的代码
    //_richTextHeight = [modifier heightForLineCount:_richTextLayout.rowCount];
    _contentHeight = _contentLayout.textBoundingSize.height + modifier.paddingTop + modifier.paddingBottom;
    
    NSLog(@"高度 = %.2f",_contentHeight);
}

@end
