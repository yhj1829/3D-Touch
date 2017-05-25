//
//  UIColor+XCColor.h
//  XCApp
//
//  Created by 刘小椿 on 16/11/12.
//  Copyright © 2016年 刘小椿. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (XCColor)

/**
 *  根据#XXXXXX设置颜色
 *
 *  @param hexCode 颜色值
 *
 *  @return 颜色
 */
+(UIColor *) colorWithHexCode:(NSString *)hexCode;

@end
