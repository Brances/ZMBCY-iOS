//
//  ZMProfileViewCell.m
//  ZMBCY
//
//  Created by ZOMAKE on 2018/1/8.
//  Copyright © 2018年 Brance. All rights reserved.
//

#import "ZMProfileViewCell.h"

@implementation ZMProfileViewCell

- (UIView *)mainView{
    if (!_mainView) {
        self.mainView = [[UIView alloc] init];
        self.mainView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.mainView];
        [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.top.mas_equalTo(0);
        }];
    }
    return _mainView;
}

- (UIImageView *)arrowImageView{
    if (!_arrowImageView) {
        _arrowImageView = [UIImageView new];
        UIImage *image = [UIImage imageNamed:@"postDetail_arrow~iphone"];
        _arrowImageView.image = image;
        [self.mainView addSubview:_arrowImageView];
        [_arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(image.size);
            make.right.mas_equalTo(-20);
            make.centerY.mas_equalTo(self.mainView);
        }];
    }
    return _arrowImageView;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.textColor = [ZMColor blackColor];
        _nameLabel.font = [UIFont systemFontOfSize:15];
        [self.mainView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(KMarginLeft);
            make.centerY.mas_equalTo(self.mainView);
        }];
    }
    return _nameLabel;
}

- (UILabel *)rightTextLabel{
    if (!_rightTextLabel) {
        _rightTextLabel = [UILabel new];
        _rightTextLabel.font = [UIFont systemFontOfSize:15];
        _rightTextLabel.textAlignment = NSTextAlignmentRight;
        _rightTextLabel.textColor = [ZMColor appSupportColor];
        [self.mainView addSubview:_rightTextLabel];
        [_rightTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.nameLabel.mas_right).with.offset(20);
            make.right.mas_equalTo(self.arrowImageView.mas_left).with.offset(-10);
            make.centerY.mas_equalTo(self.mainView);
        }];
    }
    return _rightTextLabel;
}

- (UIImageView *)bottomLine{
    if (!_bottomLine) {
        _bottomLine = [UIImageView new];
        _bottomLine.image = [YYImage imageWithColor:[ZMColor appBottomLineColor]];
        [self.mainView addSubview:_bottomLine];
        [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.mas_equalTo(0);
            make.height.mas_equalTo(0.5);
            make.left.mas_equalTo(0);
        }];
    }
    return _bottomLine;
}

- (UIImageView *)topLine{
    if (!_topLine) {
        _topLine = [UIImageView new];
        _topLine.image = [YYImage imageWithColor:[ZMColor appBottomLineColor]];
        [self.mainView addSubview:_topLine];
        [_topLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(0);
            make.height.mas_equalTo(0.5);
        }];
    }
    return _topLine;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}

- (void)setShowBottomLine:(BOOL)showBottomLine{
    self.bottomLine.hidden = !showBottomLine;
}

- (void)setShowTopLine:(BOOL)showTopLine{
    self.topLine.hidden = !showTopLine;
}


@end
