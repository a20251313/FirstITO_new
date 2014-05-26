//
//  ProductListBaseView.h
//  ShowCasePro
//
//  Created by yczx on 14-2-27.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "BaseViewController.h"
#import "RTFlyoutMenu.h"

#define RTlyoutMenuMianTag   1
#define RTlyoutMenuRightTag   2


@interface ProductListBaseView : BaseViewController< RTFlyoutMenuDelegate, RTFlyoutMenuDataSource >

// 顶部toolBar
@property (strong, nonatomic) UIToolbar *ViewToolBarControl;


// 弹出式菜单视图背景
@property (strong, nonatomic) UIView *leftMenuView;

// 显示当前ViewController背景视图名称
@property (strong, nonatomic) UIView *ControllerTitleBGView;


// 显示当前ViewController名称
@property (strong, nonatomic) UILabel *ViewControllerTitleLabel;


// 右边菜单背景View
@property (strong, nonatomic) UIView *RightMenuView;


@property (strong, nonatomic) RTFlyoutMenu *flyoutMenu;

// 左边下来菜单列表
@property (nonatomic,strong) NSMutableArray *leftMainItems;
@property (nonatomic,strong) NSMutableArray *leftSubItems;


// 右边下来菜单列表
@property (nonatomic,strong) NSMutableArray *rightMainItems;
@property (nonatomic,strong) NSMutableArray *rightSubItems;

@property(nonatomic,assign) UIColor * suiteColor;



-(void)initRTFlayoutMenuToView:(UIView *)view withTag:(int)tag WithColor:(UIColor *)color;

@end
