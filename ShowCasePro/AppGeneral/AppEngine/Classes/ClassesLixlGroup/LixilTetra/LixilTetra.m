//
//  LixilTetra.m
//  LixilCore
//
//  Created by Mac on 14-2-23.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import "LixilTetra.h"

@interface LixilTetra ()

@end

@implementation LixilTetra

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
    
    self.searchModuleView.hidden = YES;
    
    LixilCore *core = [LixilCore new];
    LixilEarth*earth = [LixilEarth new];
    
    earth.view.frame = CGRectMake(0, 683, 1024, 683);
    
    UIScrollView *srcollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 85, 1024, 683)];
    srcollView.contentSize = CGSizeMake(1024, 683*2);
    srcollView.showsHorizontalScrollIndicator = NO;
    srcollView.showsVerticalScrollIndicator = NO;
    srcollView.bounces = NO;
    srcollView.pagingEnabled = YES;
    srcollView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0);
    
    [srcollView addSubview:core.view];
    [srcollView addSubview:earth.view];
    [self.view addSubview:srcollView];
    
    [self addChildViewController:core];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
