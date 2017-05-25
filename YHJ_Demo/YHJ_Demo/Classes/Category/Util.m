//
//  Util.m
//  YHJ_Demo
//
//  Created by yhj on 2017/5/5.
//  Copyright © 2017年 VG. All rights reserved.
//

#import "Util.h"

@implementation Util

// 去掉导航栏下方的横线
+(UIImageView *)findHairlineImageViewUnder:(UIView*)view
{
    if([view isKindOfClass:[UIImageView class]] && view.bounds.size.height<=1.0) {
        return(UIImageView*)view;
    }
    for(UIView*subview in view.subviews) {
        UIImageView*imageView = [self findHairlineImageViewUnder:subview];
        if(imageView) {
            imageView.hidden = YES ;
            return imageView;
        }
    }
    return nil;
}

@end
