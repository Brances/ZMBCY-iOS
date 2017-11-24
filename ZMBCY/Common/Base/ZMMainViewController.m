//
//  ZMMainViewController.m
//  ZMBCY
//
//  Created by 卢洋 on 2017/11/23.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "ZMMainViewController.h"
#import "BaseNavigationController.h"
#import <AudioToolbox/AudioToolbox.h>
#import "YYFPSLabel.h"
#import "ZMHomeViewController.h"
#import "ZMDiscoverViewController.h"
#import "ZMTopicViewController.h"
#import "ZMMessageViewController.h"
#import "ZMMineViewController.h"

@interface ZMMainViewController ()

@end

@implementation ZMMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //首页
    [self addChildVc:[ZMHomeViewController new] title:@"首页" image:@"tabbar_icon0" selectedImage:@"tabbar_icon0_s"];
    //发现
    [self addChildVc:[ZMDiscoverViewController new] title:@"发现" image:@"tabbar_icon1" selectedImage:@"tabbar_icon1_s"];
    //话题
    [self addChildVc:[ZMTopicViewController new] title:@"话题" image:@"tabbar_icon2" selectedImage:@"tabbar_icon2_s"];
    //消息
    [self addChildVc:[ZMMessageViewController new] title:@"消息" image:@"tabbar_icon_message" selectedImage:@"tabbar_icon_message_s"];
    //我的
    [self addChildVc:[ZMMineViewController new] title:@"我的" image:@"tabbar_icon3" selectedImage:@"tabbar_icon3_s"];
}

/**
 *  添加一个子控制器
 *
 *  @param childVc       子控制器
 *  @param title         标题
 *  @param image         图片
 *  @param selectedImage 选中的图片
 */
#pragma mark - 添加子控制器
- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage{
    // 设置子控制器的文字(可以设置tabBar和navigationBar的文字)
    childVc.title = title;
    
    // 设置子控制器的tabBarItem图片
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    // 禁用图片渲染
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    BaseNavigationController *nav = [[BaseNavigationController alloc]initWithRootViewController:childVc];
    //设置item按钮
    nav.tabBarItem = [[UITabBarItem alloc]initWithTitle:title image:[[UIImage imageNamed:image]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    //未选中字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[ZMColor colorWithRed:136 withGreen:134 withBlue:135 withAlpha:1],NSFontAttributeName:[UIFont systemFontOfSize:10]} forState:UIControlStateNormal];
    
    //选中字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[ZMColor appMainColor],NSFontAttributeName:[UIFont systemFontOfSize:10]} forState:UIControlStateSelected];
    
    [nav.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -2)];
    //nav.tabBarItem.imageInsets = UIEdgeInsetsMake(-2, 0, 2, 0);
    //nav.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
    
    // 添加子控制器
    [self addChildViewController:nav];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    NSInteger index = [self.tabBar.items indexOfObject:item];
    [self playSound];//点击时音效
    [self animationWithIndex:index];
}

-(void) playSound{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"like" ofType:@"caf"];
    SystemSoundID soundID;
    NSURL *soundURL = [NSURL fileURLWithPath:path];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)soundURL,&soundID);
    AudioServicesPlaySystemSound(soundID);
    
}
- (void)animationWithIndex:(NSInteger) index {
    if (self.selectedIndex == index) {
        return;
    }
    NSMutableArray * tabbarbuttonArray = [NSMutableArray array];
    for (UIView *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabbarbuttonArray addObject:tabBarButton];
        }
    }
    CATransition* animation = [CATransition animation];
    [animation setDuration:0.3f];
    //动画切换风格
    [animation setType:kCATransitionFade];
    //animation.type = @"cube";
    //动画切换方向
    [animation setSubtype:kCATransitionFromBottom];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [[tabbarbuttonArray[index] layer]addAnimation:animation forKey:@"UITabBarButton.transform.scale"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
