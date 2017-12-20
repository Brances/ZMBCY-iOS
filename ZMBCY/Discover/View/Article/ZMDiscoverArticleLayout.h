//
//  ZMDiscoverArticleLayout.h
//  ZMBCY
//
//  Created by Brance on 2017/12/7.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZMDiscoverArticleModel.h"

@interface ZMDiscoverArticleLayout : NSObject

- (instancetype)initWithStatus:(ZMDiscoverArticleModel *)article;
- (void)layout; ///< 计算布局

//数据
@property (nonatomic, strong) ZMDiscoverArticleModel    *article;

//以下是布局结果
// 顶部留白
@property (nonatomic, assign) CGFloat       marginTop; //顶部灰色留白
@property (nonatomic, assign) CGFloat       titleHeight;
@property (nonatomic, strong) YYTextLayout *titleTextLayout; //文章标题
@property (nonatomic, assign) CGFloat       visitHeight;      //浏览次数高度
@property (nonatomic, strong) YYTextLayout *visitTextLayout;//浏览次数
@property (nonatomic, assign) CGFloat       wordNumHeight;   //连载字数高度
@property (nonatomic, strong) YYTextLayout *wordNumTextLayout; //字数统计

// 文本内容
@property (nonatomic, assign) CGFloat       textHeight;       //文本高度(包括下方留白)
@property (nonatomic, strong) YYTextLayout *textLayout; //文本

//标签高度
@property (nonatomic, assign) CGFloat       tagHeight;
//个人资料高度
@property (nonatomic, assign) CGFloat       profileHeight;
// 下边留白
@property (nonatomic, assign) CGFloat       marginBottom; //下边留白
// 总高度
@property (nonatomic, assign) CGFloat       height;

@end

/**
 文本 Line 位置修改
 将每行文本的高度和位置固定下来，不受中英文/Emoji字体的 ascent/descent 影响
 */
@interface WBTextLinePositionModifier : NSObject <YYTextLinePositionModifier>

@property (nonatomic, strong) UIFont *font; // 基准字体 (例如 Heiti SC/PingFang SC)
@property (nonatomic, assign) CGFloat paddingTop; //文本顶部留白
@property (nonatomic, assign) CGFloat paddingBottom; //文本底部留白
@property (nonatomic, assign) CGFloat lineHeightMultiple; //行距倍数
- (CGFloat)heightForLineCount:(NSUInteger)lineCount;

@end




