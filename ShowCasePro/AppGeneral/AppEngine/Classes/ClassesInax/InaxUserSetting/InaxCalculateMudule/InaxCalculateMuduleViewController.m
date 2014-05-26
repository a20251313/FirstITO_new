//
//  InaxCalculateMuduleViewController.m
//  ShowCasePro
//
//  Created by yczx on 14-4-15.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "InaxCalculateMuduleViewController.h"
#import "InaxCalculatorView.h"

@interface InaxCalculateMuduleViewController ()

@end

@implementation InaxCalculateMuduleViewController

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
    
    InaxCalculatorView *cl = [[InaxCalculatorView alloc] init];
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
