//
//  UIControl+UIControl_XY.m
//  6666
//
//  Created by 刘小椿 on 16/10/18.
//  Copyright © 2016年 刘小椿. All rights reserved.
//

#import "UIControl+XCUIControl.h"
#import <objc/runtime.h>

@interface UIControl()

@property(nonatomic,assign) NSTimeInterval xc_acceptEventTime;

@end

@implementation UIControl (XCUIControl)

static const char *UIControl_acceptEventInterval = "UIControl_acceptEventInterval";
static const char *UIControl_acceptEventTime = "UIControl_acceptEventTime";

- (NSTimeInterval)xc_acceptEventInterval
{
    return [objc_getAssociatedObject(self, UIControl_acceptEventInterval) doubleValue];
}

- (void)setXc_acceptEventInterval:(NSTimeInterval)xc_acceptEventInterval
{
    objc_setAssociatedObject(self, UIControl_acceptEventInterval, @(xc_acceptEventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSTimeInterval)xc_acceptEventTime
{
    return [objc_getAssociatedObject(self, UIControl_acceptEventTime) doubleValue];
}

- (void)setXc_acceptEventTime:(NSTimeInterval)xc_acceptEventTime
{
    objc_setAssociatedObject(self, UIControl_acceptEventTime, @(xc_acceptEventTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (void)load
{
    // 替换系统的方法
    Method systemMethod = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
    SEL sysSEL = @selector(sendAction:to:forEvent:);
    
    Method myMethod = class_getInstanceMethod(self, @selector(xc_sendAction:to:forEvent:));
    SEL mySEL = @selector(xc_sendAction:to:forEvent:);
    
    BOOL didAddMethod = class_addMethod(self, sysSEL, method_getImplementation(myMethod), method_getTypeEncoding(myMethod));
    
    if (didAddMethod) {
        class_replaceMethod(self, mySEL, method_getImplementation(systemMethod), method_getTypeEncoding(systemMethod));
    }else{
        method_exchangeImplementations(myMethod, systemMethod);
    }
    
}

- (void)xc_sendAction:(SEL)action to:(id)target forEvent:(UIEvent*)event
{
    if (NSDate.date.timeIntervalSince1970 - self.xc_acceptEventTime < self.xc_acceptEventInterval) {
        return;
    }
    
    if (self.xc_acceptEventInterval > 0) {
        self.xc_acceptEventTime = NSDate.date.timeIntervalSince1970;
    }
    
    [self xc_sendAction:action to:target forEvent:event];
}


@end
