//
//  NSDate+XCDate.h
//  XCKitDemo
//
//  Created by 刘小椿 on 16/12/2.
//  Copyright © 2016年 刘小椿. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (XCDate)

/**
 标准时间

 @param format YY-MM-dd HH:mm
 @return 时间
 */
-(NSString *)formattedDateWithFormat:(NSString *)format;

@end
