//
//  NSDate+XCDate.m
//  XCKitDemo
//
//  Created by 刘小椿 on 16/12/2.
//  Copyright © 2016年 刘小椿. All rights reserved.
//

#import "NSDate+XCDate.h"

@implementation NSDate (XCDate)

-(NSString *)formattedDateWithFormat:(NSString *)format
{
    return [self formattedDateWithFormat:format timeZone:[NSTimeZone systemTimeZone] locale:[NSLocale autoupdatingCurrentLocale]];
}

-(NSString *)formattedDateWithFormat:(NSString *)format timeZone:(NSTimeZone *)timeZone locale:(NSLocale *)locale
{
    static NSDateFormatter *formatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc] init];
    });
    
    [formatter setDateFormat:format];
    [formatter setTimeZone:timeZone];
    [formatter setLocale:locale];
    return [formatter stringFromDate:self];
}

@end
