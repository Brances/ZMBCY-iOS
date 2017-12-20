//
//  ZMTopicDetailOperationCell.m
//  ZMBCY
//
//  Created by ZOMAKE on 2017/12/20.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "ZMTopicDetailOperationView.h"

@implementation ZMTopicDetailOperationView

- (UIView *)mainView{
    if (!_mainView) {
        _mainView = [UIView new];
        _mainView.backgroundColor = [ZMColor whiteColor];
        [self addSubview:_mainView];
        [_mainView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(0);
        }];
    }
    return _mainView;
}

- (UIImageView *)subjectIcon{
    if (!_subjectIcon) {
        _subjectIcon = [UIImageView new];
        UIImage *image = [UIImage imageNamed:@"GCGList_postNumIcon~iphone"];
        _subjectIcon.image = image;
        [self.mainView addSubview:_subjectIcon];
        [_subjectIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(12);
            make.size.mas_equalTo(image.size);
            make.centerY.mas_equalTo(self.mainView);
        }];
    }
    return _subjectIcon;
}

- (UILabel *)subjectTotalLabel{
    if (!_subjectTotalLabel) {
        _subjectTotalLabel = [UILabel new];
        _subjectTotalLabel.font = [UIFont systemFontOfSize:11];
        _subjectTotalLabel.textColor = [ZMColor appSupportColor];
        [self.mainView addSubview:_subjectTotalLabel];
        [_subjectTotalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.subjectIcon.mas_right).with.offset(5);
            make.centerY.mas_equalTo(self.mainView);
        }];
    }
    return _subjectTotalLabel;
}

- (UIImageView *)lineImageView{
    if (!_lineImageView) {
        _lineImageView = [UIImageView new];
        _lineImageView.image = [YYImage imageWithColor:[ZMColor appSupportColor]];
        [self.mainView addSubview:_lineImageView];
        [_lineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.subjectTotalLabel.mas_right).with.offset(10);
            make.width.mas_equalTo(1);
            make.height.mas_equalTo(10);
            make.centerY.mas_equalTo(self.mainView);
        }];
    }
    return _lineImageView;
}

- (UIImageView *)visitIcon{
    if (!_visitIcon) {
        _visitIcon = [UIImageView new];
        UIImage *image = [UIImage imageNamed:@"GCGList_visitIcon~iphone"];
        _visitIcon.image = image;
        [self.mainView addSubview:_visitIcon];
        [_visitIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.lineImageView.mas_right).with.offset(10);
            make.centerY.mas_equalTo(self.mainView);
        }];
    }
    return _visitIcon;
}

- (UILabel *)visitTotalLabel{
    if (!_visitTotalLabel) {
        _visitTotalLabel = [UILabel new];
        _visitTotalLabel.font = [UIFont systemFontOfSize:11];
        _visitTotalLabel.textColor = [ZMColor appSupportColor];
        [self.mainView addSubview:_visitTotalLabel];
        [_visitTotalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.visitIcon.mas_right).with.offset(5);
            make.centerY.mas_equalTo(self.mainView);
        }];
    }
    return _visitTotalLabel;
}

- (UIButton *)styleButton{
    if (!_styleButton) {
        _styleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _styleButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_styleButton setTitleColor:[ZMColor blackColor] forState:UIControlStateNormal];
        [_styleButton setTitleColor:[ZMColor blackColor] forState:UIControlStateSelected];
        [_styleButton setImage:[UIImage imageNamed:@"GCGList_waterFall~iphone"] forState:UIControlStateNormal];
        [_styleButton setImage:[UIImage imageNamed:@"GCGList_listFall~iphone"] forState:UIControlStateSelected];
        
        [_styleButton addTarget:self action:@selector(clickChange:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.mainView addSubview:_styleButton];
        [_styleButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-0);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(30);
            make.centerY.mas_equalTo(self.mainView);
        }];
    }
    return _styleButton;
}

- (void)setModel:(ZMTopicDetailModel *)model{
    if ([model isKindOfClass:[ZMTopicDetailModel class]]) {
        _model = model;
        self.subjectTotalLabel.text = [NSString stringWithFormat:@"%ld",model.post_count];
        self.visitTotalLabel.text =   [NSString stringWithFormat:@"%ld",model.visitCount];
        self.styleButton.hidden = NO;
    }
    
}

#pragma mark - 切换布局
- (void)clickChange:(UIButton *)btn{
    btn.selected = !btn.selected;
    if (self.changeStyleBlock) {
        self.changeStyleBlock(btn.selected);
    }
}

@end
