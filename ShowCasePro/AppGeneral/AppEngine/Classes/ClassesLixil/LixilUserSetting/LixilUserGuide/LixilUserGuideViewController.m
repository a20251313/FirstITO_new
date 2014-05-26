//
//  LixilUserGuideViewController.m
//  ShowCasePro
//
//  Created by yczx on 14-4-15.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "LixilUserGuideViewController.h"

@interface LixilUserGuideViewController ()
//用户指南背景图片
@property (strong, nonatomic) IBOutlet UIImageView *userGuideImageView;

@end

@implementation LixilUserGuideViewController
{
    


}
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
    
    //每次进入不同的用户指南来提示不同的图片
    NSInteger userGuideId =  [[LibraryAPI sharedInstance].currentBrandID integerValue];
    switch (userGuideId) {
            
        case 0:
        {
            [self.userGuideImageView setImage:[UIImage imageNamed:@"Lixil_Guide.png"]];
            
        }
            break;
        case 4:
        {
            [self.userGuideImageView setImage:[UIImage imageNamed:@"LixlGroup_Guide.png"]];
            
        }
            break;
        case 11:
        {
            [self.userGuideImageView setImage:[UIImage imageNamed:@"Lixil_Wooden_Guide.png"]];
            
        }
            break;
        case 12:
        {
            [self.userGuideImageView setImage:[UIImage imageNamed:@"Lixil_Sash_Guide.png"]];
            
        }
            break;
        case 13:
        {
            [self.userGuideImageView setImage:[UIImage imageNamed:@"Lixil_Ecocarat_Guide.png"]];
            
        }
            break;
            
        default:
            break;
    }
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
