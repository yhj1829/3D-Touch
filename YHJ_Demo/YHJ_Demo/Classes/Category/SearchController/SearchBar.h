//
//  SearchBar.h
//  YHJ_Demo
//
//  Created by yhj on 2017/5/5.
//  Copyright © 2017年 VG. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SearchBar;

@protocol SearchBarDelegate <NSObject>

@optional

-(void)searchBarTextDidBeginEditing:(SearchBar *)searchBar;

-(void)searchBarTextDidEndEditing:(SearchBar *)searchBar;

//-(void)searchBar:(SearchBar *)searchBar textDidChangeSearchText:(NSString *)searchText;

-(void)searchBar:(SearchBar *)searchBar textDidChange:(NSString *)searchText;

@end

@interface SearchBar : UIView

@property(nonatomic,strong)NSString *placeholder;

@property(nonatomic,strong)NSString *text;

@property(nonatomic,weak)id<SearchBarDelegate>delegate;

@end
