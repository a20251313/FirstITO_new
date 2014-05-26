//
//  LaunchViewController.h
//  ShowCasePro
//
//  Created by CY-003 on 13-12-18.
//  Copyright (c) 2013年 yczx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LaunchViewController : UIViewController

@property(nonatomic , assign) BOOL showLoadingView;

- (void) pushToHomepageWithDelay:(float)delay;

@end
