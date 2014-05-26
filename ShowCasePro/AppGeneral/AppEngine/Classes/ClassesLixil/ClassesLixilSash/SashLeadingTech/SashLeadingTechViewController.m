//
//  SashLeadingTechViewController.m
//  ShowCasePro
//
//  Created by Mac on 14-4-8.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "SashLeadingTechViewController.h"
#import "SashLeadingTechAnimationView.h"
#define   rollSpeed  25;
#define Animation_Duration_roll   0.05

@interface SashLeadingTechViewController ()
{
    
    __weak IBOutlet UIImageView *qihua;
    __weak IBOutlet UIImageView *shizuo;
    __weak IBOutlet UIImageView *zhizao;
    __weak IBOutlet UIImageView *xiaoshou;
    __weak IBOutlet UIImageView *guke;
    __weak IBOutlet UIView *leftCOver;
   
    __weak IBOutlet UIView *rightCover;
    
    __weak IBOutlet UIView *rootView;
    
    __weak IBOutlet UIView *root;
    UIScrollView *scrollViews;
    NSTimer *rightCoverTimer;
    NSTimer *leftCoverTimer;
    BOOL isAniPage;
    
    CGRect rightFrame;
    
    CGRect leftFrame;
    
    UIImageView *pageView;
}

@end

@implementation SashLeadingTechViewController

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
    rightFrame = rightCover.frame;
    leftFrame = leftCOver.frame;
    scrollViews = [self creatScrollView:CGRectMake(0, 85, 1024, 683) imageName:@"sash_lt_des1"];
    
    [self.view addSubview:scrollViews];
  //  SashLeadingTechAnimationView *aniView = [[SashLeadingTechAnimationView alloc]initWithFrame:CGRectMake(0, 683*2, 1024, /683)];
  //  [scrollViews addSubview:aniView];
    [self addImageViewForScrollView:@"sash_lt_des3.png" pointY:683*2];
 
   
   
    [root setFrame:CGRectMake(0, 683, 1024, 683)];
    
    [scrollViews addSubview:root];
   
    scrollViews.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0);
     pageView = [[UIImageView alloc]initWithFrame:CGRectMake(900, 630, 72/2, 191/2)];
    
    pageView.image = [UIImage imageNamed:@"wooden_lt_page1"];
    
    [self.view addSubview:pageView];
    
    [self.view bringSubviewToFront:pageView];
    
}



-(void)delayBringSubViewToFont:(UIImageView *)imgView
{
    imgView.alpha = 1;
    
    
}

-(void)startAniPage
{
    
    [self performSelector:@selector(startAniIRight) withObject:nil afterDelay:0.2];
   
    [self performSelector:@selector(delayBringSubViewToFont:) withObject:qihua afterDelay:0.5];
   
    [self performSelector:@selector(delayBringSubViewToFont:) withObject:shizuo afterDelay:0.7];
   
    [self performSelector:@selector(delayBringSubViewToFont:) withObject:zhizao afterDelay:0.9];
    
    [self performSelector:@selector(startAniILeft) withObject:nil afterDelay:1.1];
  
    [self performSelector:@selector(delayBringSubViewToFont:) withObject:xiaoshou afterDelay:1.3];
 
    [self performSelector:@selector(delayBringSubViewToFont:) withObject:guke afterDelay:1.7];
    
}


-(void)startAniIRight
{
    rightCoverTimer = [NSTimer scheduledTimerWithTimeInterval:Animation_Duration_roll
                                                       target:self
                                                     selector:@selector(rightCoverDown)
                                                     userInfo:nil
                                                      repeats:YES];
    [rightCoverTimer fire];
    
    
}

-(void)startAniILeft
{
   leftCoverTimer = [NSTimer scheduledTimerWithTimeInterval:Animation_Duration_roll
                                                       target:self
                                                     selector:@selector(leftCoverDown)
                                                     userInfo:nil
                                                      repeats:YES];
    [leftCoverTimer fire];
  
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
     CGPoint offset = scrollViews.contentOffset;
    
    pageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"wooden_lt_page%d", (int)offset.y/683+1]];

    
    if(offset.y == 683)
    {
        
        [self startAniPage];
        
       
    }else{
        
//        qihua.alpha = 0;
//        shizuo.alpha = 0;
//        zhizao.alpha = 0;
//        xiaoshou.alpha = 0;
//        guke.alpha = 0;
//        [leftCOver setFrame:leftFrame];
//        [rightCover setFrame:rightFrame];
        
    }
    
    
    
}


- (UIScrollView*) creatScrollView:(CGRect)frame imageName:(NSString*)imgName
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:frame];
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    UIImage *img =  [UIImage imageNamed:imgName];
    scrollView.bounces = NO;
    [scrollView setShowsHorizontalScrollIndicator:NO];
    [scrollView setShowsVerticalScrollIndicator:NO];
    
    [scrollView setContentSize:CGSizeMake(img.size.width/2, 683*3)];
    
    scrollView.backgroundColor = [UIColor clearColor];
    
    UIImageView   *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, img.size.width/2, img.size.height/2)];
    imgView.image = img;
    // scollViewContent = scrollView;
    // [scollViewContent addSubview:imgView];
    [scrollView addSubview:imgView];
    
    return scrollView;
}


-(void)rightCoverDown
{
    
    if(rightCover.frame.origin.x>1024+600)return;
      float ySpan = rightCover.frame.origin.y+rollSpeed;
    
    [rightCover setFrame:CGRectMake(rightCover.frame.origin.x, ySpan, rightCover.frame.size.width, rightCover.frame.size.height)];
    
}
-(void)leftCoverDown
{
    if(rightCover.frame.origin.x<-1024)return;
    float ySpan = leftCOver.frame.origin.y-rollSpeed;
    
    [leftCOver setFrame:CGRectMake(leftCOver.frame.origin.x, ySpan, leftCOver.frame.size.width, leftCOver.frame.size.height)];
    
}


-(void)addImageViewForScrollView:(NSString *)imageName  pointY:(float)heigh
{
    UIImage *img = [UIImage imageNamed:imageName];
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, heigh, img.size.width/2, img.size.height/2)];
    imgView.image = img;
    
    [scrollViews addSubview:imgView];

}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
