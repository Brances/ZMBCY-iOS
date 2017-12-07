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
    [self.contentView addSubview:_mainView];
    [_mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.bottom.mas_equalTo(-5);
    }];
    //配图
    _thumbImage = [[UIImageView alloc] init];
    [_mainView addSubview:_thumbImage];
    [_thumbImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(10);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(110);
    }];
    [_thumbImage.superview layoutIfNeeded];
    //标题
    _titleLabel = [YYLabel new];
    _titleLabel.font  = [UIFont boldSystemFontOfSize:15];
    _titleLabel.textColor = [ZMColor blackColor];
    [_mainView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_thumbImage.mas_right).with.offset(10);
        make.top.mas_equalTo(_thumbImage.mas_top);
    }];
    //更多按钮
    _moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _moreButton.layer.borderColor = [ZMColor appMainColor].CGColor;
    _moreButton.layer.borderWidth = 1;
    _moreButton.layer.masksToBounds = YES;
    _moreButton.layer.cornerRadius = 3;
    [_moreButton setTitle:@"阅读更多" forState:UIControlStateNormal];
    [_moreButton setTitleColor:[ZMColor appMainColor] forState:UIControlStateNormal];
    _moreButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [_mainView addSubview:_moreButton];
    [_moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_thumbImage.mas_right).with.offset(10);
        make.bottom.mas_equalTo(_thumbImage.mas_bottom);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(30);
    }];
    //浏览次数
    _visitLabel = [YYLabel new];
    _visitLabel.textColor = [ZMColor appSubColor];
    _visitLabel.font = [UIFont systemFontOfSize:12];
    [_mainView addSubview:_visitLabel];
    [_visitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_thumbImage.mas_right).with.offset(10);
        make.bottom.mas_equalTo(_moreButton.mas_top).with.offset(-10);
    }];
    //连载字数
    _wordNumLabel = [YYLabel new];
    _wordNumLabel.textColor = [ZMColor appSubColor];
    _wordNumLabel.font = [UIFont systemFontOfSize:12];
    [_mainView addSubview:_wordNumLabel];
    [_wordNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_visitLabel.mas_right).with.offset(10);
        make.bottom.mas_equalTo(_moreButton.mas_top).with.offset(-10);
    }];
    //正文
    _contentLabel = [YYLabel new];
    _contentLabel.left = 10;
    _contentLabel.width = kScreenWidth - 20;
    _contentLabel.textVerticalAlignment = YYTextVerticalAlignmentTop;
    _contentLabel.displaysAsynchronously = YES;
    _contentLabel.ignoreCommonProperties = YES;
    _contentLabel.fadeOnAsynchronouslyDisplay = NO;
    _contentLabel.fadeOnHighlight = NO;
    
    [_mainView addSubview:_contentLabel];
    
}


- (void)setLayout:(ZMDiscoverArticleLayout *)layout{
    _layout = layout;
    //self.contentView.height = layout.height;
    [self.thumbImage setImageWithURL:[NSURL URLWithString:layout.article.fullThumb] placeholder:placeholderFailImage];
    
    self.titleLabel.text = layout.article.title;
    self.visitLabel.text = [NSString stringWithFormat:@"浏览%@次",layout.article.visit];
    self.wordNumLabel.text = [NSString stringWithFormat:@"连载%@字",[[NSNumber numberWithLongLong:layout.article.wordNum] stringValue]];
    _contentLabel.top = CGRectGetMaxY(_thumbImage.frame);
    _contentLabel.height = layout.textHeight;
    _contentLabel.textLayout = layout.textLayout;
    
}

@end
