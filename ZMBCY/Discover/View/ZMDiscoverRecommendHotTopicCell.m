//
//  ZMDiscoverRecommendHotTopicCell.m
//  ZMBCY
//
//  Created by Brance on 2017/11/26.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "ZMDiscoverRecommendHotTopicCell.h"
#import "ZMDiscoverArticleLayout.h"

@implementation ZMDiscoverRecommendHotTopicCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [ZMColor whiteColor];
        [self setupUI];
    }
    return self;
}

- (void)setupUI{

    _mainView = [UIView new];
    _mainView.backgroundColor = [ZMColor whiteColor];
    [self.contentView addSubview:_mainView];
    [_mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];
    
    _bigImageView = [[ZMDiscoverRecommendHotTopicCellView alloc] init];
    [_mainView addSubview:_bigImageView];
    [_bigImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(190 * FIT_WIDTH);
    }];
    
    _leftImageView = [[ZMDiscoverRecommendHotTopicCellView alloc] init];
    [_mainView addSubview:_leftImageView];
    [_leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(_bigImageView.mas_bottom).with.offset(2);
        make.width.height.mas_equalTo((kScreenWidth-2)/2);
    }];
    
    _rightImageView = [[ZMDiscoverRecommendHotTopicCellView alloc] init];
    [_mainView addSubview:_rightImageView];
    [_rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(_bigImageView.mas_bottom).with.offset(2);
        make.width.height.mas_equalTo((kScreenWidth-2)/2);
    }];
    
}

- (void)setupUI:(NSArray *)hotTopicArray{
    if (!hotTopicArray.count) return;
    NSString *bigCover = [NSString stringWithFormat:@"%@%@%@%@",HttpImageURLPre,((ZMTopicModel *)[hotTopicArray safeObjectAtIndex:0]).cover,HttpImageURLSuffixScanle(@"750", @"380"),((ZMTopicModel *)[hotTopicArray safeObjectAtIndex:0]).imageSuffix];
    NSString *leftCover = [NSString stringWithFormat:@"%@%@%@%@",HttpImageURLPre,((ZMTopicModel *)[hotTopicArray safeObjectAtIndex:1]).cover,HttpImageURLSuffixSquare,((ZMTopicModel *)[hotTopicArray safeObjectAtIndex:1]).imageSuffix];
    NSString *rightCover = [NSString stringWithFormat:@"%@%@%@%@",HttpImageURLPre,((ZMTopicModel *)[hotTopicArray safeObjectAtIndex:2]).cover,HttpImageURLSuffixSquare,((ZMTopicModel *)[hotTopicArray safeObjectAtIndex:2]).imageSuffix];
    
    [self.bigImageView.bigImageView setAnimationLoadingImage:[NSURL URLWithString:bigCover] placeholder:placeholderFailImage];
    [self.leftImageView.bigImageView setAnimationLoadingImage:[NSURL URLWithString:leftCover] placeholder:placeholderFailImage];
    [self.rightImageView.bigImageView setAnimationLoadingImage:[NSURL URLWithString:rightCover] placeholder:placeholderFailImage];
    
    self.bigImageView.numLabel.text = [NSString stringWithFormat:@"%llu",((ZMTopicModel *)[hotTopicArray safeObjectAtIndex:0]).num];
    self.leftImageView.numLabel.text = [NSString stringWithFormat:@"%llu",((ZMTopicModel *)[hotTopicArray safeObjectAtIndex:1]).num];
    self.rightImageView.numLabel.text = [NSString stringWithFormat:@"%llu",((ZMTopicModel *)[hotTopicArray safeObjectAtIndex:2]).num];
    
    self.bigImageView.nameLabel.text = ((ZMTopicModel *)[hotTopicArray safeObjectAtIndex:0]).name;
    self.bigImageView.descLabel.text =  ((ZMTopicModel *)[hotTopicArray safeObjectAtIndex:0]).desc;
    self.bigImageView.descLabel.numberOfLines = 1;
    self.bigImageView.descLabel.textAlignment = NSTextAlignmentLeft;
    self.bigImageView.descLabel.font = [UIFont systemFontOfSize:13];
    [self.bigImageView.descLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bigImageView.dayLabel.mas_right).with.offset(5);
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(self.bigImageView.nameLabel.mas_bottom).with.offset(5);
    }];
    
    
    self.leftImageView.descLabel.text =  ((ZMTopicModel *)[hotTopicArray safeObjectAtIndex:1]).name;
    self.rightImageView.descLabel.text =  ((ZMTopicModel *)[hotTopicArray safeObjectAtIndex:2]).name;
    
    NSArray *arr = [NSString getNowMonthAndDay];
    
    self.bigImageView.monthLabel.text = [arr safeObjectAtIndex:0];
    self.bigImageView.dayLabel.text = [arr safeObjectAtIndex:1];
    
    [self.bigImageView setupCornerRadiusWithDay];

}

@end


@implementation ZMDiscoverRecommendHotTopicCellView

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

- (UIView *)maskView{
    if (!_maskView) {
        _maskView = [UIView new];
        _maskView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
        [self.bigImageView addSubview:_maskView];
        ;
        [_maskView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(0);
        }];
    }
    return _maskView;
}

- (ZMImageView *)bigImageView{
    if (!_bigImageView) {
        _bigImageView = [[ZMImageView alloc] init];
        [self.mainView addSubview:_bigImageView];
        [self.mainView sendSubviewToBack:_bigImageView];
        [_bigImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(0);
        }];
    }
    return _bigImageView;
}

- (UILabel *)monthLabel{
    if (!_monthLabel) {
        _monthLabel = [UILabel new];
        _monthLabel.textAlignment = NSTextAlignmentCenter;
        _monthLabel.backgroundColor = [ZMColor blackColor];
        _monthLabel.textColor = [ZMColor whiteColor];
        _monthLabel.font = [UIFont systemFontOfSize:10];
        [self.maskView addSubview:_monthLabel];
        [_monthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(12);
            make.bottom.mas_equalTo(self.dayLabel.mas_top).with.offset(0);
            make.height.mas_equalTo(14);
            make.width.mas_equalTo(35);
        }];
        [_monthLabel.superview layoutIfNeeded];
    }
    return _monthLabel;
}

- (UILabel *)dayLabel{
    if (!_dayLabel) {
        _dayLabel = [UILabel new];
        _dayLabel.textAlignment = NSTextAlignmentCenter;
        _dayLabel.backgroundColor = [ZMColor whiteColor];
        _dayLabel.textColor = [ZMColor blackColor];
        _dayLabel.font = [UIFont systemFontOfSize:10];
        [self.maskView addSubview:_dayLabel];
        [_dayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(12);
            make.bottom.mas_equalTo(-35);
            make.height.mas_equalTo(14);
            make.width.mas_equalTo(35);
        }];
        [_dayLabel.superview layoutIfNeeded];
    }
    return _dayLabel;
}

- (UIImageView *)numImageView{
    if (!_numImageView) {
        _numImageView = [UIImageView new];
        UIImage *image = [UIImage imageNamed:@"pic_number_tag"];
        _numImageView.image = image;
        [self.maskView addSubview:_numImageView];
        [_numImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(image.size);
            make.top.mas_equalTo(2);
            make.right.mas_equalTo(-2);
        }];
    }
    return _numImageView;
}

- (UILabel *)numLabel{
    if (!_numLabel) {
        _numLabel = [UILabel new];
        _numLabel.font = [UIFont systemFontOfSize:10];
        _numLabel.textColor = [ZMColor whiteColor];
        [self.numImageView addSubview:_numLabel];
        [_numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.numImageView).with.offset(-2);
            make.centerY.mas_equalTo(self.numImageView).with.offset(2);
        }];
    }
    return _numLabel;
}

- (UILabel *)descLabel{
    if (!_descLabel) {
        _descLabel = [UILabel new];
        _descLabel.numberOfLines = 2;
        _descLabel.textColor = [ZMColor whiteColor];
        _descLabel.font = [UIFont systemFontOfSize:15];
        _descLabel.textAlignment = NSTextAlignmentCenter;
        [self.maskView addSubview:_descLabel];
        [_descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-20);
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
        }];
    }
    return _descLabel;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.textColor = [ZMColor whiteColor];
        _nameLabel.font = [UIFont boldSystemFontOfSize:18];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        [self.maskView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.dayLabel.mas_right).with.offset(5);
            make.right.mas_equalTo(-20);
            make.centerY.mas_equalTo(self.dayLabel.mas_top);
        }];
    }
    return _nameLabel;
}

- (void)setupCornerRadiusWithDay{
    UIBezierPath *monthPath = [UIBezierPath bezierPathWithRoundedRect:self.monthLabel.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(3, 3)];
    CAShapeLayer *monthLayer = [[CAShapeLayer alloc] init];
    monthLayer.frame = self.monthLabel.bounds;
    monthLayer.path = monthPath.CGPath;
    self.monthLabel.layer.mask  = monthLayer;
    
    UIBezierPath *dayPath = [UIBezierPath bezierPathWithRoundedRect:self.dayLabel.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(3, 3)];
    CAShapeLayer *dayLayer = [[CAShapeLayer alloc] init];
    dayLayer.frame = self.dayLabel.bounds;
    dayLayer.path = dayPath.CGPath;
    self.dayLabel.layer.mask  = dayLayer;
    
}

@end

