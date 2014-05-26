//
//  LixilEarth.m
//  LixilCore
//
//  Created by Mac on 14-2-23.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import "LixilEarth.h"

@interface LixilEarth ()
{
    __weak IBOutlet UIImageView *rotateEarth;
    
}

@end

@implementation LixilEarth

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
    
    NSMutableArray *earthArray = [NSMutableArray array];
    
    for (int i = 1; i <= 33; i++)
    {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"lc_earth_%d",i]];
        
        [earthArray addObject:image];
    }
    
    //rotateEarth.contentMode = UIViewContentModeCenter;
    rotateEarth.animationImages = earthArray;
    rotateEarth.animationDuration = 3;
    rotateEarth.animationRepeatCount = 0;
    
    [rotateEarth startAnimating];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
