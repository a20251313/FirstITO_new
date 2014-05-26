//
//  InaxSuccessfulProjectsViewController.m
//  ShowCasePro
//
//  Created by Mac on 14-3-18.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "InaxSuccessfulProjectsViewController.h"
#define Animation_Duration_InaxSuccessfulProject 0.7
@interface InaxSuccessfulProjectsViewController ()
{
    __weak IBOutlet UIImageView *topimage;
    
    __weak IBOutlet UIImageView *middleImage;
    
    __weak IBOutlet UIImageView *bottomImage;
    
    __weak IBOutlet UIImageView *topRefImage;
    
    __weak IBOutlet UIImageView *middleRefImage;
    
    __weak IBOutlet UIImageView *bottomRefImage;
   
    __weak IBOutlet UIView *topListView;
    
    __weak IBOutlet UIView *refView;
    
    __weak IBOutlet UIImageView *topBlueImg;
    
    __weak IBOutlet UIImageView *middleBlueImg;
   
    __weak IBOutlet UIImageView *bottomBlueImg;
    UIScrollView *changbaishanScrollView;
    
      UIScrollView *shanghaishiboScrollView;
    
    
}

@property(strong,nonatomic) UIButton  *preciousBtn;
@property(strong,nonatomic) UIImageView *preciousImgView;
@property(strong,nonatomic) UIImageView *preciousRefImgView;
@property(strong,nonatomic) UIImageView *preciousBlowImgView;
@property(nonatomic,strong)NSMutableArray *changbaishanArrayImage;
@property(nonatomic,strong)NSMutableArray *shanghaishiboArrayImage;
@end

@implementation InaxSuccessfulProjectsViewController

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
    
    middleImage.alpha = 0;
    bottomImage.alpha = 0;
   
    _preciousBtn  = (UIButton*)[self.view viewWithTag:10];
    _preciousImgView = (UIImageView*)[self.view viewWithTag:3];
   // _preciousBlowImgView = (UIImageView*)[self.view viewWithTag:5];
    
    _preciousBlowImgView = nil;
    _preciousRefImgView = (UIImageView*)[self.view viewWithTag:4];
    
      _changbaishanArrayImage = [NSMutableArray arrayWithCapacity:3];
       for(int i = 1;i <4 ;i++){
        NSString *imgName = [[NSString alloc]initWithFormat:@"ecocarat_ph_do_changbaishang%d.png" ,i];
        UIImage *img = [UIImage imageNamed:imgName];
       [_changbaishanArrayImage addObject:img];
    }
    _shanghaishiboArrayImage = [NSMutableArray arrayWithCapacity:1];
   
    UIImage *imgShang = [UIImage imageNamed:@"inax_sp_shanghaishibo"];
    [_shanghaishiboArrayImage addObject:imgShang];

    
    
    
    [self.view viewWithTag:90].hidden = YES;
    [self.view viewWithTag:99].hidden = YES;
    [self.view viewWithTag:91].hidden = YES;

}
#pragma mark - button method -

- (IBAction)topBtnPressed:(UIButton *)sender {
    if(_preciousBlowImgView != topimage)
    {
        [self.view viewWithTag:99].hidden = YES;
       shanghaishiboScrollView.hidden = YES;
        [self.view viewWithTag:91].hidden = YES;
         changbaishanScrollView.hidden = YES;
               refView.alpha = 1;
        topListView.alpha = 1;
        _preciousImgView.alpha = 0;
        _preciousBtn.alpha= 1;
        _preciousRefImgView.alpha = 0;
        [UIView animateWithDuration:Animation_Duration_InaxSuccessfulProject animations:^{
            _preciousBlowImgView.alpha = 0;
        }];
        
        _preciousBlowImgView = topimage;
        
        
        _preciousRefImgView  = topRefImage;
        
        sender.imageView.alpha = 1;
        _preciousBtn = sender;
        
        topBlueImg.alpha = 1;
        _preciousImgView = topBlueImg;
        [UIView animateWithDuration:Animation_Duration_InaxSuccessfulProject animations:^{
            topimage.alpha = 1;
            topRefImage.alpha = 1;
            CGRect rect = CGRectMake(293, 175, 582, 275);
            refView.frame = rect;
            CGRect rect1 = CGRectMake(683, 129, 192, 45);
            topListView.frame = rect1;
            [self.view viewWithTag:90].hidden = NO;

            
        }];
        
        
    }

    
}
- (IBAction)middleBtnPressed:(UIButton *)sender {
   
    if(_preciousBlowImgView != middleImage)
    {
        changbaishanScrollView.hidden = YES;
        shanghaishiboScrollView.hidden = YES;
        [self.view viewWithTag:99].hidden = YES;
       [self.view viewWithTag:91].hidden = YES;
        [self.view viewWithTag:90].hidden = YES;
        refView.alpha = 1;
        topListView.alpha = 1;
        _preciousImgView.alpha = 0;
        _preciousBtn.alpha= 1;
        _preciousRefImgView.alpha = 0;
        [UIView animateWithDuration:Animation_Duration_InaxSuccessfulProject animations:^{
            _preciousBlowImgView.alpha = 0;
                   }];
       
        _preciousBlowImgView = middleImage;
        
       
        _preciousRefImgView  = middleRefImage;
        
        sender.imageView.alpha = 1;
        _preciousBtn = sender;
        
        middleBlueImg.alpha = 1;
        _preciousImgView = middleBlueImg;
        [UIView animateWithDuration:Animation_Duration_InaxSuccessfulProject animations:^{
             middleImage.alpha = 1;
             middleRefImage.alpha = 1;
            CGRect rect = CGRectMake(293, 311, 584, 275);
            refView.frame = rect;
            CGRect rect1 = CGRectMake(683, 267, 192, 45);
            topListView.frame = rect1;
            
        }];

        
    }
  
}
- (IBAction)bottomBtnPressed:(UIButton *)sender {
    
    if(_preciousBlowImgView != bottomImage)
    {
         shanghaishiboScrollView.hidden = YES;
        changbaishanScrollView.hidden = YES;
        [self.view viewWithTag:99].hidden = YES;
     
        [self.view viewWithTag:90].hidden = YES;
        refView.alpha = 1;
        topListView.alpha = 1;
        _preciousImgView.alpha = 0;
        _preciousBtn.alpha= 1;
        _preciousRefImgView.alpha = 0;
        [UIView animateWithDuration:Animation_Duration_InaxSuccessfulProject animations:^{
            _preciousBlowImgView.alpha = 0;
        }];
        
        _preciousBlowImgView = bottomImage;
        
        
        _preciousRefImgView  = bottomRefImage;
        
        sender.imageView.alpha = 1;
        _preciousBtn = sender;
        
        bottomBlueImg.alpha = 1;
        _preciousImgView = bottomBlueImg;
        [UIView animateWithDuration:Animation_Duration_InaxSuccessfulProject animations:^{
            bottomImage.alpha = 1;
            bottomRefImage.alpha = 1;
            CGRect rect = CGRectMake(293, 311, 584, 275);
            refView.frame = rect;
            CGRect rect1 = CGRectMake(683, 267, 192, 45);
            topListView.frame = rect1;
            [self.view viewWithTag:91].hidden = NO;
            
        }];
        
        
    }

}
- (IBAction)clearBtn:(UIButton *)sender {
    topBlueImg.alpha = 0;
    bottomBlueImg.alpha = 0;
    middleBlueImg.alpha =0;
    topListView.alpha = 0;
    refView.alpha = 0;
    _preciousBlowImgView = nil;
    [self.view viewWithTag:90].hidden = YES;
    [self.view viewWithTag:99].hidden = YES;
    [self.view viewWithTag:91].hidden = YES;
    
 }
- (IBAction)moveToLeftBtnPressed:(UIButton *)sender {
    if(changbaishanScrollView.hidden==NO)
    {
        
        [changbaishanScrollView setContentOffset:CGPointMake(190,0) animated:YES];
        
    }

}
- (IBAction)moveToRightBtnPressed:(UIButton *)sender {
    if(changbaishanScrollView.hidden==NO)
    {
        
        [changbaishanScrollView setContentOffset:CGPointMake(-10,0) animated:YES];
        
    }

}
- (IBAction)topCloseBtn:(id)sender {
    
   if(topimage.alpha == 1){
    if(changbaishanScrollView !=nil){
    changbaishanScrollView.hidden = YES;
    [self.view viewWithTag:99].hidden = YES;
    if(topimage.alpha ==1)
    topRefImage.alpha = 1;
    [self.view viewWithTag:90].hidden = NO;
    }
   }
   if(bottomImage.alpha == 1){
     if(shanghaishiboScrollView != nil)
    shanghaishiboScrollView.hidden = YES;
    [self.view viewWithTag:99].hidden = YES;
    [self.view viewWithTag:91].hidden = NO;
    if(bottomImage.alpha == 1)
        bottomRefImage.alpha =1;
    }
}

- (IBAction)changbaishangAddBtn:(id)sender {
    
    if(shanghaishiboScrollView != nil){
    [shanghaishiboScrollView removeFromSuperview];
    shanghaishiboScrollView = nil;
    }
    
    changbaishanScrollView.hidden = NO;
    topRefImage.alpha = 0;
    refView.backgroundColor = [UIColor whiteColor];
    if(changbaishanScrollView ==nil){
    changbaishanScrollView = [self createScrollView:_changbaishanArrayImage frame:CGRectMake(0, 20, 581.5, 274)];
    [refView addSubview:  changbaishanScrollView];
    [refView bringSubviewToFront:changbaishanScrollView];
    }
    [self.view viewWithTag:99].hidden = NO;
    refView.alpha = 1;
    [self.view viewWithTag:90].hidden = YES;
}
- (IBAction)shanghaishiboAddBtn:(id)sender {
     if(changbaishanScrollView !=nil){
    [changbaishanScrollView removeFromSuperview];
    changbaishanScrollView =nil;
     }
    bottomRefImage.alpha = 0;
    [self.view viewWithTag:91].hidden = YES;
    
    refView.backgroundColor = [UIColor whiteColor];
    if(shanghaishiboScrollView == nil){
    shanghaishiboScrollView = [self createScrollView:_shanghaishiboArrayImage frame:CGRectMake(0, 20, 581.5, 274)];
    [refView addSubview:  shanghaishiboScrollView];
    [refView bringSubviewToFront:shanghaishiboScrollView];
    }
    [self.view viewWithTag:99].hidden = NO;
    refView.alpha = 1;
    shanghaishiboScrollView.hidden = NO;
    
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
    [scrollView setContentSize:CGSizeMake(img.size.width/2*count+100, 274)];
    
    
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



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
