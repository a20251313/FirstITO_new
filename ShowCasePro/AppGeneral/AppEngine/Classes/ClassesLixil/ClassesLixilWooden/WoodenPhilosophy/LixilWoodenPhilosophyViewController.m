//
//  LixilWoodenPhilosophyViewController.m
//  ShowCasePro
//
//  Created by Mac on 14-3-27.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "LixilWoodenPhilosophyViewController.h"
#define Animation_Duration_WoodenPhilosophy 0.7

@interface LixilWoodenPhilosophyViewController ()
{
    
    __weak IBOutlet UIImageView *middleImage;
    __weak IBOutlet UIImageView *bottomImage;
   
    
    __weak IBOutlet UIImageView *middleRefImage;
    __weak IBOutlet UIImageView *bottomRefImage;
    __weak IBOutlet UIView *refView;
    __weak IBOutlet UIView *topListView;
  
    __weak IBOutlet UIImageView *middleBlueImg;
    __weak IBOutlet UIImageView *bottomBlueImg;
   
    __weak IBOutlet UIScrollView *lzhyScrollView;
    UIImage *lzImg;
    
}
@property(strong,nonatomic) UIButton  *preciousBtn;
@property(strong,nonatomic) UIImageView *preciousImgView;
@property(strong,nonatomic) UIImageView *preciousRefImgView;
@property(strong,nonatomic) UIImageView *preciousBlowImgView;

@end

@implementation LixilWoodenPhilosophyViewController

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
  
    bottomImage.alpha = 0;
    topListView.alpha = 0;
    refView.alpha = 0;
    
    _preciousBtn  = (UIButton*)[self.view viewWithTag:10];
    _preciousImgView = (UIImageView*)[self.view viewWithTag:3];
    _preciousBlowImgView = (UIImageView*)[self.view viewWithTag:5];
    _preciousRefImgView = (UIImageView*)[self.view viewWithTag:4];
    lzhyScrollView.contentSize = CGSizeMake(800, 274);
    
     lzImg = [UIImage imageNamed:@"wooden_ph_lzhyItem"];

    UIImageView *item = [[UIImageView alloc] initWithFrame:CGRectMake(24, 13, lzImg.size.width/2, lzImg.size.height/2)];
    item.image = lzImg;
    [lzhyScrollView addSubview:item];
    
    
    
    
    
    lzhyScrollView.hidden = YES;
    [self.view viewWithTag:99].hidden = YES;
    [self.view viewWithTag:95].hidden = YES;
    
}
#pragma mark - button method -

- (IBAction)middleBtnPressed:(UIButton *)sender {
    
   
    if(_preciousBlowImgView != middleImage)
    {
        [self.view viewWithTag:99].hidden = NO;
        [self.view viewWithTag:95].hidden = YES;
        topListView.alpha = 1;

        refView.alpha = 1;
        
        lzhyScrollView.alpha = 0;

        _preciousImgView.alpha = 0;
        _preciousBtn.alpha= 1;
        _preciousRefImgView.alpha = 0;
        
       //        [UIView animateWithDuration:Animation_Duration_WoodenPhilosophy animations:^{
//            _preciousBlowImgView.alpha = 0;
//        }];
        
        
        
        _preciousRefImgView  = middleRefImage;
        
        sender.imageView.alpha = 1;
        _preciousBtn = sender;
        
        middleBlueImg.alpha = 1;
        _preciousImgView = middleBlueImg;
        [UIView animateWithDuration:Animation_Duration_WoodenPhilosophy animations:^{
            _preciousBlowImgView.alpha = 0;

           
            middleRefImage.alpha = 1;
         //   CGRect rect = CGRectMake(293, 311, 584, 275);
       //     refView.frame = rect;
         //   CGRect rect1 = CGRectMake(683, 267, 192, 45);
        //    topListView.frame = rect1;
            
        }];
         middleImage.alpha = 1;
        _preciousBlowImgView = middleImage;

        
    }
    
}
- (IBAction)bottomBtnPressed:(UIButton *)sender {
    
    if(_preciousBlowImgView != bottomImage)
    {
        [self.view viewWithTag:99].hidden = YES;
       [self.view viewWithTag:95].hidden = YES;
        topListView.alpha = 1;

        refView.alpha = 1;

        lzhyScrollView.alpha = 0;

        _preciousImgView.alpha = 0;
        _preciousBtn.alpha= 1;
        _preciousRefImgView.alpha = 0;
//        [UIView animateWithDuration:Animation_Duration_WoodenPhilosophy animations:^{
//            _preciousBlowImgView.alpha = 0;
//        }];
        
        
        _preciousRefImgView  = bottomRefImage;
        
        sender.imageView.alpha = 1;
        _preciousBtn = sender;
        
        bottomBlueImg.alpha = 1;
        _preciousImgView = bottomBlueImg;
        [UIView animateWithDuration:Animation_Duration_WoodenPhilosophy animations:^{
            bottomImage.alpha = 1;
            bottomRefImage.alpha = 1;
            _preciousBlowImgView.alpha = 0;

         //   CGRect rect = CGRectMake(293, 311, 584, 275);
        //    refView.frame = rect;
         //   CGRect rect1 = CGRectMake(683, 267, 192, 45);
        //    topListView.frame = rect1;
            
        }];
        _preciousBlowImgView = bottomImage;

        
    }
    
}
- (IBAction)clearBtn:(UIButton *)sender {
    if(middleImage.alpha ==1){
        [self.view viewWithTag:99].hidden = YES;
         [self.view viewWithTag:95].hidden = YES;
        _preciousBlowImgView = nil;
        refView.alpha = 0;
        topListView.alpha = 0;
        middleBlueImg.alpha = 0;
        
        lzhyScrollView.hidden = YES;
        
        
    }
    if(bottomImage.alpha ==1){
        _preciousBlowImgView = nil;
        refView.alpha = 0;
        topListView.alpha = 0;
        bottomBlueImg.alpha = 0;
        lzhyScrollView.hidden = YES;
        
    }
    
    
        }
- (IBAction)lzhyBtnPressed:(UIButton *)sender {
    if(middleImage.alpha ==1)
{
    _preciousRefImgView.alpha = 0;
    lzhyScrollView.hidden = NO;
    lzhyScrollView.alpha = 1;
 [self.view viewWithTag:99].hidden = YES;
 [self.view viewWithTag:95].hidden = NO;
}
   //    for(int i = 0; i<3;i++)
//    {
//        UIImageView *item = [[UIImageView alloc] initWithFrame:CGRectMake(24*(i+1), 13, 225, 225)];
//        item.image = [UIImage imageNamed:[NSString stringWithFormat:@"wooden_ph_lzhy%d", i+1]];
//        [lzhyScrollView addSubview:item];
//    }
}
- (IBAction)bacToMain:(id)sender {
    
    lzhyScrollView.hidden = YES;
    middleRefImage.alpha = 1;
    [self.view viewWithTag:95].hidden = YES;
    [self.view viewWithTag:99].hidden = NO;
}
- (IBAction)leftBtnPressed:(id)sender {
    
    if(lzhyScrollView.hidden == NO)
    {
    
    [lzhyScrollView setContentOffset:CGPointMake(190,0) animated:YES];
    }

}
- (IBAction)rightBtnPressed:(id)sender {
    if(lzhyScrollView.hidden == NO)
    {
       
        [lzhyScrollView setContentOffset:CGPointMake(-10, 0) animated:YES];
    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
