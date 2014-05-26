//
//  AppDelegate.m
//  ShowCasePro
//
//  Created by yczx on 13-11-22.
//  Copyright (c) 2013年 yczx. All rights reserved.
//

#import "AppDelegate.h"
#import <MAMapKit/MAMapKit.h>
#import "LaunchViewController.h"
#import "MacroDefine.h"
#import "LibraryAPI.h"
#import "DatabaseOption.h"

@implementation AppDelegate

- (void)configureAPIKey
{
    //在高德api网站上申请的key 应用名称是美标 申请账号是sh_cysoft 密码是cysoft13305
    [MAMapServices sharedServices].apiKey = @"3ecb6f0b12fff18df180336fc016b190";
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //配置高德地图apikey
    [self configureAPIKey];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    //进入启动界面
    LaunchViewController *lvc = [[LaunchViewController alloc] init];
    lvc.showLoadingView = YES;
    self.window.rootViewController = lvc;
    [self.window makeKeyAndVisible];
    
    //输出library路径
    NSLog(@"%@", kLibrary);
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
