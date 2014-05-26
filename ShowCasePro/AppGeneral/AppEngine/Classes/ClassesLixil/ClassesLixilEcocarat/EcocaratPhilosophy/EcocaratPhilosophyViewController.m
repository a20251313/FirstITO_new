//
//  EcocaratPhilosophyViewController.m
//  ShowCasePro
//
//  Created by Mac on 14-4-2.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "EcocaratPhilosophyViewController.h"
#define Animation_Duration_EcocaratPhilosophy 0.5
@interface EcocaratPhilosophyViewController ()
{
    
    __weak IBOutlet UIImageView *middleImage;
    __weak IBOutlet UIImageView *bottomImage;
    __weak IBOutlet UIView *refView;
    __weak IBOutlet UIView *topView;
    __weak IBOutlet UIImageView *middleBlueImg;
    __weak IBOutlet UIImageView *bottomBlueImg;
    
    __weak IBOutlet UIImageView *baimg;
      UIScrollView *milldeScroll;
      UIScrollView *bottomScroll;
    
    
    UIImageView *desImg;
    int leftScrollSpan;
    int rightScrollSpan;

    
}
@property(nonatomic,strong)NSMutableArray *middleArrayImage;
@property(nonatomic,strong)NSMutableArray  *bottomArrayImage;


@end

@implementation EcocaratPhilosophyViewController

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
    _middleArrayImage = [NSMutableArray arrayWithCapacity:3];
    _bottomArrayImage = [NSMutableArray arrayWithCapacity:6];
    for(int i = 1;i <4 ;i++){
        NSString *imgName = [[NSString alloc]initWithFormat:@"ecocarat_ph_do_changbaishang%d.png" ,i];
        UIImage *img = [UIImage imageNamed:imgName];
        [_middleArrayImage addObject:img];
    }
    for(int i = 1;i <7 ;i++){
        NSString *imgName = [[NSString alloc]initWithFormat:@"ecocarat_ph_ov_%d.png" ,i];
        UIImage *img = [UIImage imageNamed:imgName];
        [_bottomArrayImage addObject:img];
    }
    
    middleImage.alpha = 1;
    bottomImage.alpha = 0;
    leftScrollSpan = 450;
    rightScrollSpan = -10;
}
-(UIScrollView*)createScrollView:(NSMutableArray *)imgArray  frame: (CGRect)frame
{
    //[refScrollView]
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:frame];
  
    scrollView.pagingEnabled = NO;
    scrollView.delegate = self;
    
    scrollView.bounces = YES;
    [scrollView setShowsHorizontalScrollIndicator:NO];
    [scrollView setShowsVerticalScrollIndicator:NO];
    NSInteger count = [imgArray count];
      UIImage *img =  [UIImage imageNamed:@"ecocarat_ph_do_changbaishang1"];
    if(imgArray ==_bottomArrayImage)
    {
         [scrollView setContentSize:CGSizeMake(img.size.width/2*count+180, 274)];
    }
    else{
         [scrollView setContentSize:CGSizeMake(img.size.width/2*count+100, 274)];
    }
   
   // scrollView.backgroundColor = [UIColor blueColor];
    for(NSInteger i = 1;i< count+1;i++)
    {
        UIImage *img= [imgArray objectAtIndex:(i-1)];
        UIImageView *imgView =[[UIImageView alloc] initWithFrame:CGRectMake((i-1)*img.size.width/2+i*23, 10, img.size.width/2, img.size.height/2)];
    
        imgView.image = img;
        
        [scrollView addSubview:imgView];
        
    }
    
   return scrollView;
}
#pragma mark - button method -
- (IBAction)middleBtnPressed:(UIButton *)sender {
    
    if(bottomBlueImg.alpha == 1)
    {
        bottomBlueImg.alpha = 0;
        bottomScroll.alpha =0;
    }
   //  if(milldeScroll.alpha != 1)milldeScroll.alpha = 1;
    [UIView animateWithDuration:Animation_Duration_EcocaratPhilosophy animations:^{
        
        middleImage.alpha = 1;
        bottomImage.alpha = 0;
        
    }];
    

    if(middleBlueImg.alpha !=1)
    {
        
        [UIView animateWithDuration:Animation_Duration_EcocaratPhilosophy animations:^{
            
         //   middleImage.alpha = 1;
          //  bottomImage.alpha = 0;
            
        }];
       
    refView.alpha = 1;
    middleBlueImg.alpha =1;
    topView.alpha =1;
    milldeScroll= [self createScrollView:_middleArrayImage frame:CGRectMake(0, 20, 586, 274)];
    [refView addSubview: milldeScroll];
    UIImage *imgdes = [UIImage imageNamed:@"ecocarat_ph_do_changbaishang_item"];
        
    desImg =[[UIImageView alloc] initWithFrame:CGRectMake(20, 10, imgdes.size.width/2, imgdes.size.height/2)];
    desImg.image = imgdes;
    [refView addSubview:desImg];
       
    }
   if(desImg.alpha ==0) desImg.alpha = 1;
    
}
- (IBAction)bottomBtnPressed:(UIButton *)sender {
    
    if(middleBlueImg.alpha == 1)
    {
        middleBlueImg.alpha = 0;
        milldeScroll.alpha = 0;
    }
    //if(bottomScroll.alpha!=1)bottomScroll.alpha =1;
    [UIView animateWithDuration:Animation_Duration_EcocaratPhilosophy animations:^{
        middleImage.alpha = 0;
        bottomImage.alpha = 1;
        
    }];
    if(bottomBlueImg.alpha !=1)
    {
         [bottomScroll setContentOffset:CGPointMake(0,0) animated:YES];
        leftScrollSpan = 450;

     //   [UIView animateWithDuration:Animation_Duration_EcocaratPhilosophy animations:^{
        //    middleImage.alpha = 0;
       //     bottomImage.alpha = 1;

       // }];
    topView.alpha =1;
    desImg.alpha = 0;
    refView.alpha = 1;
    bottomBlueImg.alpha =1;
    bottomScroll= [self createScrollView:_bottomArrayImage frame:CGRectMake(0, 10, 586, 274)];
    [refView addSubview:bottomScroll];
    }

    
  if(desImg.alpha ==1) desImg.alpha = 0;
    
}
- (IBAction)clearBtnPressed:(UIButton *)sender {
    
    if(middleBlueImg.alpha ==1)
    {
        milldeScroll.alpha = 0;
        middleBlueImg.alpha = 0;
        refView.alpha = 0;
        topView.alpha = 0;
        desImg.alpha = 0;
    }
    
    if(bottomBlueImg.alpha ==1)
    {
        bottomScroll.alpha = 0;
        bottomBlueImg.alpha = 0;
        refView.alpha = 0;
        topView.alpha = 0;
        desImg.alpha = 0;
        
    }
}
- (IBAction)leftBtnPressed:(id)sender {
    
       if(milldeScroll.alpha ==1)
    {
        
        [milldeScroll setContentOffset:CGPointMake(190,0) animated:YES];
 
    }
    
    if(bottomScroll.alpha ==1)
    {
        
        if(bottomScroll.contentOffset.x>850)
        {
            leftScrollSpan = 450;
            return;
        }
        [bottomScroll setContentOffset:CGPointMake(leftScrollSpan,0) animated:YES];
        leftScrollSpan+=470;
    }
    
}
- (IBAction)rightBtnPressed:(id)sender {
    
  

    if(milldeScroll.alpha ==1)
    {
        [milldeScroll setContentOffset:CGPointMake(-10,0) animated:YES];

    }
    
    if(bottomScroll.alpha ==1)
    {
        if(bottomScroll.contentOffset.x<=-10)
        {
            
            rightScrollSpan=-10;
            return;
        }
        [bottomScroll setContentOffset:CGPointMake(rightScrollSpan,0) animated:YES];
          rightScrollSpan-=10;
    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
