//
//  UITableView+XCTableview.m
//  XCApp
//
//  Created by 刘小椿 on 16/11/12.
//  Copyright © 2016年 刘小椿. All rights reserved.
//

#import "UITableView+XCTableview.h"

@implementation UITableView (XCTableview)

+ (UITableView *)initWithFrame:(CGRect)frame style:(UITableViewStyle)style cellSeparatorStyle:(UITableViewCellSeparatorStyle)cellSeparatorStyle separatorInset:(UIEdgeInsets)separatorInset dataSource:(id <UITableViewDataSource> )dataSource delegate:(id <UITableViewDelegate> )delegate {
    UITableView *tableView = [[UITableView alloc] initWithFrame:frame style:style];
    [tableView setSeparatorStyle:cellSeparatorStyle];
    [tableView setSeparatorInset:separatorInset];
    [tableView setDelegate:delegate];
    [tableView setDataSource:dataSource];
    
    return tableView;
}

- (NSArray *)getIndexPathsForSection:(NSUInteger)section;
{
    NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
    NSInteger rows = [self numberOfRowsInSection:section];
    for (int i = 0; i < rows; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:section];
        [indexPaths addObject:indexPath];
    }
    
    return (NSArray *)indexPaths;
}

- (NSIndexPath *)getNextIndexPath:(NSUInteger)row forSection:(NSUInteger)section {
    NSArray *indexPaths = [self getIndexPathsForSection:section];
    return [indexPaths objectAtIndex:row + 1];
}

- (NSIndexPath *)getPreviousIndexPath:(NSUInteger)row forSection:(NSUInteger)section {
    NSArray *indexPaths = [self getIndexPathsForSection:section];
    return [indexPaths objectAtIndex:row - 1];
}

- (UITableViewCell *)selectedCell {
    return [self cellForRowAtIndexPath:[self indexPathForSelectedRow]];
}

- (void)hideEmptySeparators {
    UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
    
    v.backgroundColor = [UIColor clearColor];
    [self setTableFooterView:v];
}

@end
