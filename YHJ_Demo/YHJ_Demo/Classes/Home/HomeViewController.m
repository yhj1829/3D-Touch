//
//  HomeViewController.m
//  YHJ_Demo
//
//  Created by yhj on 2017/5/5.
//  Copyright © 2017年 VG. All rights reserved.
//  3D Touch

#import "HomeViewController.h"
#import "DetailViewController.h"

static NSString *TableViewCellIdentifier=@"tableViewCellIdentifier";
@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource,UIViewControllerPreviewingDelegate>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *arr;

@end

@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.view addSubview:self.tableView];

}

-(NSMutableArray *)arr
{
    if (!_arr) {
        _arr=[NSMutableArray arrayWithObjects:@"TableView左滑操作01",@"TableView左滑操作02",@"TableView左滑操作03",@"TableView左滑操作04",@"TableView左滑操作05",@"TableView左滑操作06",@"TableView左滑操作07",@"TableView左滑操作08",@"TableView左滑操作09",@"TableView左滑操作10",@"TableView左滑操作11",@"TableView左滑操作12",@"TableView左滑操作13", nil];
    }
    return _arr;
}


// tableView
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
        _tableView.dataSource=self;
        _tableView.delegate=self;
        _tableView.backgroundColor=[UIColor whiteColor];
        _tableView.showsVerticalScrollIndicator=NO;
        _tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
        _tableView.tableFooterView=[UIView new];
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:TableViewCellIdentifier];
    }
    return _tableView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:TableViewCellIdentifier];
    cell.textLabel.text=self.arr[indexPath.row];
    cell.textLabel.textAlignment=NSTextAlignmentCenter;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;

    // 注意这是ios9的API,需要做一下版本控制，否则运行到9以下的会崩。
#ifdef __IPHONE_9_0
    if([[[UIDevice currentDevice] systemVersion]floatValue]>=9.0)
    {
        // 判断设备是否支持3dTouch
        if (self.traitCollection.forceTouchCapability==UIForceTouchCapabilityAvailable) {
            [self registerForPreviewingWithDelegate:self sourceView:cell];
        }
    }
#endif

    return cell;
}

-(void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit
{
    viewControllerToCommit.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:viewControllerToCommit animated:NO];
}


-(nullable UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location
{
    location=[self.tableView convertPoint:location fromView:[previewingContext sourceView]];
    // 根据location获取位置
    NSIndexPath *indexPath=[self.tableView indexPathForRowAtPoint:location];
    // 根据位置获取字典数据传入的控制器
    DetailViewController *vc=[DetailViewController new];
    vc.titleStr=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
    return vc;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewRowAction *deleteRowAction=[UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        NSLog(@"此为删除操作");
        [self.arr removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
    deleteRowAction.backgroundColor=[UIColor blackColor];

    UITableViewRowAction *editRowAction=[UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"编辑" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        NSLog(@"此为编辑操作");
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }];
    editRowAction.backgroundColor=[UIColor blueColor];

    UITableViewRowAction *topRowAction=[UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"置顶" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        NSLog(@"此为置顶操作");
        NSString *title=self.arr[indexPath.row];
        [self.arr removeObject:title];
        [self.arr insertObject:title atIndex:0];
        [tableView reloadData];
    }];
    topRowAction.backgroundColor=[UIColor redColor];

    return @[deleteRowAction,editRowAction,topRowAction];
}


-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}


// 间隙置边
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{

    if ([tableView respondsToSelector:@selector(setSeparatorInset:)])
    {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }

    if ([tableView respondsToSelector:@selector(setLayoutMargins:)])
    {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }

    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

@end
