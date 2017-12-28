//
//  ZMDiscoverArticleTagView.m
//  ZMBCY
//
//  Created by Brance on 2017/12/8.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "ZMDiscoverArticleTagView.h"

@implementation ZMDiscoverArticleTagView

- (NSMutableArray *)btnArray{
    if (!_btnArray) {
        _btnArray = [NSMutableArray array];
    }
    return _btnArray;
}

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
        [self addSubview:_scrollView];
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [ZMColor whiteColor];
    }
    return self;
}

#pragma mark - 设置数据
- (void)setSpecificationButton:(NSArray *)contents{
    self.baseArray = contents;
    [self.btnArray removeAllObjects];
    WEAKSELF;
    NSInteger count = contents.count;
    [self.scrollView removeAllSubviews];
    UIButton *lastBtn;
    for (NSInteger i=0; i < count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.scrollView addSubview:btn];
        ZMTagModel *model = [contents safeObjectAtIndex:i];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(weakSelf.mas_centerY).with.offset(5);
            make.height.mas_equalTo(25);
            if (lastBtn) {
                make.left.mas_equalTo(lastBtn.mas_right).offset(20);
            }else{
                make.left.mas_equalTo(self.scrollView.mas_left).offset(0);
            }
            if (model.tagName.length == 1) {
                make.width.mas_equalTo(32);
            }else{
                if (i == 0) {
                    make.width.mas_equalTo([NSString getTitleWidth:model.tagName withFontSize:13] + 40);
                }else{
                    make.width.mas_equalTo([NSString getTitleWidth:model.tagName withFontSize:13] + 30);
                }
            }
            if (i == count-1) {
                make.right.mas_equalTo(self.scrollView.mas_right).offset(-20);
            }
        }];
        [btn.superview layoutIfNeeded];
        btn.tag = i;
        [btn addTarget:self action:@selector(specificationBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [btn setTitleColor:[ZMColor appSupportColor] forState:UIControlStateNormal];
        [btn setTitle:model.tagName forState:UIControlStateNormal];
        btn.layer.masksToBounds = YES;
        lastBtn = btn;
        
        UIImage *image = [UIImage imageNamed:@"circle_tag_n"];
        CGFloat top = 0; // 顶端盖高度
        CGFloat bottom = 0 ; // 底端盖高度
        CGFloat left = image.size.width * 0.6; // 左端盖宽度
        CGFloat right = 5; // 右端盖宽度
        UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
        image = [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
        [btn setBackgroundImage:image forState:UIControlStateNormal];
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, -5);
        if (i == 0) {
            UIImageView *imageView = [UIImageView new];
            imageView.size = CGSizeMake(btn.height - 5, btn.height - 5);
            imageView.x = 3;
            imageView.top = (btn.height - imageView.size.height) /2;
            imageView.layer.cornerRadius = imageView.size.height * 0.5;
            imageView.layer.masksToBounds = YES;
            [imageView setImageWithURL:[NSURL URLWithString:model.thumb] placeholder:placeholderAvatarImage];
            btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, -10);
            [btn addSubview:imageView];
            
        }
        btn.adjustsImageWhenHighlighted = NO;
        [self.btnArray addObject:btn];
    }
}

- (void)specificationBtn:(UIButton *)sender{
    NSInteger tag = sender.tag;
    NSLog(@"tag = %ld",tag);
    
}

#pragma mark - 设置帖子按钮数据
- (void)setPostButton:(NSArray *)contents{
    self.baseArray = contents;
    [self.btnArray removeAllObjects];
    WEAKSELF;
    NSInteger count = contents.count;
    [self.scrollView removeAllSubviews];
    UIButton *lastBtn;
    for (NSInteger i=0; i < count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.scrollView addSubview:btn];
        ZMTagModel *model = [contents safeObjectAtIndex:i];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(weakSelf.mas_centerY).with.offset(0);
            make.height.mas_equalTo(25);
            if (lastBtn) {
                make.left.mas_equalTo(lastBtn.mas_right).offset(20);
            }else{
                make.left.mas_equalTo(self.scrollView.mas_left).offset(12);
            }
            if (model.tagName.length == 1) {
                make.width.mas_equalTo(32);
            }else{
                if (i == 0) {
                    make.width.mas_equalTo([NSString getTitleWidth:model.tagName withFontSize:13] + 40);
                }else{
                    make.width.mas_equalTo([NSString getTitleWidth:model.tagName withFontSize:13] + 30);
                }
            }
            if (i == count-1) {
                make.right.mas_equalTo(self.scrollView.mas_right).offset(-20);
            }
        }];
        [btn.superview layoutIfNeeded];
        btn.tag = i;
        [btn addTarget:self action:@selector(specificationBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [btn setTitleColor:[ZMColor appSupportColor] forState:UIControlStateNormal];
        [btn setTitle:model.tagName forState:UIControlStateNormal];
        btn.layer.masksToBounds = YES;
        lastBtn = btn;
        
        UIImage *image = [UIImage imageNamed:@"circle_tag_n"];
        CGFloat top = 0; // 顶端盖高度
        CGFloat bottom = 0 ; // 底端盖高度
        CGFloat left = image.size.width * 0.6; // 左端盖宽度
        CGFloat right = 5; // 右端盖宽度
        UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
        image = [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
        [btn setBackgroundImage:image forState:UIControlStateNormal];
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, -5);
        btn.adjustsImageWhenHighlighted = NO;
        [self.btnArray addObject:btn];
    }
}

@end
