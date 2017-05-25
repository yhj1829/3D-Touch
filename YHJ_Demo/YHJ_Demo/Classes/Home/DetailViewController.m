//
//  DetailViewController.m
//  YHJ_Demo
//
//  Created by yhj on 2017/5/25.
//  Copyright © 2017年 VG. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@property(nonatomic,readonly)NSArray *previewActionItems;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.title=self.titleStr;

    [self getData];

}


-(NSArray<id<UIPreviewActionItem>>*)previewActionItems
{

    UIPreviewAction *previewAction1=[UIPreviewAction actionWithTitle:@"点赞" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
      // todo
    }];

    UIPreviewAction *previewAction2=[UIPreviewAction actionWithTitle:@"分享" style:UIPreviewActionStyleDestructive handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        // todo
    }];

    return @[previewAction1,previewAction2];
}


-(void)getData
{
    UIWebView *web=[[UIWebView alloc]initWithFrame:CGRectMake(0,0,APPW,APPH)];
    web.backgroundColor=WhiteColor;
    web.opaque=NO;

    NSURL *baseUrl=[NSURL fileURLWithPath:[[NSBundle mainBundle]bundlePath]];
    NSString *htmlStr=[NSString stringWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"service_terms_chs.html" ofType:nil] encoding:NSUTF8StringEncoding error:nil];
    [web loadHTMLString:htmlStr baseURL:baseUrl];
    [self.view addSubview:web];

}

@end
