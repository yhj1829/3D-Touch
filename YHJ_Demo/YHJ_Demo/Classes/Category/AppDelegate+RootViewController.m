//
//  AppDelegate+RootViewController.m
//  YHJ_Demo
//
//  Created by yhj on 2017/5/5.
//  Copyright © 2017年 VG. All rights reserved.
//

#import "AppDelegate+RootViewController.h"
#import "ViewController.h"
#import "NavigationController.h"
//#import "CYLTabBarControllerConfig.h"
#import "TabBarController.h"

@implementation AppDelegate (RootViewController)

-(void)configRootViewController
{
    self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController=[TabBarController new];
     //[[CYLTabBarControllerConfig new]tabBarController];
//    [[NavigationController alloc]initWithRootViewController:[ViewController new]];
    [self.window makeKeyAndVisible];
    self.window.backgroundColor=[UIColor whiteColor];
}


@end
