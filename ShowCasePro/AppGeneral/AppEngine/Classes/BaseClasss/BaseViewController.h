//
//  BaseViewController.h
//  ShowCasePro
//
//  Created by yczx on 13-11-22.
//  Copyright (c) 2013年 yczx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

// backBtn ShowView
@property(nonatomic, assign) BOOL hideBackBtn;

@property (nonatomic, strong) UIPopoverController *popoverController1Base;

- (void)backBtnEvent:(id)sender;

@end
