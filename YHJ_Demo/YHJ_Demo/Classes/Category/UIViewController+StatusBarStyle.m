//
//  UIViewController+StatusBarStyle.m
//  YHJ_Demo
//
//  Created by yhj on 2017/5/5.
//  Copyright © 2017年 VG. All rights reserved.
//  修改状态栏颜色

#import "UIViewController+StatusBarStyle.h"
#import <objc/runtime.h>

static const char *LIGHT_STATUS_BAR_KEY = "LIGHT_STATUS_BAR_KEY";

@implementation UIViewController (StatusBarStyle)

-(void)setLightStatusBar:(BOOL)lightStatusBar
{
    objc_setAssociatedObject(self,LIGHT_STATUS_BAR_KEY,[NSNumber numberWithInt:lightStatusBar], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self preferredStatusBarStyle];
    [self setNeedsStatusBarAppearanceUpdate];
}

-(BOOL)lightStatusBar
{
    return objc_getAssociatedObject(self,LIGHT_STATUS_BAR_KEY)?[objc_getAssociatedObject(self, LIGHT_STATUS_BAR_KEY)boolValue]:NO;
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return self.lightStatusBar?UIStatusBarStyleLightContent:UIStatusBarStyleDefault;
}

@end
