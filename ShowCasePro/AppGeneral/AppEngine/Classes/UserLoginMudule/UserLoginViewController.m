//
//  UserLoginViewController.m
//  ShowCasePro
//
//  Created by CY-003 on 13-12-18.
//  Copyright (c) 2013年 yczx. All rights reserved.
//

#import "UserLoginViewController.h"
#import "LaunchViewController.h"
#import "DatabaseOption+UserLogin.h"
#import "LibraryAPI.h"
#import <CommonCrypto/CommonDigest.h>
#import "UserSettingViewController.h"
#import "ASDepthModalViewController.h"


@interface UserLoginViewController ()<UITextFieldDelegate,UIAlertViewDelegate>
{
    
    __weak IBOutlet UIImageView *userIcon;
    
    
    __weak IBOutlet UITextField *username;
    __weak IBOutlet UITextField *password;
    
    
    __weak IBOutlet UIButton *autoLoginButton;
    
    BOOL autoLogin;
    
}

@property (nonatomic,strong) DatabaseOption *dbo;

@end

@implementation UserLoginViewController


- (IBAction)login:(id)sender
{
    if (!username.text || !username.text.length || !password.text || !password.text.length) {
        
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"错误提示" message:@"账号或密码不能为空!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [av show];
        return;
    }
    
    LaunchViewController *lvc = (LaunchViewController *)self.parentViewController;
    
    //验证是否登陆成功 失败则返回nil
    Admin *admin = [self.dbo ifLoginSuccessWithUsername:username.text password:[self md5:password.text]];
    
    if (admin)
    {
        //如果自动登陆开启  则将admin对象存在本地
        if (autoLogin)
        {
            [[LibraryAPI sharedInstance] setLocalValue:[admin dictionary] key:UserObject];
        }
        // 将登录信息保存在Library中
        [LibraryAPI sharedInstance].currentUser = admin;
        
        //延迟0.3秒再进入首页
        [[LibraryAPI sharedInstance] addActivityIndicatorToView:self.view];
        [lvc pushToHomepageWithDelay:0.3];
        [[LibraryAPI sharedInstance] removeActivityIndicatorFromSuperview];
    }
    else
    {
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"错误提示"
                                                     message:@"账号或密码错误!"
                                                    delegate:nil
                                           cancelButtonTitle:@"确定"
                                           otherButtonTitles:nil];
        [av show];
    }
    
}

#pragma mark - view did appear-

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //如果是第一次登陆  提示用户同步数据
    if ([self.dbo firstLogin])
    {
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:nil
                                                     message:@"请同步数据后再使用"
                                                    delegate:self
                                           cancelButtonTitle:@"取消"
                                           otherButtonTitles:@"同步", nil];
        [av show];
    }
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //用户按下同步后开始同步数据
    switch (buttonIndex) {
        case 1:
        {
            //同步数据
//            UIViewController *viewController = [[UserSettingViewController alloc] initWithNibName:@"UserSettingViewController" bundle:nil];
//            [ASDepthModalViewController presentView:viewController.view backgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5f] options:ASDepthModalOptionAnimationGrow | ASDepthModalOptionBlurNone | ASDepthModalOptionTapOutsideToClose completionHandler:nil];
//            
//            [[UIApplication sharedApplication].keyWindow.rootViewController addChildViewController:viewController];
//            
//            viewController.view.layer.shadowColor = [UIColor blackColor].CGColor;
//            viewController.view.layer.shadowOffset = CGSizeMake(0, 0);
//            viewController.view.layer.shadowOpacity = 1;
//            viewController.view.layer.shadowRadius = 10;
        }
            break;
            
        default:
            break;
    }
}

#pragma mark -

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    autoLogin = false;
    
    username.delegate = self;
    password.delegate = self;
    
    self.dbo = [DatabaseOption new];
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0)
    {
        CGRect frame = self.view.frame;
        frame.size.height = self.view.frame.size.height + 20;
        self.view.frame = frame;
    }
    
}

- (NSString *) md5: (NSString *) inPutText
{
    const char *cStr = [inPutText UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, strlen(cStr), result);
    
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}

- (IBAction)autoLogin:(UIButton *)sender
{
    if (autoLogin)
    {
        autoLogin = false;
        
        [autoLoginButton setImage:[UIImage imageNamed:@"ul_autologinno"] forState:UIControlStateNormal];
    }
    else
    {
        autoLogin = true;
        
        [autoLoginButton setImage:[UIImage imageNamed:@"ul_autologinyes"] forState:UIControlStateNormal];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}

@end














