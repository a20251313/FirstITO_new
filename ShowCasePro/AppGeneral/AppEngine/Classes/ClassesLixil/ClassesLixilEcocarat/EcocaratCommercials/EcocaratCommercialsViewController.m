//
//  EcocaratCommercialsViewController.m
//  ShowCasePro
//
//  Created by Mac on 14-4-2.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "EcocaratCommercialsViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface EcocaratCommercialsViewController ()
{
    __weak IBOutlet UIView *bgView;
    __weak IBOutlet UIImageView *bgImage;
    __weak IBOutlet UIButton *playButton;
    
}

@property (strong, nonatomic) MPMoviePlayerController *mpcontroller;

@end

@implementation EcocaratCommercialsViewController

- (IBAction)playVideo
{
    NSString *videoPath = @"data/brandvideo/lixil/yikangjiashipin.mp4";
    NSString *url_client = [[LibraryAPI sharedInstance] downVideoByLink:videoPath
                                                                 inView:[UIApplication sharedApplication].keyWindow.rootViewController.view];

    if (url_client)
    {
        NSURL *url = [NSURL fileURLWithPath:url_client];

        [self initVideoViewWithURL:url];
    }
}

- (void)initVideoViewWithURL:(NSURL *)url
{
    MPMoviePlayerController *mpcontroller = [[MPMoviePlayerController alloc] initWithContentURL:url];
    [bgView addSubview:mpcontroller.view];
    mpcontroller.view.frame = bgView.bounds;
    mpcontroller.fullscreen = NO;
    mpcontroller.scalingMode = MPMovieScalingModeAspectFit;
    mpcontroller.shouldAutoplay = YES;
    self.mpcontroller = mpcontroller;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(videoFinish:) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(videoStataChange:) name:MPMoviePlayerNowPlayingMovieDidChangeNotification object:nil];
}

- (void)videoFinish:(NSNotification *)notification
{
    [self.mpcontroller.view removeFromSuperview];
    self.mpcontroller = nil;
    [self playAnimationWith:playButton withAlpha:1];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
}

-(void)playAnimationWith:(UIButton *)btn withAlpha:(CGFloat)value
{
    [UIView animateWithDuration:0.5f animations:^{
        [btn setAlpha:value];
    } completion:^(BOOL finished) {
        
    }];
}

- (void)videoStataChange:(NSNotification *)notification{
    
    [UIView animateWithDuration:0.5f animations:^{
        [playButton setAlpha:0];
    } completion:^(BOOL finished) {
        
    }];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:MPMoviePlayerLoadStateDidChangeNotification object:nil];
}


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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
