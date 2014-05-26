//
//  InspirationViewController.m
//  ShowCasePro
//
//  Created by yczx on 14-1-21.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "InspirationViewController.h"
#import "CoreAnimationEffect.h"

#import "UIViewController+CWPopup.h"
#import "SuiteIntroduceViewController.h"
#import "DatabaseOption+Suites.h"
#import "Suites.h"
#import "ModueSpaceViewController.h"


@interface InspirationViewController ()<UIGestureRecognizerDelegate>

// 背景滚动timer
@property (nonatomic, strong) NSTimer *timer;

// 背景滚动timer
@property (nonatomic, strong) NSTimer *starTimer;

// 随机闪烁timer
@property (nonatomic, strong) NSTimer *otherStarTimer;



// 背景滚动数据
@property (nonatomic , strong) NSArray *bannerImageArray;

// 星盘图层
@property (weak, nonatomic) IBOutlet UIView *starSpaceBG;

// 弹出视图
@property (strong, nonatomic) IBOutlet UIView *popView;


// 当前选中的空间
@property(strong,nonatomic) UIButton *currentBtn;

@end

@implementation InspirationViewController

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
    
    //[self initData];
    
   // self.timer = [NSTimer scheduledTimerWithTimeInterval:0.2f target:self selector:@selector(autoScroll) userInfo:nil repeats:YES];
    
    self.starTimer = [NSTimer scheduledTimerWithTimeInterval:8.0f target:self selector:@selector(autoStar) userInfo:nil repeats:YES];
    
     self.otherStarTimer = [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(autoOtherStarAnimation) userInfo:nil repeats:YES];

    
    
    //添加滑动手势
    UISwipeGestureRecognizer *jingjianView_Swipe;
    jingjianView_Swipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    jingjianView_Swipe.delegate =self ;
    [jingjianView_Swipe setDirection:(UISwipeGestureRecognizerDirectionUp)];
    [self.popView addGestureRecognizer:jingjianView_Swipe];
 
    //添加滑动手势
    UISwipeGestureRecognizer *jingjianView_SwipeLeft;
    jingjianView_SwipeLeft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    jingjianView_SwipeLeft.delegate =self ;
    [jingjianView_SwipeLeft setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [self.popView addGestureRecognizer:jingjianView_SwipeLeft];
    
    //添加滑动手势
    UISwipeGestureRecognizer *jingjianView_SwipeRight;
    jingjianView_SwipeRight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    jingjianView_SwipeRight.delegate =self ;
    [jingjianView_SwipeRight setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [self.popView addGestureRecognizer:jingjianView_SwipeRight];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [self.popView addGestureRecognizer:tap];
}



-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)sender
{
    if ([sender.view isEqual:self.popView])
    {
          [UIView animateWithDuration:0.25f animations:^
        {
              self.popView.alpha = 0;
              
          } completion:^(BOOL finished) {
              
             [self.popView removeFromSuperview];
              
              [CoreAnimationEffect animationWIthRoationBackAndSclaeBack:self.currentBtn];
              
          }];
    }
}




-(IBAction)starBtnEvent:(UIButton *)sender
{
//     SuiteIntroduceViewController *PopupViewController = [[SuiteIntroduceViewController alloc] initWithNibName:@"SuiteIntroduceViewController" bundle:nil];
//    PopupViewController.suiteID = [NSString stringWithFormat:@"%d",sender.tag];
//    
//    [self presentPopupViewController:PopupViewController animated:YES completion:^(void) {
//        NSLog(@"popup view presented");
//    }];
    
    // 重新填充popView 的值
    DatabaseOption *dbo = [[DatabaseOption alloc] init];
    
    Suites *suites = [dbo getSuiteBysuiteid:[NSString stringWithFormat:@"%d",sender.tag]];
    
    // 取出 滚动视图 和 图片视图
    UIScrollView *scrollView = (UIScrollView *)[self.popView viewWithTag:1];
    UIImageView *imageView = (UIImageView *)[self.popView viewWithTag:2];
    for (NSObject *obj in scrollView.subviews) {
    
        UIImageView *image = (UIImageView *)obj;
        [image removeFromSuperview];
    }
    
    // 加载内容视图到ScrollView
    NSString *contentPath = [NSString stringWithFormat:@"%@/%@",kLibrary,suites.video1];
    UIImage *imageContent = [UIImage imageWithContentsOfFile:contentPath];
    
    UIImageView *bgView = [[UIImageView alloc] initWithImage:imageContent];
    [bgView setFrame:CGRectMake(0, 0, imageContent.size.width/2, imageContent.size.height/2)];
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(5, 5, bgView.frame.size.width, bgView.frame.size.height+50)];
    [contentView addSubview:bgView];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(bgView.frame.size.width-80, bgView.bounds.size.height+6, 60, 44)];
    [button setTitle:@"查看更多" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    button.tag = sender.tag;
    [button addTarget:self action:@selector(tiaozhuanCollection:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:button];
    
    [scrollView addSubview:contentView];
    [scrollView setContentSize:CGSizeMake(imageContent.size.width /2, imageContent.size.height /2 + 60)];
    
    // 加载图片视图到图片
    NSString *imagePath = [NSString stringWithFormat:@"%@/%@",kLibrary,suites.video2];
    UIImage *imageSuite = [UIImage imageWithContentsOfFile:imagePath];
    
    imageView.image = imageSuite;
    

    [CoreAnimationEffect animationWIthRoationAndSclae:sender];
    
    [self performSelector:@selector(whiteQuan:) withObject:sender afterDelay:0.4f];
    
    [self performSelector:@selector(popViewData:) withObject:sender afterDelay:1.5f];
}

- (void)whiteQuan:(UIView *)view
{
    UIImageView *imageView = (UIImageView *)[self.view viewWithTag:8888];
    imageView.center = view.center;
    imageView.hidden = NO;
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI*2];
    rotationAnimation.duration = 3.0f;
    [imageView.layer addAnimation:rotationAnimation forKey:nil];
    [self performSelector:@selector(imageViewHidden) withObject:nil afterDelay:3.0];
}

- (void)imageViewHidden
{
    UIImageView *imageView = (UIImageView *)[self.view viewWithTag:8888];
    imageView.hidden = YES;
}

-(void)popViewData:(UIButton *)sender
{
    if (![_popView superview])
    {
        
        [self.view addSubview:self.popView];
        
        [self.popView setAlpha:0];
        
        [self.popView setCenter:CGPointMake(1024 /2, 768/2)];
        
        [UIView animateWithDuration:0.5f animations:^{
            
            [self.popView setAlpha:1];
            
        } completion:^(BOOL finished) {
            
            self.currentBtn = sender;
            
        }];
        
    }
}



// 重写set方法
- (void)setBannerImageArray:(NSArray *)bannerImageArray
{
    _bannerImageArray = bannerImageArray;
  //  [self initView];
}


/*
// 初始化背景滚动视图数据
- (void)initData
{
    NSArray *imageArray = [NSArray arrayWithObjects:
                           [UIImage imageNamed:@"Imageframe1.jpg"],
                           [UIImage imageNamed:@"Imageframe1.jpg"],
                           nil];
    
    self.bannerImageArray = imageArray;
}

// 初始化背景滚动视图
- (void)initView
{
    int imageCount = [self.bannerImageArray count];
    
    if (self.bannerImageArray && imageCount)
    {
        for (int i = 0 ; i < imageCount ; i++)
        {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(1024*i, 0, 1024, _inspiration_BG.frame.size.height)];
            imageView.image = self.bannerImageArray[i];
            [_inspiration_BG addSubview:imageView];
        }
        
        _inspiration_BG.contentSize = CGSizeMake(_inspiration_BG.frame.size.width*self.bannerImageArray.count, _inspiration_BG.frame.size.height);
        [self.view addSubview:_inspiration_BG];
        [self.timer fire];
    }
    
    [self.view bringSubviewToFront:self.starSpaceBG];
}

// 背景自动滚动方法
- (void) autoScroll
{
    CGPoint contentOffSet = _inspiration_BG.contentOffset;
    contentOffSet.x += 5;
    [_inspiration_BG setContentOffset:contentOffSet animated:YES];
    
    if (contentOffSet.x >=1024)
    {
        contentOffSet.x=0;
        [_inspiration_BG setContentOffset:contentOffSet animated:NO];
    }
    
}

 
 */

// 设置星盘上每个点动画
-(void)autoStar
{
    UIButton *starBtn = nil;
    starBtn = (UIButton *)[self.view viewWithTag:1];
    //[CoreAnimationEffect animationWithSclarAndFadeOut:starBtn];
    [CoreAnimationEffect animationWithFlicker:starBtn];
    
    
    starBtn = (UIButton *)[self.view viewWithTag:2];
    //[CoreAnimationEffect animationWithSclarAndFadeOut:starBtn];
    [CoreAnimationEffect animationWithFlicker:starBtn];
    
    
    starBtn = (UIButton *)[self.view viewWithTag:15];
    //[CoreAnimationEffect animationWithSclarAndFadeOut:starBtn];
    [CoreAnimationEffect animationWithFlicker:starBtn];
    
}

// 随机让星星闪烁
-(void)autoOtherStarAnimation
{
    int index = arc4random()%15 + 1;
    UIButton *starBtn = nil;
    starBtn = (UIButton *)[self.view viewWithTag:index];
  //  [CoreAnimationEffect animationWithSclarAndFadeOut:starBtn];
    
    if (starBtn)
    {
      
        [CoreAnimationEffect animationWithFlicker:starBtn];
    }
    
}




// 关闭弹出视图
- (void)dismissPopup {
    if (self.popupViewController != nil) {
        [self dismissPopupViewControllerAnimated:YES completion:^{
            NSLog(@"popup view dismissed");
           // [_PopupViewController removeFromParentViewController];
        }];
    }
}

#pragma mark - Handle Action

- (void)tiaozhuanCollection:(UIButton *)sender
{
    ModueSpaceViewController *spaceViewController = [[ModueSpaceViewController alloc] initWithNibName:@"ModueSpaceViewController" bundle:nil];
    spaceViewController.brandID = [[LibraryAPI sharedInstance] currentBrandID];
    spaceViewController.suiteID = [NSString stringWithFormat:@"%d", sender.tag];
    
    [self.navigationController pushViewController:spaceViewController animated:NO];
}

#pragma mark - gesture recognizer delegate functions

// so that tapping popup view doesnt dismiss it
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    return touch.view != self.popupViewController.view;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
