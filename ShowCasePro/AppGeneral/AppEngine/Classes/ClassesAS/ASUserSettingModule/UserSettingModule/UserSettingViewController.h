//
//  UserSettingViewController.h
//  ShowCasePro
//
//  Created by yczx on 13-11-25.
//  Copyright (c) 2013年 yczx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ASINetworkQueue.h>
#import <ASIHTTPRequest.h>
#import "BaseViewController.h"

@interface UserSettingViewController : BaseViewController<ASIHTTPRequestDelegate>

// 同步按钮点击事件
- (IBAction)product_SycnBtnEvent:(id)sender;
- (IBAction)exit:(id)sender;
- (IBAction)clearDataBase:(id)sender;

@end
