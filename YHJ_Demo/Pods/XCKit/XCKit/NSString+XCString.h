//
//  NSString+XCString.h
//  XCKitDemo
//
//  Created by 刘小椿 on 16/12/2.
//  Copyright © 2016年 刘小椿. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (XCString)

/**
 易卡爱途专用
 
 检查是否包含字母和数字

 @return 1: 全数字
         2: 全字母
         3: 数字 字母混排
         4: 数字 字母 ＋ 其他字符
 */
- (int)checkIsHaveNumAndLetter;

/**
 隐藏部分电话号码

 @return 隐藏后的电话号码
 */
- (NSString *)privacyPhone;

/**
 *  是否有效手机号
 */
- (BOOL)isPhone;

/**
 *  是否有效QQ
 */
- (BOOL)isQQ;

/**
 *  是否有效生日
 */
- (BOOL)isBirthday;

/**
 检查邮件是否合格

 @return 是否合格
 */
- (BOOL)isEmail;

/**
 检查字符串是否是邮件格式

 @param email 字符串
 @return 是否是邮件
 */
+ (BOOL)isEmail:(NSString *)email;

/**
 计算文本

 @param widthValue 文本宽度
 @param font 文本字体大小
 @return 文本宽高
 */
- (CGSize)xc_findHeightForHavingWidth:(CGFloat)widthValue andFont:(UIFont *)font;

@end
