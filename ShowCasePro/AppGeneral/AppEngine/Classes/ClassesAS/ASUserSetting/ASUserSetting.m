//
//  ASUserSetting.m
//  ShowCasePro
//
//  Created by Mac on 14-3-4.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "ASUserSetting.h"
#import "LaunchViewController.h"

#define ComfirmAlertViewTag     234645275
#define DidLogoutAlertViewTag   687435473

@interface ASUserSetting ()<UIAlertViewDelegate>
{
    IBOutlet UIImageView *userIcon;
    IBOutlet UIImageView *bgImageView;
    IBOutlet UIButton *logoutButton;
}

@property (weak, nonatomic) IBOutlet UIImageView *userAvator;

@end

@implementation ASUserSetting

- (IBAction)changeUserAvator:(id)sender
{
    
}


- (IBAction)changePassword:(id)sender
{
    
}


- (IBAction)aboutUs:(id)sender
{
    
}


- (IBAction)userLogout:(id)sender
{
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:nil
                                                 message:@"确定注销?"
                                                delegate:self
                                       cancelButtonTitle:@"取消"
                                       otherButtonTitles:@"确定", nil];
    
    av.tag = ComfirmAlertViewTag;
    [av show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //确定注销？
    if (alertView.tag == ComfirmAlertViewTag)
    {
        if (buttonIndex == 1)
        {
            [[LibraryAPI sharedInstance] setLocalValue:nil key:UserObject];
            
            [LibraryAPI sharedInstance].currentUser = nil;
            
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:nil
                                                         message:@"注销成功"
                                                        delegate:self
                                               cancelButtonTitle:@"确定"
                                               otherButtonTitles:nil];
            av.tag = DidLogoutAlertViewTag;
            [av show];
        }
    }
    //已经注销
    else if (alertView.tag == DidLogoutAlertViewTag)
    {
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        
        //跳转到登陆界面
        LaunchViewController *lvc = [[LaunchViewController alloc] init];
        lvc.showLoadingView = NO;
        appDelegate.window.rootViewController = lvc;

    }
}




- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //取出当前的用户头像
    //self.userAvator.image = nil;
    
    //根据品牌不同设置不同背景
    if ((![[LibraryAPI sharedInstance].currentBrandID isEqualToString:@"2"])&&(![[LibraryAPI sharedInstance].currentBrandID isEqualToString:@"3"])) //lixil
    {
        bgImageView.image = [UIImage imageNamed:@"lixil_us_bg"];
        userIcon.image = [UIImage imageNamed:@"lixil_us_icon"];
        [logoutButton setImage:[UIImage imageNamed:@"lixil_us_logout"] forState:UIControlStateNormal];
    }
    else if ([[LibraryAPI sharedInstance].currentBrandID isEqualToString:@"3"]) //inax
    {
        bgImageView.image = [UIImage imageNamed:@"lixil_us_bg"];
        userIcon.image = [UIImage imageNamed:@"inax_us_icon"];
        [logoutButton setImage:[UIImage imageNamed:@"inax_us_logout"] forState:UIControlStateNormal];
    }
    else
    {
        
    }
    
}


@end
