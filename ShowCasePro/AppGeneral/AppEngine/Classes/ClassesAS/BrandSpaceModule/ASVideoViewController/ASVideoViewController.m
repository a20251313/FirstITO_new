//
//  ASVideoViewController.m
//  ShowCasePro
//
//  Created by lvpw on 14-2-18.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "ASVideoViewController.h"
#import "Tvideo.h"
#import <MediaPlayer/MediaPlayer.h>
#import "LibraryAPI.h"

@interface ASVideoViewController ()<UIGestureRecognizerDelegate>
{
    UIImageView *switchButtonView;
}

@property (nonatomic, strong) Tvideo *currentVideo;

@property (strong, nonatomic) MPMoviePlayerController *mpcontroller;

// 增加视频切换操作
//@property (weak, nonatomic) IBOutlet UIView *controlBGView;
//
//@property (weak, nonatomic) IBOutlet UIImageView *imageView;
//
//@property (weak, nonatomic) IBOutlet UIView *jingjian_View;
//
//@property (weak, nonatomic) IBOutlet UIView *wanzheng_View;

@property (weak, nonatomic) IBOutlet UIView *switchButtonBackView;

@property (weak, nonatomic) IBOutlet UIButton *playBtn;


@end

@implementation ASVideoViewController

#pragma mark - Util

- (void)initVideoViewWithURL:(NSURL *)url
{
    MPMoviePlayerController *mpcontroller = [[MPMoviePlayerController alloc] initWithContentURL:url];
    [self.videoView addSubview:mpcontroller.view];
    mpcontroller.view.frame = self.videoView.bounds;
    mpcontroller.fullscreen = NO;
    mpcontroller.scalingMode = MPMovieScalingModeAspectFit;
    mpcontroller.shouldAutoplay = YES;
    self.mpcontroller = mpcontroller;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(videoFinish:) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(videoStataChange:) name:MPMoviePlayerNowPlayingMovieDidChangeNotification object:nil];
    
//    [self.videoView bringSubviewToFront:self.controlBGView];
#pragma warning -
    
}

#pragma mark - Handle Action

- (IBAction)playVideo:(id)sender {
    #warning -
//    NSString *url_client;
//    
//   if (_currentVideo)
//   {
//    url_client = [[LibraryAPI sharedInstance] downVideoByLink:self.currentVideo.video1 inView:[UIApplication sharedApplication].keyWindow.rootViewController.view];
//    if (url_client==nil) {
//        return;
//    }
//       
//   } else
//   {
//      NSString *videoPath = @"data/brandvideo/as/AS_neomodern.mp4";
//      url_client = [[LibraryAPI sharedInstance] downVideoByLink:videoPath inView:[UIApplication sharedApplication].keyWindow.rootViewController.view];
//   }
//    
//       
//    NSURL *url = [NSURL fileURLWithPath:url_client];
//    
//    [self initVideoViewWithURL:url];
    
}

- (void)changeVideo:(UITapGestureRecognizer *)sender {
    UIView *view_Tap = sender.view;
    Tvideo *video = [[Tvideo alloc] init];
    if (view_Tap.tag == 100) {
//        self.imageView.image = [UIImage imageNamed:@"video_item_jingjian"];
#warning -
        video.tvideoid = @"19";
        video.vname = @"骊住集团介绍";
        video.video1 = @"data/brandvideo/as/AS_neomodern.mp4";
        
        [self playAnimationWith:_playBtn withAlpha:1];
        
        
        
    } else {
        
#warning -
//        self.imageView.image = [UIImage imageNamed:@"video_item_wanzheng"];
        video.tvideoid = @"19";
        video.vname = @"骊住集团介绍";
        video.video1 = @"data/brandvideo/as/AS_nobile-0820.mp4";
        [self playAnimationWith:_playBtn withAlpha:1];
    }
    self.currentVideo = video;
    if (self.mpcontroller != nil) {
        self.videoImage.image = [UIImage imageNamed:@"video_Bg"];
        [self.mpcontroller stop];
        [self.mpcontroller.view removeFromSuperview];
        self.mpcontroller = nil;
        [[NSNotificationCenter defaultCenter]removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    }
  //  self.videoImage.image = [[LibraryAPI sharedInstance] getImageFromPath:self.currentVideo.video3 scale:2];
    
}

- (void)videoFinish:(NSNotification *)notification{
    [self.mpcontroller.view removeFromSuperview];
    self.mpcontroller = nil;
    [[NSNotificationCenter defaultCenter]removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
}

#pragma mark - Life Cycle

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
   //注册View 点击事件
    UITapGestureRecognizer *jingjianView_Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeVideo:)];
    jingjianView_Tap.numberOfTapsRequired = 1;
    jingjianView_Tap.numberOfTouchesRequired = 1;
#warning -
//    [self.jingjian_View addGestureRecognizer:jingjianView_Tap];
    
    UITapGestureRecognizer *wanzhengView_Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeVideo:)];
    wanzhengView_Tap.numberOfTapsRequired = 1;
    wanzhengView_Tap.numberOfTouchesRequired = 1;
#warning -
//    [self.wanzheng_View addGestureRecognizer:wanzhengView_Tap];
    
    //添加滑动手势
    UISwipeGestureRecognizer *jingjianView_Swipe;
    jingjianView_Swipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    jingjianView_Swipe.delegate =self ;
    [jingjianView_Swipe setDirection:(UISwipeGestureRecognizerDirectionRight)];
#warning -
//    [self.jingjian_View addGestureRecognizer:jingjianView_Swipe];

    UISwipeGestureRecognizer *wanzhengView_Swipe;
    wanzhengView_Swipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    wanzhengView_Swipe.delegate =self ;
    [wanzhengView_Swipe setDirection:(UISwipeGestureRecognizerDirectionLeft)];
#warning -
//    [self.wanzheng_View addGestureRecognizer:wanzhengView_Swipe];

    
    
    
    //////////////选择视频按钮初始化
    self.switchButtonBackView.clipsToBounds = YES;
    self.switchButtonBackView.backgroundColor = [UIColor clearColor];
    self.switchButtonBackView.layer.cornerRadius = 10;
//    self.switchButtonBackView.layer.borderWidth = 1;
//    self.switchButtonBackView.layer.borderColor = [UIColor darkGrayColor].CGColor;
    
    UIImage *buttonImage = [UIImage imageNamed:@"av_switch_button"];
    switchButtonView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -5, buttonImage.size.width/2,buttonImage.size.height/2)];
    switchButtonView.image = buttonImage;
    switchButtonView.userInteractionEnabled = YES;
    [self.switchButtonBackView addSubview:switchButtonView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(switchButton:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [switchButtonView addGestureRecognizer:tap];
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(switchButton:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [switchButtonView addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(switchButton:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [switchButtonView addGestureRecognizer:swipeRight];
}


#pragma mark - 按钮选择方法 -

-(void)switchButton:(id)sender
{
    if ([sender isKindOfClass:[UITapGestureRecognizer class]])
    {
        //点击手势  切换视频
        [self changeVideo];
    }
    else if([sender isKindOfClass:[UISwipeGestureRecognizer class]])
    {
        //滑动手势  切换视频
        UISwipeGestureRecognizer *swipe = (UISwipeGestureRecognizer *)sender;
        
        if (swipe.direction == UISwipeGestureRecognizerDirectionLeft && !switchButtonView.frame.origin.x)
        {
            [self changeVideo];
        }
        else if (swipe.direction == UISwipeGestureRecognizerDirectionRight && switchButtonView.frame.origin.x < 0)
        {
            [self changeVideo];
        }
        
    }
}

-(void)changeVideo
{
    //切换当前视频
     Tvideo *video = [[Tvideo alloc] init];
    
    if (!switchButtonView.frame.origin.x)
    {
        //当前是精简版
        
        
        [UIView animateWithDuration:0.3 animations:^
         {
             CGRect frame = switchButtonView.frame;
             frame.origin.x -= 50;
             switchButtonView.frame = frame;
         }];
        
         video.video1 = @"data/brandvideo/as/AS_nobile-0820.mp4";
        
    }
    else
    {
        //当前是完整版
        
        [UIView animateWithDuration:0.3 animations:^
         {
             CGRect frame = switchButtonView.frame;
             frame.origin.x = 0;
             switchButtonView.frame = frame;
     
         
         }];
    
        video.video1 = @"data/brandvideo/as/AS_neomodern.mp4";
        
    }
    
    video.tvideoid = @"19";
    video.vname = @"骊住集团介绍";
    
   [self playAnimationWith:self.playBtn withAlpha:1];
   
     self.currentVideo = video;
     if (self.mpcontroller != nil) {
         self.videoImage.image = [UIImage imageNamed:@"video_Bg"];
         [self.mpcontroller stop];
         [self.mpcontroller.view removeFromSuperview];
         self.mpcontroller = nil;
         [[NSNotificationCenter defaultCenter]removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    
   }

   
}


-(void)playAnimationWith:(UIButton *)btn withAlpha:(CGFloat)value
{
    [UIView animateWithDuration:0.5f animations:^{
        [btn setAlpha:value];
    } completion:^(BOOL finished) {
        
    }];
}

-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)sender
{
#warning -
//    
//     Tvideo *video = [[Tvideo alloc] init];
//    
//    if ([sender.view isEqual:self.jingjian_View])
//    {
//        if (sender.direction == UISwipeGestureRecognizerDirectionRight)
//        {
//            self.imageView.image = [UIImage imageNamed:@"video_item_wanzheng"];
//            
//            self.imageView.image = [UIImage imageNamed:@"video_item_wanzheng"];
//            video.tvideoid = @"19";
//            video.vname = @"骊住集团介绍";
//            video.video1 = @"data/brandvideo/as/AS_nobile-0820.mp4";
//
//            
//        }
//        
//        
//    } else {
//       
//        if (sender.direction == UISwipeGestureRecognizerDirectionLeft)
//        {
//            self.imageView.image = [UIImage imageNamed:@"video_item_jingjian"];
//            
//            self.imageView.image = [UIImage imageNamed:@"video_item_jingjian"];
//            video.tvideoid = @"19";
//            video.vname = @"骊住集团介绍";
//            video.video1 = @"data/brandvideo/as/AS_neomodern.mp4";
//            
//           
//            
//        }
//    }
//     [self playAnimationWith:_playBtn withAlpha:1];
//    
//    self.currentVideo = video;
//    if (self.mpcontroller != nil) {
//        self.videoImage.image = [UIImage imageNamed:@"video_Bg"];
//        [self.mpcontroller stop];
//        [self.mpcontroller.view removeFromSuperview];
//        self.mpcontroller = nil;
//        [[NSNotificationCenter defaultCenter]removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
//    
//    
//    }
}

    

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)videoStataChange:(NSNotification *)notification{
   
    [UIView animateWithDuration:0.5f animations:^{
        [self.playBtn setAlpha:0];
    } completion:^(BOOL finished) {
        
    }];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:MPMoviePlayerLoadStateDidChangeNotification object:nil];
}


@end
