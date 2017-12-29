//
//  ZMPostDetailBottomToolView.h
//  ZMBCY
//
//  Created by Brance on 2017/12/29.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMPostDetailBottomToolView : UIView

@property (nonatomic, strong) UIView        *mainView;
@property (nonatomic, strong) UIButton      *collectButton;
@property (nonatomic, strong) UIButton      *commentButton;
@property (nonatomic, strong) UIButton      *praiseButton;
@property (nonatomic, strong) UILabel       *praiseCountLabel;
@property (nonatomic, strong) NSString      *count;

@property (nonatomic, copy) void(^clickCollectBlock)(BOOL);
@property (nonatomic, copy) void(^clickCommentBlock)(BOOL);
@property (nonatomic, copy) void(^clickPraiseBlock)(BOOL);

@end
