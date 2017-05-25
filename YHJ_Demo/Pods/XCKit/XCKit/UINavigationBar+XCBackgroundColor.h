//
//  UINavigationBar+BackgroundColor.h
//  OC—ovsdvsss
//
//  Created by 刘小椿 on 16/6/27.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (BackgroundColor)

@property (nonatomic,strong)UIView* overlay;

- (void)it_setBackgroundColor:(UIColor*)backgroundColor;

@end
