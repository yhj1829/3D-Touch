//
//  UIDevice+XCDevice.h
//  XCKitDemo
//
//  Created by 刘小椿 on 16/12/2.
//  Copyright © 2016年 刘小椿. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (XCDevice)

/**
 *  Get the iOS version
 */
#define IOS_VERSION [UIDevice currentDevice].systemVersion

/**
 *  Get the screen width and height
 */
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width

/**
 *  Macros to compare system versions
 *
 *  @param v Version, like @"8.0"
 *
 *  @return Return a BOOL
 */
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare : v options : NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare : v options : NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare : v options : NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare : v options : NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare : v options : NSNumericSearch] != NSOrderedDescending)

/**
 连接网络

 @return 是否连接
 */
+ (BOOL)connectedToNetwork;

/**
 连接WiFi

 @return 是否连接
 */
+ (BOOL)connectedToWiFi;

/**
 强制屏幕旋转

 @param orientation 方向
 */
+ (void)setOrientation:(UIInterfaceOrientation)orientation;

/**
 获取本地IP地址

 @return IP
 */
+ (NSString *)localIPAddress;

/**
 电话支持

 @return 是否支持
 */
+ (BOOL)callPhoneSupported;

@end
