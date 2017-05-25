
//
//  NavigationController.m
//  YHJ_Demo
//
//  Created by yhj on 2017/5/5.
//  Copyright © 2017年 VG. All rights reserved.
//

#import "NavigationController.h"
#import "UINavigationBar+BackgroundColor.h"

@interface NavigationController ()

@end

@implementation NavigationController

+(void)initialize
{
    // UINavigationBar : UIView
    UINavigationBar *navigationBar=[UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[[self class]]];
    navigationBar.backgroundColor=MainColor;
//    navigationBar.shadowImage=[UIImage new];
    navigationBar.titleTextAttributes=@{
    NSForegroundColorAttributeName:[UIColor whiteColor],
    NSFontAttributeName:[UIFont systemFontOfSize:18]
                                        };
  [navigationBar setBackgroundImage:[UIImage imageNamed:@"Navbar"] forBarMetrics:UIBarMetricsDefault];
}


-(UIViewController *)childViewControllerForStatusBarStyle
{
    return self.childViewControllers.firstObject;
}

@end
