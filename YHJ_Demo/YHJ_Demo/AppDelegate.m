//
//  AppDelegate.m
//  YHJ_Demo
//
//  Created by yhj on 2017/5/5.
//  Copyright © 2017年 VG. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+RootViewController.h"
#import "TabBarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [self configRootViewController];

    // 动态创建  3D Touch 的 Quick Actions(快捷菜单)
    UIApplicationShortcutItem *item1=[[UIApplicationShortcutItem alloc]initWithType:@"two" localizedTitle:@"购买商城" localizedSubtitle:nil icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeLove] userInfo:nil];

    UIApplicationShortcutItem *item2=[[UIApplicationShortcutItem alloc]initWithType:@"three" localizedTitle:@"查看信息" localizedSubtitle:nil icon:[UIApplicationShortcutIcon iconWithTemplateImageName:@"kejian@2x.png"] userInfo:nil];
    [UIApplication sharedApplication].shortcutItems=@[item1,item2];



    if (launchOptions[@"UIApplicationLaunchOptionsShortcutItemKey"]== nil)
    {
        self.window.rootViewController=[TabBarController new];
        return YES;
    }
    else
    {
        UIApplicationShortcutItem *item=[launchOptions valueForKey:UIApplicationLaunchOptionsShortcutItemKey];

        // 根据我们设置的唯一标识判断
        if([item.type isEqualToString:@"one"])
        {
            TabBarController *tabbar=[TabBarController new];
            tabbar.selectedIndex=0;
            self.window.rootViewController=tabbar;
        }
        return NO;
    }

    return YES;
}

-(void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler
{
    // 根据我们设置的唯一标识判断
    if([shortcutItem.type isEqualToString:@"one"])
    {
        TabBarController *tabbar=[TabBarController new];
        tabbar.selectedIndex=0;
        self.window.rootViewController=tabbar;
    }
    // 根据我们设置的 title 判断
    if ([shortcutItem.localizedTitle isEqual:@"查看信息"])
    {
        TabBarController *tabbar=[TabBarController new];
        tabbar.selectedIndex=1;
        self.window.rootViewController=tabbar;
    }
    else if ([shortcutItem.localizedTitle isEqual:@"购买商城"])
    {
        TabBarController *tabbar=[TabBarController new];
        tabbar.selectedIndex=2;
        self.window.rootViewController=tabbar;
    }
}

@end
