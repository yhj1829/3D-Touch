//
//  UITableView+XCTableview.h
//  XCApp
//
//  Created by 刘小椿 on 16/11/12.
//  Copyright © 2016年 刘小椿. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (XCTableview)

/**
 *  Create an UITableView and set some parameters
 *
 *  @param frame              TableView's frame
 *  @param style              TableView's style
 *  @param cellSeparatorStyle Cell separator style
 *  @param separatorInset     Cell separator inset
 *  @param dataSource         TableView's data source
 *  @param delegate           TableView's delegate
 *
 *  @return Return the created UITableView
 */
+ (UITableView *)initWithFrame:(CGRect)frame style:(UITableViewStyle)style cellSeparatorStyle:(UITableViewCellSeparatorStyle)cellSeparatorStyle separatorInset:(UIEdgeInsets)separatorInset dataSource:(id <UITableViewDataSource> )dataSource delegate:(id <UITableViewDelegate> )delegate;

/**
 *  Retrive the next index path for the given row at section
 *
 *  @param row     Row of the index path
 *  @param section Section of the index path
 *
 *  @return Return the next index path
 */
- (NSIndexPath *)getNextIndexPath:(NSUInteger)row
                       forSection:(NSUInteger)section;

/**
 *  Retrive the previous index path for the given row at section
 *
 *  @param row     Row of the index path
 *  @param section Section of the index path
 *
 *  @return Return the previous index path
 */
- (NSIndexPath *)getPreviousIndexPath:(NSUInteger)row
                           forSection:(NSUInteger)section;

/**
 *  Return the selected cell
 *
 *  @return Return the selected cell
 */
- (UITableViewCell *)selectedCell;

/**
 *  hide bottom separators
 */
- (void)hideEmptySeparators;

@end
