//
//  LaunchViewController.m
//  ShowCasePro
//
//  Created by CY-003 on 13-12-18.
//  Copyright (c) 2013年 yczx. All rights reserved.
//

#import "LaunchViewController.h"
#import "AppDelegate.h"
#import "UserLoginViewController.h"
#import "DatabaseOption+UserLogin.h"

#import "LixilHomePage.h"


#import <MediaPlayer/MediaPlayer.h>

@interface LaunchViewController ()

@property (strong , nonatomic) DatabaseOption *dbo;

@property(nonatomic,strong)MPMoviePlayerController *mMoviePlayer;

@end

@implementation LaunchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.dbo = [DatabaseOption new];
    
    
    //如果需要播放启动视频 则播放  否则直接判断是否登陆
    if (self.showLoadingView)
    {
        NSURL *moiveUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"lixil" ofType:@"mp4"]];
        
        MPMoviePlayerController *palyer = [[MPMoviePlayerController alloc] initWithContentURL:moiveUrl];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(moviePlayBackDidFinish)
                                                     name:MPMoviePlayerPlaybackDidFinishNotification
                                                   object:_mMoviePlayer];
        palyer.controlStyle = MPMovieControlStyleNone;
        palyer.view.frame = CGRectMake(0, 0, 1024, 768);
        [self.view addSubview:palyer.view];
        [palyer setFullscreen:YES animated:YES];
        self.mMoviePlayer = palyer;
        
        palyer.backgroundView.backgroundColor = [UIColor colorWithRed:250.0/255 green:251.0/255 blue:250.0/255 alpha:1];
        [palyer play];
    }
    else
    {
        [self verifyIfLogin];
    }
    
    self.view.backgroundColor = [UIColor colorWithRed:250.0/255 green:251.0/255 blue:250.0/255 alpha:1];
}

//视频播放完成后 验证是否登陆
-(void)moviePlayBackDidFinish
{
    [UIView animateWithDuration:1.f animations:^
     {
         self.mMoviePlayer.view.frame = CGRectMake(0, -768, 1024, 768);
         
     } completion:^(BOOL finished)
     {
         [self.mMoviePlayer.view removeFromSuperview];
         self.mMoviePlayer = nil;
         
         [self verifyIfLogin];
     }];
}

- (void) verifyIfLogin
{
    //如果已经登陆 直接跳转到首页 否则到登陆界面
    if ([self.dbo ifLogin])
    {
        [self pushToHomepage];
    }
    else
    {
        UserLoginViewController *ulvc = [[UserLoginViewController alloc] init];
        [self addChildViewController:ulvc];
        [self.view addSubview:ulvc.view];
    }
}

-(void)pushToHomepageWithDelay:(float)delay
{
    [self performSelector:@selector(pushToHomepage) withObject:nil afterDelay:delay];
}

- (void) pushToHomepage
{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    //跳转到集团首页
    LixilHomePage *homePage = [[LixilHomePage alloc] init];
    UINavigationController *nav_mainView = [[UINavigationController alloc] initWithRootViewController:homePage];
    appDelegate.window.rootViewController = nav_mainView;
}


@end
