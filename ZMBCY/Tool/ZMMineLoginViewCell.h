//
//  ZMMineLoginViewCell.h
//  ZMBCY
//
//  Created by ZOMAKE on 2018/1/8.
//  Copyright © 2018年 Brance. All rights reserved.
//

#import "YYTableViewCell.h"

@class ZMMineProFileView,ZMMineLoginView;

@interface ZMMineLoginViewCell : YYTableViewCell

@property (nonatomic, strong) UIView              *mainView;
@property (nonatomic, strong) ZMMineProFileView   *profileView;
@property (nonatomic, strong) ZMMineLoginView     *loginView;

- (void)setupUI;

@end

@interface ZMMineProFileView : UIView

@property (nonatomic, strong) UIView        *mainView;
@property (nonatomic, strong) UIImageView   *thumbImageView;
@property (nonatomic, strong) UIImageView   *sexImageView;
@property (nonatomic, strong) UILabel       *nickNameLabel;
@property (nonatomic, strong) UILabel       *signLabel;
@property (nonatomic, strong) UIImageView   *rightArrow;

@end

@interface ZMMineLoginView : UIView

@property (nonatomic, strong) UIView        *mainView;
@property (nonatomic, strong) UIButton      *loginButton;
@property (nonatomic, strong) UIButton      *registerButton;
@property (nonatomic, strong) UILabel       *albumLabel;
@property (nonatomic, strong) UILabel       *albumCountLabel;
@property (nonatomic, strong) UILabel       *followLabel;
@property (nonatomic, strong) UILabel       *followCountLabel;
@property (nonatomic, strong) UILabel       *fansLabel;
@property (nonatomic, strong) UILabel       *fansCountLabel;
@property (nonatomic, strong) UILabel       *lineLabel1;
@property (nonatomic, strong) UILabel       *lineLabel2;

@end

@interface ZMMineCollectionViewCell : YYTableViewCell

@property (nonatomic, strong) UIView    *mainView;

@end
