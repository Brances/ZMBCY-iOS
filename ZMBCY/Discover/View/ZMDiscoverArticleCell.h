//
//  ZMDiscoverArticleCell.h
//  ZMBCY
//
//  Created by ZOMAKE on 2017/12/7.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "YYTableViewCell.h"
#import "ZMDiscoverArticleLayout.h"
#import "ZMDiscoverArticleTagView.h"
#import "ZMDiscoverArticleProfileView.h"

@interface ZMDiscoverArticleCell : YYTableViewCell

/** 主容器 */
@property (nonatomic, strong) UIView        *mainView;
/** 文章配图 */
@property (nonatomic, strong) UIImageView   *thumbImage;
/** 文章标题 */
@property (nonatomic, strong) YYLabel       *titleLabel;
/** 文章浏览次数 */
@property (nonatomic, strong) YYLabel       *visitLabel;
/** 文章连载字数 */
@property (nonatomic, strong) YYLabel       *wordNumLabel;
/** 文章正文 */
@property (nonatomic, strong) YYLabel       *contentLabel;
/** 阅读更多 */
@property (nonatomic, strong) UIButton      *moreButton;
/** 滚动标签 */
@property (nonatomic, strong) ZMDiscoverArticleTagView  *tagView;
/** 用户资料及点赞 */
@property (nonatomic, strong) ZMDiscoverArticleProfileView   *profileView;

@property (nonatomic, strong) ZMDiscoverArticleLayout *layout;

@end
