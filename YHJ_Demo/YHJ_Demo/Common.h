//
//  Common.h
//  OAProject
//
//  Created by yhj on 2017/2/20.
//  Copyright © 2017年 cdnunion. All rights reserved.
//  全局宏

#ifndef Common_h
#define Common_h



// 个推开发者网站中申请App时,注册的AppId、AppKey、AppSecret
#define kGtAppId           @"C1zc3WWjDDADl2Z4SqpI29"
#define kGtAppKey          @"vBQQChicGE8GvIlbFNd3I8"
#define kGtAppSecret       @"xNtKdgDEFvAKqZ83o6Yur5"


/*
203.156.198.118 test.my.vathome.cn  后台
203.156.198.118 test.api.vathome.cn。任务管理系统
203.156.198.179 test.app.cdnunion.com   oa登录登出
*/

// OA登录退出
#define kBaseLoginURL   @"http://test.app.cdnunion.com/"

// 其他的
// 测试的
#define kBaseUrl        @"http://test.api.vathome.cdnunion.com/"

// 正式的
////#define kBaseUrl        @"http://api.vathome.cdnunion.com/"
//#define kBaseUrl        @"http://api.vathome.cn/"

// 测试的
// 登录URL
#define LoginURL        @"http://test.app.cdnunion.com/admin/index/login"
// 登出URL
#define LogoutURL        @"http://test.app.cdnunion.com/admin/index/logout"


//// 正式的
//// 登录URL
//#define LoginURL        @"https://app.cdnunion.com/admin/index/login"
//// 登出URL
//#define LogoutURL        @"https://app.cdnunion.com/admin/index/logout"


// 上传文件的baseURL
#define FilePathBaseUrl  @"http://s-api.yunvm.com/vathome/"


// 推送上传token
// 测试的
#define Upload_TokenUrl  @"http://test.app.cdnunion.com/admin/index/upload_token"

// 正式的
//#define Upload_TokenUrl  @"https://app.cdnunion.com/admin/index/upload_token"


#define MemberID     @"1"


// 任务状态列表 和流程状态列表
#define Status_0  @"编辑中"    // 因-1不能设置 用0代替
#define Status_1  @"等待接受"
#define Status_2  @"等待关联任务"
#define Status_3  @"未开始"
#define Status_4  @"进行中"
#define Status_5  @"暂停"
#define Status_6  @"拒绝"
#define Status_7  @"取消"
#define Status_8  @"待验收"
#define Status_9  @"待评分"
#define Status_10  @"完成"

#define kApp_Key        @"E12AAD9E3CD85"
#define kPOST           @"POST"
//#define kAPPLEID      @"com.cdnunion.oa"
#define kAPPLEID        @"vangen"

#define ISLogin         @"ISLogin"
#define ISLogout        @"ISLogout"

#define kGapTime        .5
#define kmargin         10


#define IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)

// 屏幕
#define APPW [UIScreen mainScreen].bounds.size.width
#define APPH [UIScreen mainScreen].bounds.size.height

// 字体大小
#define Font_Number(a)     [UIFont fontWithName:@"Arial" size:a]

// 颜色值 16进制
#define HexRGB(rgbValue)    [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define RGB(R,G,B,Alpha)    [UIColor colorWithRed:R/255.f green:G/255.f blue:B/255.f alpha:Alpha]

// View 圆角和加边框
#define ViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]


// 单利
#define DEFINE_SINGLETON_FOR_HEADER(className) \
\
+ (className *)shared##className;

#define DEFINE_SINGLETON_FOR_CLASS(className) \
\
+ (className *)shared##className { \
static className *shared##className = nil; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
shared##className = [[self alloc] init]; \
}); \
return shared##className; \
}


#define place_image01   [UIImage imageNamed:@"placeimage01"]
#define place_image02   [UIImage imageNamed:@"placeimage02"]
#define place_image03   [UIImage imageNamed:@"placeimage03"]


#endif /* Common_h */
