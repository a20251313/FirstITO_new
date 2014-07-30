//
//  LiXilEcocaratVideoViewController.m
//  ShowCasePro
//
//  Created by joshon on 14-2-18.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "LiXilWoodlenVideoViewController.h"
#import "Tvideo.h"
#import <MediaPlayer/MediaPlayer.h>
#import "LibraryAPI.h"

@interface LiXilWoodlenVideoViewController ()<UIGestureRecognizerDelegate>
{
    //__weak IBOutlet UIImageView *switchButtonImageView;
    __weak IBOutlet UIView *switchButtonBgView;
    
}

@property (nonatomic, strong) Tvideo *currentVideo;

@property (strong, nonatomic) MPMoviePlayerController *mpcontroller;

@property (weak, nonatomic) IBOutlet UIButton *playBtn;


@end

@implementation LiXilWoodlenVideoViewController

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
    [self.view bringSubviewToFront:mpcontroller.view];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(videoFinish:) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(videoStataChange:) name:MPMoviePlayerNowPlayingMovieDidChangeNotification object:nil];
}

#pragma mark - Handle Action

- (IBAction)playVideo:(id)sender
{

    
    
    
    NSString *urlPath;
    
    urlPath = [[NSBundle mainBundle] pathForResource:@"lixiwoodlen" ofType:@"mp4"];
    NSURL *url = [NSURL fileURLWithPath:urlPath];
    [self initVideoViewWithURL:url];
    
    return;
    if (_currentVideo)
    {
        urlPath = self.currentVideo.video1;
        
        if (urlPath==nil) {
            return;
        }
        
    } else
    {
     
        return;
        
        [self playPathVideo:@"data/brandvideo/lixilgroup/yikangjiazhidao.mp4"];
        [self.view bringSubviewToFront:self.mpcontroller.view];
        return;
       // urlPath = [[NSBundle mainBundle] pathForResource:@"AS_neomodern" ofType:@"mp4"];
    }
    
    if (urlPath)
    {
        NSURL *url = [NSURL fileURLWithPath:urlPath];
        
        [self initVideoViewWithURL:url];
    }
}


-(void)playPathVideo:(NSString*)videoPath
{
    
    
   // NSString *videoPath = @"data/brandvideo/lixil/yikangjiashipin.mp4";
    NSString *url_client = [[LibraryAPI sharedInstance] downVideoByLink:videoPath
                                                                 inView:[UIApplication sharedApplication].keyWindow.rootViewController.view];
    
    if (url_client)
    {
        NSURL *url = [NSURL fileURLWithPath:url_client];
        
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




-(void)playAnimationWith:(UIButton *)btn withAlpha:(CGFloat)value
{
    [UIView animateWithDuration:0.5f animations:^{
        [btn setAlpha:value];
    } completion:^(BOOL finished) {
        
    }];
}

-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)sender
{

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

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
