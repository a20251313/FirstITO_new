//
//  LixilHomePage.m
//  LixilHomePageDemo
//
//  Created by Mac on 14-2-22.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import "LixilHomePage.h"
#import "CoverButtonLixil.h"
#import "LibraryAPI.h"
#import "CustomNavigationController.h"
#import "AppConfig.h"

// 美标首页
#import "MainMenuViewController.h"
// lixil集团首页
#import "LixilGroupMainMenuView.h"
// 伊奈首页
#import "InaxMainMenuViewController.h"
//骊住玄关门首页
#import "LixilWoodenViewController.h"
//铝合金门窗首页
#import "SashMainMenuModuleViewController.h"
//伊康家首页
#import "EcocaratMainMenuModuleViewController.h"


#import "LixilRightSettingBar.h"

#define AnimationDuration 0.6

@interface LixilHomePage ()
{
    CoverButtonLixil *lixilButton;
    OBShapedButton *lixilIntro;
    CoverButton *asButton;
    CoverButton *inaxButton;
}

@end

@implementation LixilHomePage






#pragma mark - button action -

-(void) settingButtonTouched
{
    [LixilRightSettingBar showSettingBarInVC:self];
}


-(void) lixilIntroButtonEvent
{
    //进入集团介绍
    [[LibraryAPI sharedInstance] setCurrentBrandID:Brand_LixlGroup];
    
    LixilGroupMainMenuView *lgmmv =  [[LixilGroupMainMenuView alloc] initWithNibName:@"LixilGroupMainMenuView" bundle:nil];
    
    [self.navigationController pushViewController:lgmmv animated:NO];
}

#pragma mark - view appear -

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    //每次进入此页面时候把品牌的id给设置为0,主要是针对用户指南换图片
    [[LibraryAPI sharedInstance] setCurrentBrandID:@"0"];
    
    
    static dispatch_once_t onceStart ;
    
    dispatch_once(&onceStart,^{
        
        [lixilButton fadeInWithDuration:0];
        
        [UIView animateWithDuration:0.5 animations:^
         {
             CGRect frame = lixilButton.frame;
             frame.origin.x += lixilButton.frame.size.width;
             lixilButton.frame = frame;
             
             frame = lixilIntro.frame;
             frame.origin.x -= lixilIntro.frame.size.width;
             lixilIntro.frame = frame;
         }
                         completion:^(BOOL finished)
         {
             [asButton fadeInWithDuration:0.5];
             [inaxButton fadeInWithDuration:0.5];
         }];
        
        
    });

}


-(void)viewDidDisappear:(BOOL)animated
{
    [lixilButton resetPosition];
    [asButton resetPosition];
    [inaxButton resetPosition];
    [super viewDidDisappear:animated];
}

#pragma mark - life cycle -

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.view.frame = CGRectMake(0, 0, 1024, 768);
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //骊住按钮
    lixilButton = [CoverButtonLixil ButtonWithBgImageNameArray:@[@"hp_lixil_bg1",
                                                                                   @"hp_lixil_bg2",
                                                                                   @"hp_lixil_bg3"]
                                                            buttonImageNameArray:@[@"hp_lixil_cover1",
                                                                                   @"hp_lixil_cover2",
                                                                                   @"hp_lixil_cover3"]
                                                                  coverImageName:@"hp_lixil_cover"
                                                                    buttonBlock1:^
    {
        //进入玄关门首页
        [[LibraryAPI sharedInstance] setCurrentBrandID:Brand_Lixil_Wooden];
        
        LixilWoodenViewController *lwvc = [LixilWoodenViewController new];
        [self.navigationController pushViewController:lwvc animated:NO];
        
    }
                                                                    buttonBlock2:^
    {
        //进入铝合金门窗首页
        [[LibraryAPI sharedInstance] setCurrentBrandID:Brand_Lixil_Sash];
        
        SashMainMenuModuleViewController *smmmvc = [SashMainMenuModuleViewController new];
        [self.navigationController pushViewController:smmmvc animated:NO];
    }
                                                                    buttonBlock3:^
    {
        //进入伊康佳首页
        [[LibraryAPI sharedInstance] setCurrentBrandID:Brand_Lixil_Ecocarat];
        
        EcocaratMainMenuModuleViewController *emmmvc = [EcocaratMainMenuModuleViewController new];
        [self.navigationController pushViewController:emmmvc animated:NO];
        
    }
                                                                       moveDelta:CGPointMake(-1000, 0)
                                                                        duration:AnimationDuration];
    [self.view addSubview:lixilButton];

    CGRect buttonFrame = lixilButton.frame;
    buttonFrame.origin.x -= lixilButton.frame.size.width;
    lixilButton.frame = buttonFrame;
    
    //集团介绍按钮
    UIImage *introImage = [UIImage imageNamed:@"hp_lixil_intro"];
    lixilIntro = [OBShapedButton buttonWithType:UIButtonTypeCustom];
    lixilIntro.frame = CGRectMake(1024, 20, introImage.size.width/2, introImage.size.height/2);
    lixilIntro.adjustsImageWhenHighlighted = NO;
    [lixilIntro setImage:introImage forState:UIControlStateNormal];
    [lixilIntro addTarget:self action:@selector(lixilIntroButtonEvent) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:lixilIntro];
    
    //美标按钮
    asButton = [CoverButton ButtonwithPoint:CGPointMake(25, 0)
                                             bgImageName:@"hp_as_bg"
                                         buttonImageName:@"hp_as_cover"
                                             buttonBlock:^{
                                                 //进入美标首页
                                                [[LibraryAPI sharedInstance] setCurrentBrandID:Brand_AS];
                                                 
                                                MainMenuViewController *mmvc =  [[MainMenuViewController alloc] initWithNibName:@"MainMenuViewController" bundle:nil];
                                                mmvc.hideBackBtn=YES;
                                    
                                                 
                                                [self.navigationController pushViewController:mmvc animated:NO];
                                                 
                                             }
                                               moveDelta:CGPointMake(0, -1000)
                                                duration:AnimationDuration
                                               superView:self.view];
    [asButton fadeOutWithDuration:0];
    
    //伊奈按钮
    inaxButton = [CoverButton ButtonwithPoint:CGPointMake(55, 485)
                                             bgImageName:@"hp_inax_bg"
                                         buttonImageName:@"hp_inax_cover"
                                               buttonBlock:^{
                                                   //进入伊奈首页
                                                   [[LibraryAPI sharedInstance] setCurrentBrandID:Brand_Inax];
                                                   
                                                   InaxMainMenuViewController *immvc =  [InaxMainMenuViewController new];
                                                                                         [self.navigationController pushViewController:immvc animated:NO];
                                               }
                                               moveDelta:CGPointMake(0, 1300)
                                                duration:AnimationDuration
                                               superView:self.view];
    [inaxButton fadeOutWithDuration:0];
    
    
    //右上角设置按钮
    UIButton *settingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    settingButton.frame = CGRectMake(1024-60, 0, 60, 60);
    settingButton.adjustsImageWhenHighlighted = NO;
    [settingButton setImage:[UIImage imageNamed:@"lixilGroup_setting"] forState:UIControlStateNormal];
    [settingButton addTarget:self action:@selector(settingButtonTouched) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:settingButton];

    
    self.view.backgroundColor = [UIColor colorWithRed:250.0/255 green:251.0/255 blue:250.0/255 alpha:1];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
