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
    __weak IBOutlet UIImageView *switchButtonImageView;
    
}

@property (nonatomic, strong) Tvideo *currentVideo;

@property (strong, nonatomic) MPMoviePlayerController *mpcontroller;

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
}

#pragma mark - Handle Action

- (IBAction)playVideo:(id)sender
{
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
//    if (url_client)
//    {
//        NSURL *url = [NSURL fileURLWithPath:url_client];
//        
//        [self initVideoViewWithURL:url];
//    }
    
    NSString *urlPath;
    
    if (_currentVideo)
    {
        urlPath = self.currentVideo.video1;
        
        if (urlPath==nil) {
            return;
        }
        
    } else
    {
        urlPath = [[NSBundle mainBundle] pathForResource:@"AS_neomodern" ofType:@"mp4"];
    }
    
    if (urlPath)
    {
        NSURL *url = [NSURL fileURLWithPath:urlPath];
        
        [self initVideoViewWithURL:url];
    }
}


- (void)videoFinish:(NSNotification *)notification
{
    [self.mpcontroller.view removeFromSuperview];
    self.mpcontroller = nil;
    [self playAnimationWith:self.playBtn withAlpha:1];
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
}

- (IBAction)s15Touched:(id)sender
{
    switchButtonImageView.image = [UIImage imageNamed:@"av_15s"];
    
    Tvideo *video = [[Tvideo alloc] init];
    video.video1 = [[NSBundle mainBundle] pathForResource:@"AS_neomodern" ofType:@"mp4"];
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

- (IBAction)s30Touched:(id)sender
{
    switchButtonImageView.image = [UIImage imageNamed:@"av_30s"];
    
    Tvideo *video = [[Tvideo alloc] init];
    video.video1 = [[NSBundle mainBundle] pathForResource:@"AS_nobile-0820" ofType:@"mp4"];
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
