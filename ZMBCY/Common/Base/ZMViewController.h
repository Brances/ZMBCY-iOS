//
//  ZMViewController.h
//  ZMBCY
//
//  Created by Brance on 2017/11/24.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZMNavView.h"

@interface ZMViewController : UIViewController

@property (nonatomic, strong) ZMNavView       *navView;

- (void)setupNavView;

@end
