//
//  SearchBar.m
//  YHJ_Demo
//
//  Created by yhj on 2017/5/5.
//  Copyright © 2017年 VG. All rights reserved.
//

#import "SearchBar.h"
#import "SearchTextField.h"

@interface SearchBar ()<UITextFieldDelegate>

@property(nonatomic,strong)UIImageView *backgroundImageView;

@property(nonatomic,strong)SearchTextField *searchTextField;

@property(nonatomic,assign)BOOL isEditing;

@property(nonatomic,strong)UIButton *rightBtn;

@property(nonatomic,strong)UIButton *cancelBtn;

@end


NSString *SEARCH_CANCEL_NOTIFICATION_KEY=@"SEARCH_CANCEL_NOTIFICATION_KEY";

@implementation SearchBar

-(instancetype)initWithFrame:(CGRect)frame
{
    frame=CGRectMake(0,0,APPW,44);
    self=[super initWithFrame:frame];
    self.backgroundColor=[UIColor redColor];
    [self addSubview:self.backgroundImageView];
    [self addSubview:self.searchTextField];
    [self addSubview:self.rightBtn];
    [self addSubview:self.cancelBtn];
    return self;
}

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.searchTextField.placeholder=self.placeholder;
}


-(void)setIsEditing:(BOOL)isEditing
{
    _isEditing=isEditing;
    if (_isEditing)
    {
        [UIView animateWithDuration:.2 animations:^{

            self.searchTextField.x=10;
            self.rightBtn.x=APPW-38-40;
            self.backgroundImageView.width=APPW-20-40;
            self.cancelBtn.x=APPW-40;

        } completion:^(BOOL finished) {

            self.searchTextField.width=APPW-20-38-40;
        }];
        self.searchTextField.canTouch=YES;
        [self.searchTextField becomeFirstResponder];
    }
    else
    {
      self.searchTextField.text=@"";
      self.text=@"";
      [_rightBtn setImage:[UIImage imageNamed:@"VoiceSearchStartBtn"] forState:0];
      [_rightBtn setImage:[UIImage imageNamed:@"VoiceSearchStartBtnHL"] forState:UIControlStateHighlighted];
        [UIView animateWithDuration:.2 animations:^{

            self.searchTextField.x=APPW/2-40;
            self.rightBtn.x=APPW-38;
            self.backgroundImageView.width=APPW-20;
            self.cancelBtn.x=APPW;

        } completion:^(BOOL finished) {

            self.searchTextField.width=APPW/2+20-38;
        }];
        self.searchTextField.canTouch=NO;
        [self.searchTextField resignFirstResponder];
    }
}


-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ([self.delegate respondsToSelector:@selector(searchBarTextDidBeginEditing:)])
    {
        [self.delegate searchBarTextDidBeginEditing:self];
    }
}


-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
  [UIView animateWithDuration:.3 animations:^{

      self.searchTextField.x=10;
      
  } completion:^(BOOL finished) {

      self.searchTextField.width=APPW-20-38-40;

  }];
    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [UIView animateWithDuration:.3 animations:^{

        self.searchTextField.x=APPW/2-40;

    } completion:^(BOOL finished) {

        self.searchTextField.width=APPW/2+20-38-40;
        
    }];
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([self.delegate respondsToSelector:@selector(searchBarTextDidEndEditing:)])
    {
        [self.delegate searchBarTextDidEndEditing:self];
    }
}

// backgroundImageView
-(UIImageView *)backgroundImageView
{
    if (!_backgroundImageView) {
        _backgroundImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"widget_searchbar_textfield"]];
        _backgroundImageView.frame=CGRectMake(10,8,APPW-20,44-16);
    }
    return _backgroundImageView;
}

// searchTextField
-(SearchTextField *)searchTextField
{
    if (!_searchTextField) {
        _searchTextField=[[SearchTextField alloc]initWithFrame:CGRectMake(APPW/2-40,0,APPW/2+20-38,44)];
        _searchTextField.canTouch=NO;
        UIImageView *searchIcon=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"SearchContactsBarIcon"]];
        searchIcon.contentMode=UIViewContentModeScaleAspectFit;
        searchIcon.frame=CGRectMake(0,0,30,14);
        _searchTextField.leftView=searchIcon;
        _searchTextField.leftViewMode=UITextFieldViewModeAlways;
        _searchTextField.font=Font_Number(16);
        [_searchTextField addTarget:searchIcon action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
        _searchTextField.delegate=self;
    }
    return _searchTextField;
}

-(void)textFieldDidChange
{
    if ([self.delegate respondsToSelector:@selector(searchBar:textDidChange:)])
    {
        [self.delegate searchBar:self textDidChange:self.searchTextField.text];
    }
    self.text=self.searchTextField.text;
    if (self.searchTextField.text.length)
    {
        [_rightBtn setImage:[UIImage imageNamed:@"card_delete"] forState:0];
        [_rightBtn setImage:[UIImage imageNamed:@"card_delete"] forState:UIControlStateHighlighted];
    }
    else
    {
        [_rightBtn setImage:[UIImage imageNamed:@"VoiceSearchStartBtn"] forState:0];
        [_rightBtn setImage:[UIImage imageNamed:@"VoiceSearchStartBtnHL"] forState:UIControlStateHighlighted];
    }
}

// rightBtn
-(UIButton *)rightBtn
{
    if (!_rightBtn) {
        _rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_rightBtn setImage:[UIImage imageNamed:@"VoiceSearchStartBtn"] forState:0];
        [_rightBtn setImage:[UIImage imageNamed:@"VoiceSearchStartBtnHL"] forState:UIControlStateHighlighted];
        _rightBtn.frame=CGRectMake(APPW-38,8,28,28);
        _rightBtn.backgroundColor=[UIColor purpleColor];
        [_rightBtn addTarget:self action:@selector(rightBtnEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBtn;
}

-(void)rightBtnEvent
{
    if (self.searchTextField.text) {
        self.searchTextField.text=@"";
        self.text=nil;
        [_rightBtn setImage:[UIImage imageNamed:@"VoiceSearchStartBtn"] forState:0];
        [_rightBtn setImage:[UIImage imageNamed:@"VoiceSearchStartBtnHL"] forState:UIControlStateHighlighted];
    }
}

// cancelBtn
-(UIButton *)cancelBtn
{
    if (!_cancelBtn) {
        _cancelBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _cancelBtn.frame=CGRectMake(APPW,0,40,44);
        _cancelBtn.titleLabel.font=Font_Number(16);
        [_cancelBtn setTitle:@"取消" forState:0];
        [_cancelBtn setTitleColor:MainColor forState:0];
        [_cancelBtn addTarget:self action:@selector(cancelBtnEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}


-(void)cancelBtnEvent
{
    [[NSNotificationCenter defaultCenter]postNotificationName:SEARCH_CANCEL_NOTIFICATION_KEY object:nil];
}

@end
