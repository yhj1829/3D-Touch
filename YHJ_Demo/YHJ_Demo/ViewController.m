//
//  ViewController.m
//  YHJ_Demo
//
//  Created by yhj on 2017/5/5.
//  Copyright © 2017年 VG. All rights reserved.
//

#import "ViewController.h"
#import "UIViewController+StatusBarStyle.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title=@"demo";

    self.lightStatusBar=YES;

//    // 动态创建
//    UIApplicationShortcutItem *item1=[[UIApplicationShortcutItem alloc]initWithType:@"two" localizedTitle:@"个人中心" localizedSubtitle:nil icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeLove] userInfo:nil];
//
//    UIApplicationShortcutItem *item2=[[UIApplicationShortcutItem alloc]initWithType:@"three" localizedTitle:@"查看课件" localizedSubtitle:nil icon:[UIApplicationShortcutIcon iconWithTemplateImageName:@"kejian@2x.png"] userInfo:nil];
//    [UIApplication sharedApplication].shortcutItems=@[item1,item2];
    

}


@end
