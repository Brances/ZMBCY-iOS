//
//  ZMDiscoverRecommendMoreTitleCell.m
//  ZMBCY
//
//  Created by Brance on 2017/11/28.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "ZMDiscoverRecommendMoreTitleCell.h"

@implementation ZMDiscoverRecommendMoreTitleCell

- (UIView *)mainView{
    if (!_mainView) {
        _mainView = [UIView new];
        _mainView.backgroundColor = [ZMColor whiteColor];
        [self.contentView addSubview:_mainView];
        [_mainView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(0);
        }];
    }
    return _mainView;
}
- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.font = [UIFont systemFontOfSize:15];
        _nameLabel.textColor = [ZMColor appMainColor];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        [self.mainView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.mainView);
            make.centerX.mas_equalTo(self.mainView.mas_centerX).with.offset(-10);
        }];
        [_nameLabel.superview layoutIfNeeded];
        [_nameLabel sizeToFit];
    }
    return _nameLabel;
}

- (UIImageView *)iconView{
    if (!_iconView) {
        _iconView = [UIImageView new];
        UIImage *image = [UIImage imageNamed:@"discovery_icon_jump~iphone"];
        _iconView.image = image;
        [self.mainView addSubview:_iconView];
        [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(image.size);
            make.left.mas_equalTo(self.nameLabel.mas_right).with.offset(5);
            make.centerY.mas_equalTo(self.mainView);
        }];
    }
    return _iconView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [ZMColor whiteColor];
        self.nameLabel.hidden = NO;
        self.iconView.hidden = NO;
    }
    return self;
}

- (void)setNameText:(NSString *)text{
    CGFloat w = [NSString getTitleWidth:text withFontSize:15];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(w);
    }];
    
}

@end
