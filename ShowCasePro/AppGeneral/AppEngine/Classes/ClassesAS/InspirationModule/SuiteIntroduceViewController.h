//
//  SuiteIntroduceViewController.h
//  ShowCasePro
//
//  Created by yczx on 14-1-22.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "URBMediaFocusViewController.h"

@interface SuiteIntroduceViewController : UIViewController<URBMediaFocusViewControllerDelegate,UIGestureRecognizerDelegate>

// 系列介绍
@property (weak, nonatomic) IBOutlet UITextView *suiteIntroduce;

// 空间代表代表图
@property (weak, nonatomic) IBOutlet UIScrollView *suiteScrollVeiw;

// pageController
@property (weak, nonatomic) IBOutlet UIPageControl *pageController;

// 点击星空图时显示的Tag
@property (weak, nonatomic) NSString *suiteID;


@property (weak, nonatomic) IBOutlet UIImageView *suite_Ico;


@property (weak, nonatomic) IBOutlet UILabel *suite_Name;


@end
