//
//  SashPhilosophyViewController.m
//  ShowCasePro
//
//  Created by Mac on 14-4-8.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "SashPhilosophyViewController.h"
#define Animation_Duration_EcocaratPhilosophy 1

@interface SashPhilosophyViewController ()
{
    __weak IBOutlet UIImageView *middleImage;
    __weak IBOutlet UIImageView *bottomImage;
    __weak IBOutlet UIView *refView;
    __weak IBOutlet UIView *topView;
    __weak IBOutlet UIImageView *middleBlueImg;
    __weak IBOutlet UIImageView *bottomBlueImg;
    
    UIImageView *desImg;


}

@end

@implementation SashPhilosophyViewController

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
    middleImage.alpha = 1;
    bottomImage.alpha = 0;
}
- (IBAction)middleBtnPressed:(UIButton *)sender {
    if(bottomBlueImg.alpha == 1)
    {
        bottomBlueImg.alpha = 0;
    }
    if(middleBlueImg.alpha !=1)
    {
        
        [UIView animateWithDuration:Animation_Duration_EcocaratPhilosophy animations:^{
            
            middleImage.alpha = 1;
            bottomImage.alpha = 0;
            
        }];
        
        refView.alpha = 1;
        middleBlueImg.alpha =1;
        topView.alpha =1;
       
     /*  UIImage *imgdes = [UIImage imageNamed:@"sash_ph_do_des.png"];
        
        desImg =[[UIImageView alloc] initWithFrame:CGRectMake(20, 10, imgdes.size.width/2, imgdes.size.height/2)];
        desImg.image = imgdes;
        [refView addSubview:desImg];
     */
    }
    
 //  if(desImg.alpha ==0) desImg.alpha = 1;

}
- (IBAction)bottomBtnPressed:(UIButton *)sender {
//    if(middleBlueImg.alpha == 1)
//    {
//        middleBlueImg.alpha = 0;
//    }
//    //if(bottomScroll.alpha!=1)bottomScroll.alpha =1;
//    
//    if(bottomBlueImg.alpha !=1)
//    {
//        
//        [UIView animateWithDuration:Animation_Duration_EcocaratPhilosophy animations:^{
//            middleImage.alpha = 0;
//            bottomImage.alpha = 1;
//            
//        }];
//        topView.alpha =1;
//        desImg.alpha = 0;
//        refView.alpha = 1;
//        bottomBlueImg.alpha =1;
//      
//    }
//    
//    
//    if(desImg.alpha ==1) desImg.alpha = 0;

}
- (IBAction)closeBtnPressed:(UIButton *)sender {
    
    if(middleBlueImg.alpha ==1)
    {
        middleBlueImg.alpha = 0;
        refView.alpha = 0;
        topView.alpha = 0;
        desImg.alpha = 0;
    }
    

}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
