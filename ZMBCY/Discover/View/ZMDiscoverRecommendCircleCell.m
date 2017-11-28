//
//  ZMDiscoverRecommendCircleCell.m
//  ZMBCY
//
//  Created by ZOMAKE on 2017/11/28.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "ZMDiscoverRecommendCircleCell.h"

@interface ZMDiscoverRecommendCircleCell()

/** 记录最后一个数量 */
@property (nonatomic, assign) NSInteger lastCount;
/** 底部视图 */
@property (nonatomic, strong) UIView    *bottomV;
/** 存储数据 */
@property (nonatomic, strong) NSArray   *dataArray;
/** 最后一个按钮 */
@property (nonatomic, strong) ZMDiscoverRecommendCircleCellView *lastBTN;

@end

@implementation ZMDiscoverRecommendCircleCell
{
    CGFloat cellLineCount;
    CGFloat cellLineSpace;
    CGFloat cellWidth;
    CGFloat cellHeight;
    CGFloat leftMargin;
}
- (UIView *)bottomV{
    if (!_bottomV) {
        _bottomV = [[UIView alloc]init];
        [self.contentView addSubview:_bottomV];
        [_bottomV mas_makeConstraints:^(MASConstraintMaker *make) {
            //make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
            make.left.right.top.bottom.mas_equalTo(0);
        }];
    }
    return _bottomV;
}
- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [ZMColor whiteColor];
        cellLineCount = 3;
        cellLineSpace = 2;
        leftMargin    = 10;
        cellWidth     = (kScreenWidth - leftMargin * 2 - (cellLineCount - 1) * cellLineSpace)/3;
        cellHeight    = cellWidth + 18 + 5 + 15 + 8 + 30 + 8;
    }
    return self;
}

- (void)setupUI:(NSArray *)array{
    self.dataArray = array;
    NSInteger count = array.count;
    
    //初始化视图
    for (NSInteger i = 1; i <= count; i++) {
        ZMDiscoverRecommendCircleCellView *cell = [self viewWithTag:i*10];
        if (!cell) {
            cell = [self setupCell:[self.dataArray safeObjectAtIndex:i-1] tag:i * 10];
            [cell mas_makeConstraints:^(MASConstraintMaker *make) {
                if (!self.lastBTN) {
                    make.left.mas_equalTo(self.bottomV.mas_left).offset(leftMargin);
                    make.top.mas_equalTo(self.bottomV.mas_top).with.offset(cellLineSpace);
                }else{
                    //左边
                    if (i % 3 == 1) {
                        make.left.mas_equalTo(self.bottomV.mas_left).offset(leftMargin);
                        NSUInteger line = ceil((i)/3.f) - 1;
                        make.top.mas_equalTo(line * (cellHeight  + cellLineSpace) + cellLineSpace);
                    }else if(i % 3 == 2){
                        make.left.mas_equalTo(cellWidth  + leftMargin + cellLineSpace);
                        NSUInteger line = ceil((i)/3.f) - 1;
                        make.top.mas_equalTo(line * (cellHeight  + cellLineSpace) + cellLineSpace);
                    }else if (i % 3 == 0){
                        make.right.mas_equalTo(self.bottomV.mas_right).offset(- leftMargin);
                        NSUInteger line = ceil((i)/3.f) - 1;
                        make.top.mas_equalTo(line * (cellHeight  + cellLineSpace) +cellLineSpace);
                    }
                }
            }];
            
        }else{
            //已有button 直接设置数据
            cell.model = [self.dataArray safeObjectAtIndex:i-1];
        }
        self.lastBTN = cell;
    }
    //删除
    for (NSInteger j = count; j < _lastCount; j++) {
        UIButton *btn = [self viewWithTag:j*10];
        [btn removeFromSuperview];
        btn = nil;
    }
    _lastCount = count;
}

- (ZMDiscoverRecommendCircleCellView *) setupCell:(ZMCircleModel *)model tag:(NSInteger)tag{
    ZMDiscoverRecommendCircleCellView *cell = [[ZMDiscoverRecommendCircleCellView alloc] initWithFrame:CGRectMake(0, 0, cellWidth, cellHeight)];
    cell.tag = tag;
    [self.bottomV addSubview:cell];
    [cell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(cellWidth);
        make.height.mas_equalTo(cellHeight);
    }];
    //设置数据
    cell.model = model;
    return cell;
}

@end

@implementation ZMDiscoverRecommendCircleCellView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [ZMColor whiteColor];
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    
    _mainView = [UIView new];
    _mainView.layer.masksToBounds = YES;
    _mainView.layer.borderColor = [ZMColor appLightGrayColor].CGColor;
    _mainView.layer.borderWidth = 0.5;
    _mainView.layer.cornerRadius = 3;
    [self addSubview:_mainView];
    [_mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];
    [_mainView.superview layoutIfNeeded];
    
    _thumbImageView = [UIImageView new];
    _thumbImageView.layer.masksToBounds = YES;
    _thumbImageView.image = placeholderFailImage;
    _thumbImageView.layer.cornerRadius = (_mainView.width - 20) * 0.5;
    
    [_mainView addSubview:_thumbImageView];
    [_thumbImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(_mainView.width - 20);
    }];
    [_thumbImageView.superview layoutIfNeeded];
    
    _nameLabel =            [UILabel new];
    _nameLabel.font =       [UIFont systemFontOfSize:15];
    _nameLabel.textColor =  [ZMColor blackColor];
    _nameLabel.text = @"阴阳师手游";
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    [_mainView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(_thumbImageView.mas_bottom).with.offset(5);
        make.height.mas_equalTo(18);
    }];
    
    _countLabel = [UILabel new];
    _countLabel.textColor = [ZMColor appSupportColor];
    _countLabel.font = [UIFont systemFontOfSize:13];
    _countLabel.textAlignment = NSTextAlignmentCenter;
    _countLabel.text = @"人气76.2W";
    [_mainView addSubview:_countLabel];
    [_countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(_nameLabel.mas_bottom).with.offset(5);
        make.height.mas_equalTo(15);
    }];
    
    _intoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _intoButton.layer.cornerRadius = 3;
    _intoButton.backgroundColor = [ZMColor appMainColor];
    [_intoButton setTitle:@"进入" forState:UIControlStateNormal];
    [_intoButton setTitleColor:[ZMColor whiteColor] forState:UIControlStateNormal];
    [_intoButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [_mainView addSubview:_intoButton];
    [_intoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(_countLabel.mas_bottom).with.offset(8);
        make.height.mas_equalTo(30);
    }];
    
}

- (void)setModel:(ZMCircleModel *)model{
    if (!model) return;
    _model = model;
     NSString *rightCover = [NSString stringWithFormat:@"%@%@%@%@",HttpImageURLPre,model.circlePic,HttpImageURLSuffixSquare,model.imageSuffix];
    [self.thumbImageView setImageWithURL:[NSURL URLWithString:rightCover] placeholder:placeholderFailImage];
    self.nameLabel.text  = model.circleName;
    self.countLabel.text = model.allCount;
    
}

@end