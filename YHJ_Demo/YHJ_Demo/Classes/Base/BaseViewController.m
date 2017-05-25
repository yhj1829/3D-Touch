//
//  BaseViewController.m
//  YHJ_Demo
//
//  Created by yhj on 2017/5/5.
//  Copyright © 2017年 VG. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 去掉导航栏下方的横线
    [Util findHairlineImageViewUnder:self.navigationController.navigationBar];

    self.view.backgroundColor=BGColor;

}



@end
