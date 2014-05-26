//
//  InaxBrandConceptViewController.m
//  ShowCasePro
//
//  Created by Mac on 14-3-18.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "InaxBrandConceptViewController.h"
#import "UserGuideTips.h"
#define Animation_Duration_InaxBrandConcept 0.3

@interface InaxBrandConceptViewController ()
{
    
    __weak IBOutlet UIImageView *leftImage;
   
    
    __weak IBOutlet UIImageView *middleImage;
    
    __weak IBOutlet UIImageView *rightImage;
}
@property(strong,nonatomic) NSArray *imageArray;
@end

@implementation InaxBrandConceptViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - buttonImage -

- (IBAction)leftBtn:(UIButton *)sender {
    for (UIImageView *im in self.imageArray) {
        if(im.alpha == 1)
        {
            [UIView animateWithDuration:Animation_Duration_InaxBrandConcept animations:^{
                im.alpha = 0;
            }];
        }
    }

    [UIView animateWithDuration:Animation_Duration_InaxBrandConcept animations:^{
     leftImage.alpha  = 1;
    }];
}

- (IBAction)middleBtn:(UIButton *)sender {
    for (UIImageView *im in self.imageArray) {
        if(im.alpha == 1)
        {
            [UIView animateWithDuration:Animation_Duration_InaxBrandConcept animations:^{
                im.alpha = 0;
            }];
        }
    }

    [UIView animateWithDuration:Animation_Duration_InaxBrandConcept animations:^{
        middleImage.alpha = 1;
    }];
}
- (IBAction)rightBtn:(UIButton *)sender {
    for (UIImageView *im in self.imageArray) {
        if(im.alpha == 1)
        {
            [UIView animateWithDuration:Animation_Duration_InaxBrandConcept animations:^{
                im.alpha = 0;
            }];
        }
    }

    [UIView animateWithDuration:Animation_Duration_InaxBrandConcept animations:^{
        rightImage.alpha = 1;
    }];
   }



- (IBAction)bkgBtn:(id)sender {
    for (UIImageView *im in self.imageArray) {
        if(im.alpha == 1)
        {
            [UIView animateWithDuration:Animation_Duration_InaxBrandConcept animations:^{
               im.alpha = 0;
            }];
        }
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    //提示蒙板
    UserGuideTips *userTip = [UserGuideTips shareInstance];
    [userTip showUserGuideView:self.view tipKey:@"InaxbrandConcept" imageNamePre:@"InaxBrandTipsImage"];
    
    // Do any additional setup after loading the view from its nib.
    leftImage.alpha  = 0;
    middleImage.alpha = 0;
    rightImage.alpha = 0;
    self.imageArray  = [NSArray arrayWithObjects:leftImage,middleImage,rightImage, nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
