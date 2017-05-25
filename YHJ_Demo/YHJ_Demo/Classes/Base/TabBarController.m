//
//  TabBarController.m
//  YHJ_Demo
//
//  Created by yhj on 2017/5/5.
//  Copyright © 2017年 VG. All rights reserved.
//

#import "TabBarController.h"
#import "NavigationController.h"
#import "HomeViewController.h"
#import "MyViewController.h"
#import "MessageViewController.h"
#import "ShopViewController.h"


@interface TabBarController ()

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 设置tabBar的背景色
    [[UITabBar appearance] setBarTintColor:MainColor];

    [self addChildController];

}

-(void)addChildController
{
    [self addChildWithNavClass:[NavigationController class] vcClass:[HomeViewController class] title:@"首页" imageName:@"tab_message"];

   [self addChildWithNavClass:[NavigationController class] vcClass:[MessageViewController class] title:@"信息" imageName:@"tab_my"];

   [self addChildWithNavClass:[NavigationController class] vcClass:[ShopViewController class] title:@"购买" imageName:@"tab_my"];

    [self addChildWithNavClass:[NavigationController class] vcClass:[MyViewController class] title:@"我的" imageName:@"tab_my"];

}

-(void)addChildWithNavClass:(Class)navClass vcClass:(Class)vc title:(NSString *)title imageName:(NSString *)imageName
{
    UIViewController *rootVC=[vc new];
    rootVC.title=title;
    NavigationController *navVC=[[navClass  alloc] initWithRootViewController:rootVC];
    navVC.tabBarItem.image=[UIImage imageNamed:imageName];
    navVC.tabBarItem.selectedImage=[[UIImage imageNamed:[NSString stringWithFormat:@"%@_select",imageName]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]; // 取消默认的蓝色背景模式
    [navVC.tabBarItem setTitleTextAttributes:@{
                                              NSFontAttributeName:Font_Number(12),
                                              NSForegroundColorAttributeName:LightGreyColor
                                              }forState:0];
    [navVC.tabBarItem setTitleTextAttributes:@{
                                               NSFontAttributeName:Font_Number(12),
                                               NSForegroundColorAttributeName:WhiteColor
                                               }forState:UIControlStateSelected];
    [self addChildViewController:navVC];
}


@end
