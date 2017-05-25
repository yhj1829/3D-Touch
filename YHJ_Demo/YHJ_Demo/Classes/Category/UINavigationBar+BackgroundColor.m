//
//  UINavigationBar+BackgroundColor.m
//  YHJ_Demo
//
//  Created by yhj on 2017/5/5.
//  Copyright © 2017年 VG. All rights reserved.
//  修改背景颜色

#import "UINavigationBar+BackgroundColor.h"
#import <objc/runtime.h>

static const char *BG_Color_KEY="BG_Color_KEY";

@implementation UINavigationBar (BackgroundColor)

static UIView *backgroundView;

+(void)load
{
    backgroundView=[[UIView alloc]initWithFrame:CGRectMake(0,-20,[UIScreen mainScreen].bounds.size.width,64)];
    method_exchangeImplementations(class_getInstanceMethod([UINavigationBar class],NSSelectorFromString(@"layoutSubviews")),class_getInstanceMethod([UINavigationBar class],@selector(yhj_layoutSubviews)));
}

-(void)yhj_layoutSubviews
{
    [self yhj_layoutSubviews];
    [self sendSubviewToBack:backgroundView];
}

-(void)setBackgroundColor:(UIColor *)backgroundColor
{
    objc_setAssociatedObject(self,BG_Color_KEY,backgroundColor,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self insertSubview:backgroundView atIndex:0];
    backgroundView.backgroundColor=backgroundColor;
}

-(UIColor *)backgroundColor
{
    return objc_getAssociatedObject(self,BG_Color_KEY);
}

@end
