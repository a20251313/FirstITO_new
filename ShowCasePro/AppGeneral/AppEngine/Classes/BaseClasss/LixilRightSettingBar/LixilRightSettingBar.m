//
//  LixilRightSettingBar.m
//  ShowCasePro
//
//  Created by yczx on 14-4-15.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "LixilRightSettingBar.h"
#import "ASDepthModalViewController.h"

#import "LixilFavouriteViewController.h"
#import "LixilDiyViewController.h"
#import "LixilShopCartViewController.h"
#import "LixilDimensionsViewController.h"
#import "LixilCalculateMuduleViewController.h"
#import "ASUserSetting.h"
#import "UserSettingViewController.h"
#import "LixilUserGuideViewController.h"

#define AnimationDuration 0.25

@interface LixilRightSettingBar()
{
    UIButton *bgButton;
}

@property (nonatomic , strong) UIViewController *vc;

@end


@implementation LixilRightSettingBar

//移出setting Bar
- (void) moveIn
{
    bgButton = [UIButton buttonWithType:UIButtonTypeCustom];
    bgButton.frame = self.vc.view.bounds;
    bgButton.backgroundColor = [UIColor clearColor];
    [bgButton addTarget:self action:@selector(hideSettingBar) forControlEvents:UIControlEventTouchUpInside];
    [self.vc.view addSubview:bgButton];
    
    [UIView animateWithDuration:AnimationDuration animations:^
    {
        CGRect frame = self.frame;
        frame.origin.x -= self.frame.size.width;
        self.frame = frame;
        
    } completion:^(BOOL finished)
     {
         [self.vc.view bringSubviewToFront:self];
    }];
}

//收回setting bar
- (void) moveOut
{
    [UIView animateWithDuration:AnimationDuration animations:^
     {
         CGRect frame = self.frame;
         frame.origin.x += self.frame.size.width;
         self.frame = frame;
         
     } completion:^(BOOL finished)
    {
        [bgButton removeFromSuperview];
        bgButton = nil;
        
        [self removeFromSuperview];
        self.vc = nil;
     }];
}

//首页
- (void) mainView
{
    [self hideSettingBar];
    
    [self.vc.navigationController popToRootViewControllerAnimated:NO];
}

//我的收藏
- (void) favourite
{
    [self hideSettingBar];
    
    if (![self.vc isKindOfClass:[LixilFavouriteViewController class]])
    {
        LixilFavouriteViewController *lfvc = [LixilFavouriteViewController new];
        [self.vc.navigationController pushViewController:lfvc animated:NO];
    }
}

//我的定制
- (void) diy
{
    [self hideSettingBar];
    
    if (![self.vc isKindOfClass:[LixilDiyViewController class]])
    {
        LixilDiyViewController *ldvc = [LixilDiyViewController new];
        [self.vc.navigationController pushViewController:ldvc animated:NO];
    }
}

//购物车
- (void) shopCart
{
    [self hideSettingBar];
    
    if (![self.vc isKindOfClass:[LixilShopCartViewController class]])
    {
        LixilShopCartViewController *lscvc = [LixilShopCartViewController new];
        [self.vc.navigationController pushViewController:lscvc animated:NO];
    }
}

//扫一扫
- (void) shaoyisao
{
    [self hideSettingBar];
    
    if (![self.vc isKindOfClass:[LixilDimensionsViewController class]])
    {
        LixilDimensionsViewController *ldvc = [LixilDimensionsViewController new];
        [self.vc.navigationController pushViewController:ldvc animated:NO];
    }
}

//计算器
- (void) jisuanqi
{
    [self hideSettingBar];
    
    if (![self.vc isKindOfClass:[LixilCalculateMuduleViewController class]])
    {
        LixilCalculateMuduleViewController *lcmvc = [LixilCalculateMuduleViewController new];
        [self.vc.navigationController pushViewController:lcmvc animated:NO];
    }
    
}

//用户设置
- (void) userSetting
{
    [self hideSettingBar];
    
    ASUserSetting *usvc = [ASUserSetting new];
    
    [ASDepthModalViewController presentView:usvc.view backgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5f] options:ASDepthModalOptionAnimationGrow | ASDepthModalOptionBlurNone | ASDepthModalOptionTapOutsideToClose completionHandler:nil];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController addChildViewController:usvc];
    
    usvc.view.layer.shadowColor = [UIColor blackColor].CGColor;
    usvc.view.layer.shadowOffset = CGSizeMake(0, 0);
    usvc.view.layer.shadowOpacity = 1;
    usvc.view.layer.shadowRadius = 10;
}

//app更新
- (void) appUpdate
{
    [self hideSettingBar];
    
    UserSettingViewController *usvc = [UserSettingViewController new];
    
    [ASDepthModalViewController presentView:usvc.view backgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5f] options:ASDepthModalOptionAnimationGrow | ASDepthModalOptionBlurNone | ASDepthModalOptionTapOutsideToClose completionHandler:nil];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController addChildViewController:usvc];
    
    usvc.view.layer.shadowColor = [UIColor blackColor].CGColor;
    usvc.view.layer.shadowOffset = CGSizeMake(0, 0);
    usvc.view.layer.shadowOpacity = 1;
    usvc.view.layer.shadowRadius = 10;
}

//使用指南
- (void) userGuide
{
    [self hideSettingBar];
    
    if (![self.vc isKindOfClass:[LixilUserGuideViewController class]])
    {
        LixilUserGuideViewController *lugvc = [LixilUserGuideViewController new];
        [self.vc.navigationController pushViewController:lugvc animated:NO];
    }
}


- (id)initWithFrame:(CGRect)frame
{
    UIImage *image = [UIImage imageNamed:@"lixil_setting_bar"];
    
    frame = CGRectMake(0, 0, image.size.width/2, image.size.height/2);
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
        imageView.image = image;
        [self addSubview:imageView];
        
        [self buttonWithHeight:38 andSEL:@selector(hideSettingBar)];//lixil
        [self buttonWithHeight:100 andSEL:@selector(mainView)];//首页
        [self buttonWithHeight:170 andSEL:@selector(favourite)];//我的收藏
        [self buttonWithHeight:240 andSEL:@selector(diy)];//我的定制
        [self buttonWithHeight:308 andSEL:@selector(shopCart)];//购物车
        [self buttonWithHeight:380 andSEL:@selector(shaoyisao)];//扫一扫
        [self buttonWithHeight:450 andSEL:@selector(jisuanqi)];//计算器
        [self buttonWithHeight:514 andSEL:@selector(userSetting)];//用户设置
        [self buttonWithHeight:590 andSEL:@selector(appUpdate)];//app更新
        [self buttonWithHeight:660 andSEL:@selector(userGuide)];//使用指南
    }
    return self;
}

+(void)showSettingBarInVC:(UIViewController *)vc
{
    if (!vc) {
        return;
    }
    
    LixilRightSettingBar *lrsb = [LixilRightSettingBar sharedInstance];
    lrsb.vc = vc;
    
    CGRect frame = lrsb.frame;
    frame.origin.x = vc.view.frame.size.width;
    lrsb.frame = frame;
    
    [vc.view addSubview:lrsb];
    
    [lrsb moveIn];
}

-(void)hideSettingBar
{
    [self moveOut];
}


+ (LixilRightSettingBar *) sharedInstance
{
    static LixilRightSettingBar *lrsb = nil;
    
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate,^
    {
        if (!lrsb)
        {
            lrsb = [LixilRightSettingBar new];
        }
    });
    
    return lrsb;
}


-(void)buttonWithHeight:(float)height andSEL:(SEL)sel
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 50, 60);
    button.center = CGPointMake(33, height);
    button.backgroundColor = [UIColor clearColor];
    [button addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
}

@end
