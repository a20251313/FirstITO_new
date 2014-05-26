//
//  CalculateViewController.m
//  ShowCasePro
//
//  Created by yczx on 13-11-25.
//  Copyright (c) 2013年 yczx. All rights reserved.
//

#import "CalculateViewController.h"

@interface CalculateViewController ()

@end

@implementation CalculateViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
   
    CalculatorView *cl = [[CalculatorView alloc] init];
    [self addChildViewController:cl];
    [self.view addSubview:cl.view];
}

@end
