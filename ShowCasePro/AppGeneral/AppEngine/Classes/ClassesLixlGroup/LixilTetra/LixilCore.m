//
//  LixilCore.m
//  LixilCore
//
//  Created by Mac on 14-2-23.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import "LixilCore.h"

#define AnimationDuration 0.5

#define LixilWayTag     101
#define LixilValueTag   102
#define LixilVisionTag  103

@interface LixilCore ()
{
    
    __weak IBOutlet UIImageView *lixilWay;
    
    __weak IBOutlet UIImageView *lixilValue;
    
    __weak IBOutlet UIImageView *lixilVision;
    
    
    UIImageView *lixilWayBall;
    UIImageView *lixilValueBall;
    UIImageView *lixilVisionBall;
}


@property (nonatomic , strong) UIImageView *currentBall;

@property (nonatomic , strong) NSTimer *rotateTimer;

@end

@implementation LixilCore


#pragma mark - user operation -


-(void)selectBall:(UITapGestureRecognizer *)tap
{
    int tag = tap.view.tag;
    
    if (tag == LixilWayTag)
    {
        self.currentBall = lixilWayBall;
    }
    else if (tag == LixilValueTag)
    {
        self.currentBall = lixilValueBall;
    }
    else if (tag == LixilVisionTag)
    {
        self.currentBall = lixilVisionBall;
    }
}



//旋转当前选中的球
- (void) rotateBall
{
    static int wayCount     = 1;
    static int valueCount   = 1;
    static int visionCount  = 1;
    
    if (self.currentBall)
    {
        [UIView animateWithDuration:AnimationDuration-0.05 delay:0 options:UIViewAnimationOptionCurveLinear animations:^
         {
             if (self.currentBall == lixilWayBall)
             {
                 self.currentBall.transform = CGAffineTransformMakeRotation(M_PI_4 / 2 * wayCount);
             }
             else if (self.currentBall == lixilValueBall)
             {
                 self.currentBall.transform = CGAffineTransformMakeRotation(M_PI_4 / 2 * valueCount);
             }
             else if (self.currentBall == lixilVisionBall)
             {
                 self.currentBall.transform = CGAffineTransformMakeRotation(M_PI_4 / 2 * visionCount);
             }
             
         } completion:^(BOOL finished)
         {
             if (self.currentBall == lixilWayBall)
             {
                 wayCount++;
             }
             else if (self.currentBall == lixilValueBall)
             {
                 valueCount++;
             }
             else if (self.currentBall == lixilVisionBall)
             {
                 visionCount++;
             }
         }];
    }
}


#pragma mark - life cycle -

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
    
    
    self.rotateTimer = [NSTimer scheduledTimerWithTimeInterval:AnimationDuration
                                                          target:self
                                                        selector:@selector(rotateBall)
                                                        userInfo:nil
                                                         repeats:YES];
    [self.rotateTimer fire];
    self.currentBall = nil;
    
    lixilWayBall    = [self creatImageViewWithFrame:CGRectMake(433, 183, 72, 72)];
    lixilValueBall  = [self creatImageViewWithFrame:CGRectMake(281, 439, 72, 72)];
    lixilVisionBall = [self creatImageViewWithFrame:CGRectMake(588, 439, 72, 72)];
    
    lixilWayBall.tag    = LixilWayTag;
    lixilValueBall.tag  = LixilValueTag;
    lixilVisionBall.tag = LixilVisionTag;
    
    [self.view bringSubviewToFront:lixilWay];
    [self.view bringSubviewToFront:lixilValue];
    [self.view bringSubviewToFront:lixilVision];
}

- (UIImageView *) creatImageViewWithFrame:(CGRect)frame
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.image = [UIImage imageNamed:@"lc_core_ball"];
    imageView.userInteractionEnabled = YES;
    [self addGestureWithView:imageView];
    [self.view addSubview:imageView];
    [self.view bringSubviewToFront:imageView];
    return imageView;
}

- (void) addGestureWithView:(UIView *)view
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectBall:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [view addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
