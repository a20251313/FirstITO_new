//
//  ASHistoryViewController.m
//  ShowCasePro
//
//  Created by lvpw on 14-2-20.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "ASHistoryViewController.h"
#define Duration 0.8
@interface ASHistoryViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *shinePoint;
@property (weak, nonatomic) IBOutlet UIImageView *quan;
@property (strong, nonatomic) UIImageView *historyImageViewOut;
@property (strong, nonatomic) UIImageView *historyImageViewIn;
@property (strong, nonatomic) UIImageView *historyDecImageViewOut;
@property (strong, nonatomic) UIImageView *historyDecImageViewIn;
@property (nonatomic, readonly) CGRect historyImageFrameOut;
@property (nonatomic, readonly) CGRect historyImageFrameOutLeft;
@property (nonatomic, readonly) CGRect historyImageFrameIn;
@property (nonatomic, readonly) CGRect historyDecImageFrameOut;
@property (nonatomic, readonly) CGRect historyDecImageFrameOutRight;
@property (nonatomic, readonly) CGRect historyDecImageFrameIn;
@property (nonatomic) BOOL currentInOrOut; // yes is in, no is out
@property (nonatomic) BOOL isAnimation;

@end

@implementation ASHistoryViewController

#pragma mark - override

- (CGRect)historyDecImageFrameIn
{
    return CGRectMake(515, 50, 576, 531);
}

- (CGRect)historyDecImageFrameOut
{
    return CGRectMake(-515, 50, 576, 531);
}

- (CGRect)historyDecImageFrameOutRight
{
    return CGRectMake(1024, 50, 576, 531);
}

- (CGRect)historyImageFrameIn
{
    return CGRectMake(515, 50, 576, 531);
}

- (CGRect)historyImageFrameOut
{
    return CGRectMake(1024, 50, 576, 531);
}

- (CGRect)historyImageFrameOutLeft
{
    return CGRectMake(-515, 50, 576, 531);
}

#pragma mark - Handle Action

- (IBAction)historyButtonAction:(UIButton *)sender {
    if (self.isAnimation) return;
    self.isAnimation = YES;
    NSInteger tag = sender.tag;
    self.quan.center = sender.center;
    self.shinePoint.center = sender.center;
    self.quan.bounds = CGRectZero;
    self.shinePoint.bounds = CGRectZero;
    [UIView animateWithDuration:Duration animations:^{
        self.quan.bounds = CGRectMake(0, 0, 123, 123);
        self.shinePoint.bounds = CGRectMake(0, 0, 47, 47);
    }];
    if (self.currentInOrOut) {
        self.historyImageViewOut.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d-lishi", tag]];
        self.historyDecImageViewOut.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d-lishi-dec", tag]];
        [UIView animateWithDuration:Duration animations:^{
            self.historyDecImageViewOut.frame = self.historyDecImageFrameIn;
            self.historyDecImageViewIn.frame = self.historyDecImageFrameOutRight;
            self.historyImageViewIn.frame = self.historyImageFrameOutLeft;
            self.historyImageViewOut.frame = self.historyImageFrameIn;
        } completion:^(BOOL finished) {
            self.historyImageViewIn.frame = self.historyImageFrameOut;
            self.historyDecImageViewIn.frame = self.historyDecImageFrameOut;
        }];
    } else {
        self.historyImageViewIn.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d-lishi", tag]];
        self.historyDecImageViewIn.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d-lishi-dec", tag]];
        [UIView animateWithDuration:Duration animations:^{
            self.historyDecImageViewOut.frame = self.historyDecImageFrameOutRight;
            self.historyDecImageViewIn.frame = self.historyDecImageFrameIn;
            self.historyImageViewIn.frame = self.historyImageFrameIn;
            self.historyImageViewOut.frame = self.historyImageFrameOutLeft;
        } completion:^(BOOL finished) {
            self.historyDecImageViewOut.frame = self.historyDecImageFrameOut;
            self.historyImageViewOut.frame = self.historyImageFrameOut;
        }];
    }
    self.currentInOrOut = !self.currentInOrOut;
    self.isAnimation = NO;
}

- (void)chushihuaImageView
{
    self.historyImageViewIn = [[UIImageView alloc] initWithFrame:self.historyImageFrameIn];
    self.historyImageViewIn.image = [UIImage imageNamed:@"1872-lishi"];
    self.historyDecImageViewIn = [[UIImageView alloc] initWithFrame:self.historyDecImageFrameIn];
    self.historyDecImageViewIn.image = [UIImage imageNamed:@"1872-lishi-dec"];
    self.historyImageViewOut = [[UIImageView alloc] initWithFrame:self.historyImageFrameOut];
    self.historyDecImageViewOut = [[UIImageView alloc] initWithFrame:self.historyDecImageFrameOut];
    [self.view insertSubview:self.historyDecImageViewIn aboveSubview:[self.view viewWithTag:6000]];
    [self.view insertSubview:self.historyDecImageViewOut aboveSubview:[self.view viewWithTag:6000]];
    [self.view insertSubview:self.historyImageViewIn aboveSubview:[self.view viewWithTag:6000]];
    [self.view insertSubview:self.historyImageViewOut aboveSubview:[self.view viewWithTag:6000]];
    self.currentInOrOut = YES;
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
    [self chushihuaImageView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
