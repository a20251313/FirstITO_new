//
//  ProductListBaseView.m
//  ShowCasePro
//
//  Created by yczx on 14-2-27.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "ProductListBaseView.h"
#import "RTFlyoutItem.h"


@interface ProductListBaseView ()

@end

@implementation ProductListBaseView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _leftMainItems = [NSMutableArray array];
        _leftSubItems = [NSMutableArray array];
        _rightMainItems = [NSMutableArray array];
        _rightSubItems = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // 绘制toolBar
    _ViewToolBarControl = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 1024, 44)];
    //[_ViewToolBarControl setBarStyle:UIBarStyleBlackTranslucent];
    [_ViewToolBarControl setBarTintColor:AS_DefatuleColor];

    
    // 绘制左边弹出菜单 UIbutton

    _leftMenuView = [[UIView alloc] initWithFrame:CGRectMake(0, 6, 40, 33)];
    
    //[_leftMenuView setBackgroundColor:[UIColor whiteColor]];
    
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithCustomView:_leftMenuView];
    
    
    // 绘制ViewContorller视图名称视图 (UIView + UIlabel)
    
    _ControllerTitleBGView = [[UIView alloc] initWithFrame:CGRectMake(60, 6, 140, 33)];
    _ViewControllerTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 3, 140, 33)];
    [_ViewControllerTitleLabel setTextColor:[UIColor whiteColor]];
    [_ViewControllerTitleLabel setFont:[UIFont boldSystemFontOfSize:19]];
    
    [_ControllerTitleBGView addSubview:_ViewControllerTitleLabel];
    //[_ControllerTitleBGView setBackgroundColor:[UIColor whiteColor]];
    
    UIBarButtonItem *titleBarItem = [[UIBarButtonItem alloc] initWithCustomView:_ControllerTitleBGView];
    
    
    
    // 绘制右边部分菜单下来菜单视图(UIView)
    
    _RightMenuView = [[UIView alloc] initWithFrame:CGRectMake(713, 6, 295, 33)];
   // [_RightMenuView setBackgroundColor:[UIColor whiteColor]];
    
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithCustomView:_RightMenuView];
    
    // 绘制SpaceItem
    UIBarButtonItem * spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    // 添加绘制的控件到ToolBar
    
    _ViewToolBarControl.items = [NSArray arrayWithObjects:leftBarItem,titleBarItem,spaceItem,rightBarItem, nil];
    
    [self.view addSubview:_ViewToolBarControl];

    
}




-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
   // 初始化左边菜单
    
    [self initRTFlayoutMenuToView:self.leftMenuView withTag:RTlyoutMenuMianTag WithColor:_suiteColor];
  
    // 初始化右边菜单
    [self initRTFlayoutMenuToView:self.RightMenuView withTag:RTlyoutMenuRightTag WithColor:_suiteColor];
 
   
}

-(void)initRTFlayoutMenuToView:(UIView *)view withTag:(int)tag WithColor:(UIColor *)color
{
    NSDictionary *options = @{
                              RTFlyoutMenuUIOptionInnerItemSize: [NSValue valueWithCGSize:CGSizeMake(22, 22)],
                              RTFlyoutMenuUIOptionSubItemPaddings: [NSValue valueWithUIEdgeInsets:UIEdgeInsetsMake(10, 15, 10, 15)]
                              };
    // 初始化左边菜单
	RTFlyoutMenu *m = [[RTFlyoutMenu alloc] initWithDelegate:self dataSource:self position:kRTFlyoutMenuPositionTop options:options withTag:tag withColor:color];
	m.canvasView = self.view;
    
    if (tag == RTlyoutMenuRightTag)
    {
        self.flyoutMenu = m;
    }
    
	CGRect mf = m.frame;
	CGRect cf = view.bounds;
    
	//	center menu in container view
	CGFloat newOriginX = (cf.size.width - mf.size.width) / 2;
	CGFloat newOriginY = (cf.size.height - mf.size.height) / 2;
	if (newOriginX > 0) mf.origin.x = newOriginX;
	if (newOriginY > 0) mf.origin.y = newOriginY;
	m.frame = mf;
    
    //	m.backgroundColor = [UIColor redColor];
	[view addSubview:m];
    
	//	look & feel
	[[RTFlyoutItem appearanceWhenContainedIn:[view class], nil] setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
	[[RTFlyoutItem appearanceWhenContainedIn:[view class], nil] setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
