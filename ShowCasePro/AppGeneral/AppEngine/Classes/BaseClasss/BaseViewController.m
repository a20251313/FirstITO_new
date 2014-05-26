//
//  BaseViewController.m
//  ShowCasePro
//
//  Created by yczx on 13-11-22.
//  Copyright (c) 2013年 yczx. All rights reserved.
//

#import "BaseViewController.h"
#import "ASMenuViewController.h"
#import "LibraryAPI.h"
#import "CustomTextField.h"
#import "AppConfig.h"
#import "ASDepthModalViewController.h"
#import "ASProductListViewController.h"

@interface BaseViewController () <UIPopoverControllerDelegate, ASMenuViewControllerDelegate,UITextFieldDelegate>

@property (nonatomic, strong) ASMenuViewController *menuviewControllerBase;


@property (nonatomic, strong) UIButton *searchBtn;

@property (nonatomic, strong) UITapGestureRecognizer *temp_ViewTap;


@end

@implementation BaseViewController

#pragma mark - ASMenuViewControllerDelegate

- (void)asMenuViewControllerDidSelectedViewControllerName:(NSString *)viewControllerName
{
    //    NSLog(@"viewControllerName:>>%@ ---", viewControllerName);
    
    if (viewControllerName != nil && ![viewControllerName isEqualToString:@""]) {
        UIViewController *viewController = [[NSClassFromString(viewControllerName) alloc] initWithNibName:viewControllerName bundle:nil];
        [self.popoverController1Base dismissPopoverAnimated:NO];
        if ([viewControllerName isEqualToString:@"UserSettingViewController"] || [viewControllerName isEqualToString:@"ASUserSetting"]) {
            [ASDepthModalViewController presentView:viewController.view backgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5f] options:ASDepthModalOptionAnimationGrow | ASDepthModalOptionBlurNone | ASDepthModalOptionTapOutsideToClose completionHandler:nil];
            
            [[UIApplication sharedApplication].keyWindow.rootViewController addChildViewController:viewController];
            
            viewController.view.layer.shadowColor = [UIColor blackColor].CGColor;
            viewController.view.layer.shadowOffset = CGSizeMake(0, 0);
            viewController.view.layer.shadowOpacity = 1;
            viewController.view.layer.shadowRadius = 10;
            
        } else {
            [self.navigationController pushViewController:viewController animated:NO];
        }
    
    
    }
}

#pragma mark - UIPopoverControllerDelegate

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    [popoverController dismissPopoverAnimated:YES];
}

#pragma mark - Life Cycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _hideBackBtn = NO;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
  
    [self initBaseViewForAS];

}

// 初始化为AS根视图
-(void)initBaseViewForAS
{
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.translucent = NO;
    // leftButton
    
    UIButton *aslogo = [UIButton buttonWithType:UIButtonTypeCustom];
    [aslogo setImage:[UIImage imageNamed:@"brand_2_h"] forState:UIControlStateNormal];
    [aslogo setFrame:CGRectMake(0, 16, 230, 34)];
    [aslogo addTarget:self action:@selector(backToHomeBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIView *leftItemBGView  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1004,64)];
    // [leftItemBGView setBackgroundColor:[UIColor greenColor]];
    [leftItemBGView addSubview:aslogo];
    
    //添加View点击事件
    UITapGestureRecognizer *navBar_Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(navBgViewTapEvent:)];
    navBar_Tap.numberOfTapsRequired = 1;
    navBar_Tap.numberOfTouchesRequired = 1;
    [leftItemBGView addGestureRecognizer:navBar_Tap];
    
    
    //添加透明罩视图点击事件
    _temp_ViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(navBgViewTapEvent1:)];
    _temp_ViewTap.numberOfTapsRequired = 1;
    _temp_ViewTap.numberOfTouchesRequired = 1;
    
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:leftItemBGView];
    self.navigationItem.leftBarButtonItem = backButton;
    
    //增加波光效果
    UIImageView *sunShan_line  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_Item_light"]];
    
    sunShan_line.frame = CGRectMake(1024, -8, 223, 73);
    [leftItemBGView addSubview:sunShan_line];
    
    if ([[LibraryAPI sharedInstance] getLocalBool:@"homeAnimation"])
    {
        [[LibraryAPI sharedInstance] setLocalBool:NO key:@"homeAnimation"];
        [UIView animateWithDuration:2.0f animations:^{
            
            sunShan_line.frame = CGRectMake(-35, -8, 223, 73);
            
        } completion:^(BOOL finished) {
            
        }];
        
    } else
    {
        sunShan_line.frame = CGRectMake(-35, -8, 223, 73);
    }
    
    //    // topButton
    //    UIImageView *topImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"brand_2_h"]];
    //    topImageView.frame = CGRectMake(0, 0, 218, 40);
    //   // self.navigationItem.titleView = topImageView;
    //    self.navigationController.navigationBar.tintColor = [UIColor grayColor];
    
    //    UIImageView *rightImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"usericon"]];
    // rightButton
    // UIBarButtonItem *userIConButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"usericon"] style:UIBarButtonItemStylePlain target:self  action:@selector(userIconAction:)];
    
    // 1.用户Ico
    UIButton *userIConButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [userIConButton setImage:[UIImage imageNamed:@"home_user_btn"] forState:UIControlStateNormal];
    [userIConButton setFrame:CGRectMake(180, 4, 30, 30)];
    [userIConButton addTarget:self action:@selector(userIconAction:) forControlEvents:UIControlEventTouchUpInside];
    
    // 2.查询按钮
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchButton setImage:[UIImage imageNamed:@"home_search_btn"] forState:UIControlStateNormal];
    [searchButton setFrame:CGRectMake(5, 2, 34, 34)];
    [searchButton addTarget:self action:@selector(searchBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    // 3.查询输入框背景
    UIImageView *searchBgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_item_Search_BG"]];
    [searchBgView setFrame:CGRectMake(2, -2, 2, 42)];
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
    UIView *serchModuleView  = [[UIView alloc] initWithFrame:CGRectMake(230, 0, 327,40)];
    // [serchModuleView setBackgroundColor:[UIColor greenColor]];
    [serchModuleView addSubview:searchBgView];
    [serchModuleView addSubview:searInputView];
    [serchModuleView addSubview:searchButton];
    
    // 自定义rightBarButtonItem 视图
    UIView *btnView  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 327,40)];
    // [btnView setBackgroundColor:[UIColor redColor]];
    // 添加返回按钮 add 0218
    
    if (!_hideBackBtn)
    {
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        //[backBtn setImage:[UIImage imageNamed:@"home_back_btn"] forState:UIControlStateNormal];
        //[backBtn setFrame:CGRectMake(120, 10, 23, 20)];
        [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [backBtn setFrame:CGRectMake(126, 5, 35, 30)];
        
        [backBtn addTarget:self action:@selector(backBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
        [btnView addSubview:backBtn];
    }
    
    [btnView addSubview:userIConButton];
    [btnView addSubview:serchModuleView];
    
    
    UIBarButtonItem *rightBtnItem = [[UIBarButtonItem alloc] initWithCustomView:btnView];
    self.navigationItem.rightBarButtonItem = rightBtnItem;
    
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)navBgViewTapEvent:(UITapGestureRecognizer *)sender
{
    if (_searchBtn)
    {
     [self searchBtnEvent:self.searchBtn];
    }
}

-(void)navBgViewTapEvent1:(UITapGestureRecognizer *)sender
{
    if (_searchBtn)
    {
        [self searchBtnEvent:self.searchBtn];
    }
}

#pragma mark - Handle Action

- (void)backToHomeBtnEvent:(id)sender {
//    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController popToRootViewControllerAnimated:NO];
}


- (void)backBtnEvent:(id)sender {
    
    [self.navigationController popViewControllerAnimated:NO];
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
       UIView *tapView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
       [tapView setBackgroundColor:[UIColor blackColor]];
       tapView.alpha = 0.3;
       [tapView setTag:88];
       [self.view addSubview:tapView];
       [tapView addGestureRecognizer:_temp_ViewTap];
       
    [UIView animateWithDuration:0.6f animations:^{
       
        [searchView setCenter:CGPointMake(327/2, 20)];
        
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
           
           [searchView setFrame:CGRectMake(230, 0, 327,40)];
           
           [searchBG setFrame:CGRectMake(5, -2, 0, 42)];
           
          // [inputText setFrame:CGRectMake(38, -2, 0, 42)];
            [inputText setAlpha:0];
           
       } completion:^(BOOL finished) {
           
           [btn setTag:0];
           self.searchBtn = nil;
           
       }];

   }
    
}


- (void)userIconAction:(id)sender
{
    if (self.menuviewControllerBase == nil) {
        self.menuviewControllerBase = [[ASMenuViewController alloc] initWithNibName:@"ASMenuViewController" bundle:nil];
        self.menuviewControllerBase.delegate = self;
    }
    if (self.popoverController1Base == nil) {
        UIPopoverController *popoverController = [[UIPopoverController alloc] initWithContentViewController:self.menuviewControllerBase];
        popoverController.popoverContentSize = self.menuviewControllerBase.view.frame.size;
        popoverController.backgroundColor = [UIColor colorWithRed:64/255. green:64/255. blue:64/255. alpha:1];
        popoverController.delegate = self;
        self.popoverController1Base = popoverController;
    }
    CGPoint endOrigin = ((UIButton *)sender).frame.origin;
    endOrigin = [((UIButton *)sender).superview convertPoint:endOrigin toView:self.navigationController.topViewController.view];
    CGRect endFrame = ((UIButton *)sender).frame;
    endFrame.origin = endOrigin;
    [self.popoverController1Base presentPopoverFromRect:endFrame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
//    [self.popoverController1Base presentPopoverFromBarButtonItem:self.navigationItem.rightBarButtonItem permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSString *searchText = textField.text;
    
    if (searchText && searchText.length)
    {
        ASProductListViewController *asproductListViewController = [[ASProductListViewController alloc] initWithNibName:@"ASProductListViewController" bundle:nil];
        asproductListViewController->_asProductListType = SearchType;
        asproductListViewController.value = searchText;
        
        [self.navigationController pushViewController:asproductListViewController animated:NO];
    }
    
    [textField resignFirstResponder];
    [self navBgViewTapEvent:nil];
    
    return YES;
}

@end
