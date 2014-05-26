//
//  LixilCalculateMuduleViewController.m
//  ShowCasePro
//
//  Created by yczx on 14-4-15.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "LixilCalculateMuduleViewController.h"
#import "LixilCalculatorView.h"

@interface LixilCalculateMuduleViewController ()

@end

@implementation LixilCalculateMuduleViewController



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    LixilCalculatorView *cl = [[LixilCalculatorView alloc] init];
    [self addChildViewController:cl];
    [self.view addSubview:cl.view];
    
    cl.view.frame = CGRectMake(0, 85, 1024, 683);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
