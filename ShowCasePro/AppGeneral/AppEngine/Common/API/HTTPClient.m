//
//  HTTPClient.m
//  ShowCasePro
//
//  Created by lvpw on 14-1-3.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "HTTPClient.h"
#import <ASIHTTPRequest.h>
#import <MBProgressHUD.h>
#import "Category.h"
#import "MacroDefine.h"
#import "AppConfig.h"
#include <ifaddrs.h>
#include <arpa/inet.h>

@interface HTTPClient () <ASIHTTPRequestDelegate, ASIProgressDelegate>

@property (strong, nonatomic) ASIHTTPRequest *request;
@property (strong, nonatomic) MBProgressHUD *HUD;
@property UInt64 totalCount;

@end

@implementation HTTPClient

#pragma mark - ASIProgressDelegate

- (void)setProgress:(float)newProgress{
    self.HUD.progress = newProgress;
    self.HUD.labelText = [NSString stringWithFormat:@"正在下载视频 进度：%.2f M/ %.2f M", _totalCount * newProgress/(1024*1024.), _totalCount/(1024*1024.)];
}

#pragma mark - ASIHTTPRequestDelegate

- (void)request:(ASIHTTPRequest *)request didReceiveResponseHeaders:(NSDictionary *)responseHeaders
{
    self.totalCount = [[responseHeaders objectForKey:@"Content-Length"] intValue];
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    UIImage *image = [UIImage imageNamed:@"37x-Checkmark"];
    self.HUD.customView = [[UIImageView alloc] initWithImage:image];
    self.HUD.mode = MBProgressHUDModeCustomView;
    self.HUD.labelText = @"下载视频完成";
    [self.HUD hide:YES afterDelay:2];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    self.HUD.mode = MBProgressHUDModeText;
    self.HUD.labelText = @"下载视频失败";
    [self.HUD hide:YES afterDelay:2];
    [[NSFileManager defaultManager] removeItemAtPath:[request.userInfo objectForKey:@"url"] error:nil];
    NSLog(@"%@", [request.error description]);
}

- (NSString *)downVideoByLink:(NSString *)link inView:(UIView *)view
{
    NSString *url_Client = [kLibrary stringByAppendingFormat:@"/%@", link];
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:url_Client];
    // 不存在此视频
    if (!fileExists) {
        [UIAlertView showWithTitle:@"文件不存在" message:@"是否下载？" cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
            if (buttonIndex == 1) {
                NSString *remoteURL = [SERVER_PRO_PATH stringByAppendingString:link];
                
                // 创建文件
                [[NSFileManager defaultManager]createDirectoryAtPath:[url_Client stringByDeletingLastPathComponent] withIntermediateDirectories:YES attributes:nil error:nil];
                // 创建临时文件夹
                if (![[[NSFileManager alloc] init] fileExistsAtPath:kTemp]) {
                    [[NSFileManager defaultManager] createDirectoryAtPath:kTemp withIntermediateDirectories:YES attributes:nil error:nil];
                }
                self.request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:remoteURL]];
                // 初始化request
//                NSString *tempURL = [[url_Client lastPathComponent] stringByAppendingString:@"temp"];
                NSString *tempURL = [kTemp stringByAppendingFormat:@"/%@", [link lastPathComponent]];
                [self.request setTemporaryFileDownloadPath:tempURL];
                [self.request setDownloadDestinationPath:url_Client];
                [self.request setDownloadProgressDelegate:self];
                self.request.delegate = self;
                [self.request setUserInfo:@{@"url":url_Client}];
                [self.request setAllowResumeForFileDownloads:YES];
                [self.request startAsynchronous];
                // 初始化hud
                self.HUD = [[MBProgressHUD alloc] initWithView:view];
                [view addSubview:self.HUD];
                self.HUD.mode = MBProgressHUDModeDeterminateHorizontalBar;
                self.HUD.labelText = @"开始下载视频...";
                [self.HUD show:YES];
            }
        }];
        return nil;
    }
    return url_Client;
}

- (NSString *)getIPAddress
{
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while (temp_addr != NULL) {
            if( temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    
    // Free memory
    freeifaddrs(interfaces);
    
    return address;
}

@end
