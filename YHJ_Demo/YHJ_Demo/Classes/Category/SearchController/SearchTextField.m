//
//  SearchTextField.m
//  YHJ_Demo
//
//  Created by yhj on 2017/5/5.
//  Copyright © 2017年 VG. All rights reserved.
//

#import "SearchTextField.h"

@implementation SearchTextField

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    self.canTouch=YES;
    return self;
}

-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    BOOL result=[super pointInside:point withEvent:event];
    if (self.canTouch)
    {
        return result;
    }
    else
    {
        return NO;
    }
}

@end
