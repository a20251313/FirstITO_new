//
//  LixilBaseViewController.m
//  ShowCasePro
//
//  Created by Mac on 14-3-27.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "LixilBaseViewController.h"
#import "CustomTextField.h"
#import "LixilSearchViewController.h"
#import "LixilRightSettingBar.h"

@interface LixilBaseViewController ()<UITextFieldDelegate>
{
    UIView *navView;//顶部的导航栏
}

@property (nonatomic, strong) UIButton *searchBtn;
@property (nonatomic, strong) UITapGestureRecognizer *temp_ViewTap;

@end

@implementation LixilBaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024, 85)];
    [self.view addSubview:navView];
    
    UIImageView *bgImage = [[UIImageView alloc] initWithFrame:navView.frame];
    bgImage.image = [UIImage imageNamed:@"lixil_nav_bg"];
    [navView addSubview:bgImage];
    
    UIImage *buttonImage = [UIImage imageNamed:@"lixil_nav_back"];
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(35, 30, 81, 33);
    [backButton setImage:buttonImage forState:UIControlStateNormal];
    backButton.backgroundColor = [UIColor clearColor];
    [backButton addTarget:self action:@selector(backButtonEvent) forControlEvents:UIControlEventTouchUpInside];
    backButton.adjustsImageWhenHighlighted = NO;
    [navView addSubview:backButton];
    
#pragma mark -搜索相关-
    
    //添加透明罩视图点击事件
    _temp_ViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(navBgViewTapEvent1:)];
    _temp_ViewTap.numberOfTapsRequired = 1;
    _temp_ViewTap.numberOfTouchesRequired = 1;
    
    UITapGestureRecognizer *navTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(navBgViewTapEvent1:)];
    navTap.numberOfTapsRequired = 1;
    navTap.numberOfTouchesRequired = 1;
    [navView addGestureRecognizer:navTap];
    
    // 2.查询按钮
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchButton setImage:[UIImage imageNamed:@"home_search_btn"] forState:UIControlStateNormal];
    [searchButton setFrame:CGRectMake(5, 2, 34, 34)];
    [searchButton addTarget:self action:@selector(searchBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    // 3.查询输入框背景
    UIImageView *searchBgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_item_Search_BG"]];
    [searchBgView setFrame:CGRectMake(5, -2, 0, 42)];
    [searchBgView setTag:1000];
    
    // 4.查询输入框
    CustomTextField *searInputView = [[CustomTextField alloc] initWithFrame:CGRectMake(44, -1, 280, 42)];
    [searInputView setBorderStyle:UITextBorderStyleNone];
    [searInputView setTextColor:[UIColor whiteColor]];
    [searInputView setFont:[UIFont systemFontOfSize:14]];
    // searInputView.backgroundColor = [UIColor whiteColor];
    //[searInputView setClearsOnBeginEditing:YES];
    searInputView.returnKeyType = UIReturnKeySearch;
    searInputView.alpha = 0;
    
    searInputView.clearButtonMode = UITextFieldViewModeAlways;
    [searInputView setTag:1001];
    [searInputView setDelegate:self];
    [searInputView setUserInteractionEnabled:NO];
    
    // 2,3,4 控件的父视图
    self.searchModuleView  = [[UIView alloc] initWithFrame:CGRectMake(880, 25, 327,40)];
    // [serchModuleView setBackgroundColor:[UIColor greenColor]];
    [self.searchModuleView addSubview:searchBgView];
    [self.searchModuleView addSubview:searInputView];
    [self.searchModuleView addSubview:searchButton];
    
    [navView addSubview:self.searchModuleView];
    
#pragma mark -搜索相关-
    
    UIImage *settingImage = [UIImage imageNamed:@"lixil_nav_setting"];
    CGSize settingImageSize = settingImage.size;
    UIButton *settingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    settingButton.frame = CGRectMake(1024-settingImageSize.width/2, 0, settingImageSize.width/2, settingImageSize.height/2);
    [settingButton setImage:settingImage forState:UIControlStateNormal];
    settingButton.backgroundColor = [UIColor clearColor];
    [settingButton addTarget:self action:@selector(settingButtonEvent) forControlEvents:UIControlEventTouchUpInside];
    settingButton.adjustsImageWhenHighlighted = NO;
    [navView addSubview:settingButton];
}

-(void)navBgViewTapEvent1:(UITapGestureRecognizer *)sender
{
    if (_searchBtn)
    {
        [self searchBtnEvent:self.searchBtn];
    }
}

-(void)searchBtnEvent:(id)sender
{
    
    UIButton *btn = (UIButton *)sender;
    
    self.searchBtn = btn;
    
    UIView *searchView = [btn superview];
    
    UIImageView *searchBG = (UIImageView *)[searchView viewWithTag:1000];
    UITextField *inputText = (UITextField *)[searchView viewWithTag:1001];
    // inputText.backgroundColor = [UIColor whiteColor];
    inputText.placeholder =@"请输入关键字";
    
    
    if (btn.tag !=100)
    {
        //添加透明图层到子视图上
        UIView *tapView = [[UIView alloc] initWithFrame:CGRectMake(0, 85, 1024, 683)];
        [tapView setBackgroundColor:[UIColor blackColor]];
        tapView.alpha = 0.3;
        [tapView setTag:88];
        [self.view addSubview:tapView];
        [tapView addGestureRecognizer:_temp_ViewTap];
        
        [UIView animateWithDuration:0.6f animations:^{
            
            [searchView setCenter:CGPointMake(327/2+615, 20+25)];
            
            [searchBG setFrame:CGRectMake(2, -2, 327, 42)];
            
            //[inputText setFrame:CGRectMake(38, -2, 280, 42)];
            
            [inputText setAlpha:1];
            
        } completion:^(BOOL finished) {
            
            [inputText setUserInteractionEnabled:YES];
            [inputText becomeFirstResponder];
            
            [btn setTag:100];
            
        }];
    } else
    {
        
        // 删除透明罩视图
        UIView *tapView = [self.view viewWithTag:88];
        [tapView removeFromSuperview];
        
        UIView *searchView = [btn superview];
        [inputText resignFirstResponder];
        [inputText setText:@""];
        
        [UIView animateWithDuration:0.6f animations:^{
            
            [searchView setFrame:CGRectMake(880, 25, 327,40)];
            
            [searchBG setFrame:CGRectMake(5, -2, 0, 42)];
            
            // [inputText setFrame:CGRectMake(38, -2, 0, 42)];
            [inputText setAlpha:0];
            
        } completion:^(BOOL finished) {
            
            [btn setTag:0];
            self.searchBtn = nil;
            
        }];
        
    }
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSString *searchText = textField.text;
    
    if (searchText && searchText.length)
    {
        if ([self isKindOfClass:[LixilSearchViewController class]])
        {
            LixilSearchViewController *lsvc = (LixilSearchViewController *)self;
            lsvc.searchKeyWord = searchText;
            [lsvc reloadData];
        }
        else
        {
            LixilSearchViewController *lsvc = [[LixilSearchViewController alloc] initWithNibName:@"LixilSearchViewController" bundle:nil];
            lsvc.searchKeyWord = searchText;
            [self.navigationController pushViewController:lsvc animated:NO];
        }
    }
    
    [textField resignFirstResponder];
    [self navBgViewTapEvent1:nil];
    
    return YES;
}



- (void) backButtonEvent
{
    [self.navigationController popViewControllerAnimated:NO];
}

- (void) settingButtonEvent
{
    [LixilRightSettingBar showSettingBarInVC:self];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.view bringSubviewToFront:navView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
