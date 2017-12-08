//
//  ZMDiscoverArticleCell.m
//  ZMBCY
//
//  Created by ZOMAKE on 2017/12/7.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "ZMDiscoverArticleCell.h"

@implementation ZMDiscoverArticleCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [ZMColor appGraySpaceColor];
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    //容器
    _mainView = [UIView new];
    _mainView.backgroundColor = [ZMColor whiteColor];
    _mainView.width = kScreenWidth;
    _mainView.left = 0;
    _mainView.top = 0;
    [self.contentView addSubview:_mainView];
    //配图
    _thumbImage = [[UIImageView alloc] init];
    _thumbImage.left = 12;
    _thumbImage.size = CGSizeMake(90 * FIT_WIDTH, 110 * FIT_HEIGHT);
    
    [_mainView addSubview:_thumbImage];
    //标题
    _titleLabel = [YYLabel new];
    _titleLabel.numberOfLines = 2;
    _titleLabel.left = CGRectGetMaxX(_thumbImage.frame) + 10;
    _titleLabel.width = kScreenWidth - 20 - CGRectGetMaxX(_thumbImage.frame) - 10;
    _titleLabel.textVerticalAlignment = YYTextVerticalAlignmentTop;
    _titleLabel.displaysAsynchronously = YES;
    _titleLabel.ignoreCommonProperties = YES;
    _titleLabel.fadeOnAsynchronouslyDisplay = NO;
    _titleLabel.fadeOnHighlight = NO;
    [_mainView addSubview:_titleLabel];
    
    
    //更多按钮
    _moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _moreButton.size = CGSizeMake(80, 30);
    _moreButton.left = CGRectGetMaxX(_thumbImage.frame) + 10;
    _moreButton.layer.borderColor = [ZMColor appMainColor].CGColor;
    _moreButton.layer.borderWidth = 1;
    _moreButton.layer.masksToBounds = YES;
    _moreButton.layer.cornerRadius = 3;
    [_moreButton setTitle:@"阅读更多" forState:UIControlStateNormal];
    [_moreButton setTitleColor:[ZMColor appMainColor] forState:UIControlStateNormal];
    _moreButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [_mainView addSubview:_moreButton];
    
    //浏览次数
    _visitLabel = [YYLabel new];
    _visitLabel.left = CGRectGetMaxX(_thumbImage.frame) + 10;
    _visitLabel.textColor = [ZMColor appSupportColor];
    _visitLabel.font = [UIFont systemFontOfSize:12];
    [_mainView addSubview:_visitLabel];
    
    //连载字数
    _wordNumLabel = [YYLabel new];
    _wordNumLabel.textColor = [ZMColor appSupportColor];
    _wordNumLabel.font = [UIFont systemFontOfSize:12];
    [_mainView addSubview:_wordNumLabel];
    
    //正文
    _contentLabel = [YYLabel new];
    _contentLabel.numberOfLines = 0;
    _contentLabel.left = 15;
    _contentLabel.width = kScreenWidth - 30;
    _contentLabel.textVerticalAlignment = YYTextVerticalAlignmentTop;
    _contentLabel.displaysAsynchronously = YES;
    _contentLabel.ignoreCommonProperties = YES;
    _contentLabel.fadeOnAsynchronouslyDisplay = NO;
    _contentLabel.fadeOnHighlight = NO;
    
    [_mainView addSubview:_contentLabel];
    
    //标签集合
    _tagView = [[ZMDiscoverArticleTagView alloc] init];
    _tagView.size = CGSizeMake(kScreenWidth - 24, 40);
    _tagView.left = 12;
    _tagView.backgroundColor = [ZMColor whiteColor];
    [_mainView addSubview:_tagView];
    
    //用户视图
    _profileView = [[ZMDiscoverArticleProfileView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 35)];
    WEAKSELF;
    _profileView.praiseBlock = ^(BOOL selected){
        if (!weakSelf.layout.article) return ;
        if (selected) {
            weakSelf.layout.article.hasPraise = selected;
        }else{
            weakSelf.layout.article.hasPraise = !selected;
        }
    };
    //_profileView.size = CGSizeMake(kScreenWidth, 35);
    _profileView.left = 0;
    _profileView.backgroundColor = [ZMColor whiteColor];
    [_mainView addSubview:_profileView];
}



- (void)setLayout:(ZMDiscoverArticleLayout *)layout{
    _layout = layout;
    _mainView.height = layout.height;
    
    _thumbImage.top = layout.marginTop;
    
    _moreButton.top = CGRectGetMaxY(_thumbImage.frame) - _moreButton.height;
    _visitLabel.top = CGRectGetMinY(_moreButton.frame) - 10 - layout.visitHeight;
    _visitLabel.height = layout.visitHeight;
    _visitLabel.width = layout.visitTextLayout.textBoundingSize.width;
    _visitLabel.textLayout = layout.visitTextLayout;
    
    _wordNumLabel.top = CGRectGetMinY(_moreButton.frame) - 10 - layout.visitHeight;
    _wordNumLabel.left = CGRectGetMaxX(_visitLabel.frame) + 10;
    _wordNumLabel.width = layout.wordNumTextLayout.textBoundingSize.width;
    _wordNumLabel.height = layout.wordNumHeight;
    _wordNumLabel.textLayout = layout.wordNumTextLayout;
    
    [self.thumbImage setImageWithURL:[NSURL URLWithString:layout.article.fullThumb] placeholder:placeholderFailImage];
    
    _titleLabel.top = CGRectGetMinY(_thumbImage.frame);
    _titleLabel.height = layout.titleHeight;
    _titleLabel.textLayout = layout.titleTextLayout;
    
    _contentLabel.top = CGRectGetMaxY(_thumbImage.frame);
    _contentLabel.height = layout.textHeight;
    _contentLabel.textLayout = layout.textLayout;
    
    _tagView.top = CGRectGetMaxY(_thumbImage.frame) + layout.textHeight;
    [_tagView setSpecificationButton:layout.article.tags];
    
    _profileView.top = CGRectGetMaxY(_thumbImage.frame) + layout.textHeight + _tagView.height + 10;
    [_profileView.thumb setImageWithURL:[NSURL URLWithString:layout.article.author.portraitFullUrl] placeholder:placeholderAvatarImage];
    _profileView.nickLabel.text = layout.article.author.nickName;
    _profileView.praiseButton.selected = layout.article.hasPraise;
    
}

@end
