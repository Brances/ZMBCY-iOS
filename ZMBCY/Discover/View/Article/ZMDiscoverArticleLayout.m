//
//  ZMDiscoverArticleLayout.m
//  ZMBCY
//
//  Created by Brance on 2017/12/7.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "ZMDiscoverArticleLayout.h"

@implementation WBTextLinePositionModifier

- (instancetype)init {
    self = [super init];
    
    if (kiOS9Later) {
        _lineHeightMultiple = 1.34;   // for PingFang SC
    } else {
        _lineHeightMultiple = 1.3125; // for Heiti SC
    }
    
    return self;
}

- (void)modifyLines:(NSArray *)lines fromText:(NSAttributedString *)text inContainer:(YYTextContainer *)container {
    CGFloat ascent = _font.pointSize * 0.86;
    CGFloat lineHeight = _font.pointSize * _lineHeightMultiple;
    for (YYTextLine *line in lines) {
        CGPoint position = line.position;
        position.y = _paddingTop + ascent + line.row  * lineHeight;
        line.position = position;
    }
}

- (id)copyWithZone:(NSZone *)zone {
    WBTextLinePositionModifier *one = [self.class new];
    one->_font = _font;
    one->_paddingTop = _paddingTop;
    one->_paddingBottom = _paddingBottom;
    one->_lineHeightMultiple = _lineHeightMultiple;
    return one;
}

- (CGFloat)heightForLineCount:(NSUInteger)lineCount {
    if (lineCount == 0) return 0;
    //    CGFloat ascent = _font.ascender;
    //    CGFloat descent = -_font.descender;
    CGFloat ascent = _font.pointSize * 0.86;
    CGFloat descent = _font.pointSize * 0.14;
    CGFloat lineHeight = _font.pointSize * _lineHeightMultiple;
    return _paddingTop + _paddingBottom + ascent + descent + (lineCount - 1) * lineHeight;
}

@end

@implementation ZMDiscoverArticleLayout

- (instancetype)initWithStatus:(ZMDiscoverArticleModel *)article{
    if (!article || !article.author) return nil;
    self = [super init];
    _article = article;
    [self layout];
    return self;
}

- (void)layout {
    [self _layout];
}

- (void)_layout {
    _marginTop = 10;
    _titleHeight = 0;
    _textHeight = 0;
    _tagHeight = 30 + 10;
    _profileHeight = 45;
    //10px边距 + 5px 灰色间距
    _marginBottom = 15;
    
    // 文本排版，计算布局
    [self layoutTitle];
    [self layoutVisit];
    [self layoutWordNumText];
    [self layoutText];
    // 计算高度
    _height = 0;
    _height += _marginTop;
    _height += 110 * FIT_HEIGHT;
    _height += _textHeight;
    _height += _tagHeight;
    _height += _profileHeight;
    _height += _marginBottom;
    
}

//计算文章标题
- (void)layoutTitle{
    NSString *titleStr = nil;
    if (_article.title.length) {
        titleStr = _article.title;
    }
    if (titleStr.length == 0) {
        _titleTextLayout = nil;
        return;
    }
    NSMutableAttributedString *titleText = [[NSMutableAttributedString alloc] initWithString:titleStr];
    titleText.color = [ZMColor blackColor];
    titleText.font = [UIFont boldSystemFontOfSize:15];
    titleText.lineBreakMode = NSLineBreakByCharWrapping;
    
    WBTextLinePositionModifier *modifier = [WBTextLinePositionModifier new];
    modifier.font = [UIFont boldSystemFontOfSize:15];
    modifier.paddingTop = 5;
    modifier.paddingBottom = 10;
    
    YYTextContainer *container = [YYTextContainer new];
    container.size = CGSizeMake(kScreenWidth - 10 - 90 * FIT_WIDTH - 10 - 10, HUGE);
    container.linePositionModifier = modifier;
    container.maximumNumberOfRows = 2;
    _titleTextLayout = [YYTextLayout layoutWithContainer:container text:titleText];
    _titleHeight = [modifier heightForLineCount:_titleTextLayout.rowCount];
}
//计算文章浏览次数
- (void)layoutVisit{
    NSString *visit = nil;
    if (_article.visit.length) {
        visit = _article.visit;
    }
    if (visit.length == 0) {
        _visitTextLayout = nil;
        return;
    }
    NSMutableAttributedString *visitText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"浏览%@次",visit]];
    visitText.color = [ZMColor appSupportColor];
    visitText.font = [UIFont boldSystemFontOfSize:12];
    visitText.lineBreakMode = NSLineBreakByCharWrapping;
    YYTextContainer *container = [YYTextContainer containerWithSize:CGSizeMake(kScreenWidth, 9999)];
    container.maximumNumberOfRows = 1;
    _visitTextLayout = [YYTextLayout layoutWithContainer:container text:visitText];
    //visitHeight
    WBTextLinePositionModifier *modifier = [WBTextLinePositionModifier new];
    modifier.font = [UIFont boldSystemFontOfSize:12];
    modifier.paddingTop = 2;
    modifier.paddingBottom = 2;
    
    _visitHeight = [modifier heightForLineCount:_visitTextLayout.rowCount];
    
}

//计算文章连载字数
- (void)layoutWordNumText{
    NSString *word = nil;
    if (_article.visit.length) {
        //word = [NSString stringWithFormat:@"%long",_article.wordNum];
        word = [[NSNumber numberWithLongLong:_article.wordNum] stringValue];
    }
    if (word.length == 0) {
        _wordNumTextLayout = nil;
        return;
    }
    NSMutableAttributedString *wordText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"浏览%@次",word]];
    wordText.color = [ZMColor appSupportColor];
    wordText.font = [UIFont boldSystemFontOfSize:12];
    wordText.lineBreakMode = NSLineBreakByCharWrapping;
    YYTextContainer *container = [YYTextContainer containerWithSize:CGSizeMake(kScreenWidth, 9999)];
    container.maximumNumberOfRows = 1;
    _wordNumTextLayout = [YYTextLayout layoutWithContainer:container text:wordText];
    WBTextLinePositionModifier *modifier = [WBTextLinePositionModifier new];
    modifier.font = [UIFont boldSystemFontOfSize:12];
    modifier.paddingTop = 2;
    modifier.paddingBottom = 2;
    //wordNumHeight
    _wordNumHeight = [modifier heightForLineCount:_wordNumTextLayout.rowCount];
}

//计算正文内容
- (void)layoutText{
    _textHeight = 0;
    _textLayout = nil;
    NSMutableAttributedString *text = [self _textWithStatus:_article fontSize:15 textColor:[ZMColor appSupportColor]];
    
    if (text.length == 0) return;
    WBTextLinePositionModifier *modifier = [WBTextLinePositionModifier new];
    modifier.font = [UIFont fontWithName:@"Heiti SC" size:15];
    modifier.paddingTop = 10;
    modifier.paddingBottom = 5;
    
    YYTextContainer *container = [YYTextContainer new];
    container.size = CGSizeMake(kScreenWidth - 30, HUGE);
    container.linePositionModifier = modifier;
    container.maximumNumberOfRows = 5;
    
    _textLayout = [YYTextLayout layoutWithContainer:container text:text];
    if (!_textLayout) return;
    
    //超过五行 截断 显示省略号
    if (_textLayout.rowCount == 5) {
        //可见字符串长度
        NSInteger visible = _textLayout.visibleRange.length;
        //总长度
        NSInteger sum = text.length;
        //若未有超出屏幕的字符则直接返回
        if (sum - 1 <= visible) {
            return;
        }
        [text replaceCharactersInRange:NSMakeRange(visible - 1, sum - visible + 1) withString:@"..."];
        _textLayout = [YYTextLayout layoutWithContainer:container text:text];
        NSLog(@"超过五行");
    }
    
    _textHeight = [modifier heightForLineCount:_textLayout.rowCount];
}

- (NSMutableAttributedString *)_textWithStatus:(ZMDiscoverArticleModel *)status
                                      fontSize:(CGFloat)fontSize
                                     textColor:(UIColor *)textColor {
    if (!status) return nil;
    
    NSMutableString *string = status.summary.mutableCopy;
    if (string.length == 0) return nil;
    // 字体
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    // 高亮状态的背景
    YYTextBorder *highlightBorder = [YYTextBorder new];
    highlightBorder.insets = UIEdgeInsetsMake(-2, 0, -2, 0);
    highlightBorder.cornerRadius = 3;
    highlightBorder.fillColor = [ZMColor colorWithHexString:@"#bfdffe"];
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:string];
    text.font = font;
    text.color = textColor;
    text.lineBreakMode = NSLineBreakByCharWrapping;
    return text;
}


- (WBTextLinePositionModifier *)_textlineModifier {
    static WBTextLinePositionModifier *mod;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mod = [WBTextLinePositionModifier new];
        mod.font = [UIFont fontWithName:@"Heiti SC" size:15];
        mod.paddingTop = 10;
        mod.paddingBottom = 10;
    });
    return mod;
}

@end
