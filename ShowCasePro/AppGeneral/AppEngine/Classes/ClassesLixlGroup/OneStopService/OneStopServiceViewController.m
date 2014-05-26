//
//  OneStopServiceViewController.m
//  ShowCasePro
//
//  Created by lvpw on 14-2-22.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "OneStopServiceViewController.h"
#import "UserGuideTips.h"
#define ScrollDuration 10


@interface OneStopServiceViewController () <iCarouselDataSource, iCarouselDelegate>

@property BOOL isChanging;
@property (strong, nonatomic) UIControl *currentControl;
@property (strong, nonatomic) NSMutableArray *imageViewState;
@property (strong, nonatomic) NSTimer *timer;
@property int num;

@end

@implementation OneStopServiceViewController

#pragma mark - iCarouselDelegate

- (CGFloat)carousel:(iCarousel *)_carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    switch (option)
    {
        case iCarouselOptionWrap:
        {
            return YES;
        }
        default:
        {
            return value;
        }
    }
}

#pragma mark - iCarouselDataSource

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return 5;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
//    UILabel *label = nil;
    
    if (view == nil)
    {
        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 580, 380)];
        ((UIImageView *)view).image = [UIImage imageNamed:[NSString stringWithFormat:@"ossscroll%d", index+1]];
        view.contentMode = UIViewContentModeScaleAspectFit;
//        label = [[UILabel alloc] initWithFrame:view.bounds];
//        label.backgroundColor = [UIColor clearColor];
//        label.textAlignment = NSTextAlignmentCenter;
//        label.font = [label.font fontWithSize:50];
//        label.tag = 1;
//        [view addSubview:label];
    }
    else
    {
//        label = (UILabel *)[view viewWithTag:1];
        ((UIImageView *)view).image = [UIImage imageNamed:[NSString stringWithFormat:@"ossscroll%d", index+1]];
    }
    
//    label.text = [NSString stringWithFormat:@"%d", index];
    
    return view;
}

#pragma mark - Util

- (UIImageView *)findImageViewInView:(UIView *)view
{
    for (UIView *subView in view.subviews) {
        if ([[subView class] isSubclassOfClass:[UIImageView class]]) {
            return (UIImageView *)subView;
        }
    }
    return nil;
}

- (void)changeImageUtil:(UIControl *)control
{
    if (![self.currentControl isEqual:control]) {
        self.currentControl = control;
    } else {
        self.currentControl = nil;
    }
    __block BOOL state = [self.imageViewState[control.tag-1] boolValue];
    UIImageView *imageView = [self findImageViewInView:control];
    UIImageView *imageView1, *imageView2;
    if (imageView.tag == 101) {
        imageView1 = imageView;
        imageView2 = [[UIImageView alloc] initWithFrame:imageView.frame];
        imageView2.image = [UIImage imageNamed:[NSString stringWithFormat:@"oss%dinfo", control.tag]];
        imageView2.tag = 102;
    } else {
        imageView2 = imageView;
        imageView1 = [[UIImageView alloc] initWithFrame:imageView.frame];
        imageView1.image = [UIImage imageNamed:[NSString stringWithFormat:@"oss%d", control.tag]];
        imageView1.tag = 101;
    }
    UIView *frontView = state ? imageView2 : imageView1;
    UIView *backView = state ? imageView1 : imageView2;
    
    UIViewAnimationOptions transitionDirection = state ? UIViewAnimationOptionTransitionFlipFromLeft : UIViewAnimationOptionTransitionFlipFromRight;
    [UIView transitionFromView:frontView toView:backView duration:0.5 options:transitionDirection completion:^(BOOL finished) {
        state = !state;
        [self.imageViewState replaceObjectAtIndex:control.tag-1 withObject:[NSNumber numberWithBool:state]];
        self.isChanging = NO;
    }];
}

#pragma mark - Handle Action

- (IBAction)fanpanAction:(UIControl *)control
{
    if (!self.isChanging) {
        if (self.currentControl != nil && ![control isEqual:self.currentControl]) {
            [self changeImageUtil:self.currentControl];
        }
        self.isChanging = YES;
        [self changeImageUtil:control];
    }
}

#pragma mark - Init

- (void)initData
{
    self.imageViewState = [NSMutableArray arrayWithArray:@[@NO, @NO, @NO, @NO, @NO, @NO, @NO, @NO, @NO, @NO]];
}

- (void)initControlShadow
{
    for (int i = 1; i <= 6; i++) {
        UIControl *control = (UIControl *)[self.view viewWithTag:i];
        control.layer.shadowPath = [UIBezierPath bezierPathWithRect:control.bounds].CGPath;
        control.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        control.layer.shadowOffset = CGSizeMake(2, 2);
        control.layer.shadowRadius = 2;
        control.layer.shadowOpacity = 1;
    }
}

- (void)initiADView
{
    self.carousel.type = iCarouselTypeLinear;
    self.carousel.backgroundColor = [UIColor colorWithRed:200/250. green:200/250. blue:200/250. alpha:1];
    self.carousel.scrollEnabled = NO;
    
    self.carousel.userInteractionEnabled = NO;//禁止用户操作
}

- (void)iADScroll
{
    
    //tips View
    UserGuideTips *userGuideTip = [UserGuideTips shareInstance];
    [userGuideTip showUserGuideView:self.view tipKey:@"oneStopService" imageNamePre:@"oneTopTipsImage"];
    //[self.carousel scrollToItemAtIndex:(self.carousel.currentItemIndex+1)%5 animated:YES];
    [self.carousel scrollToItemAtIndex:(self.carousel.currentItemIndex+1)%5 duration:ScrollDuration];
}

- (void)iADTimerFire
{
    [self iADScroll];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:ScrollDuration
                                                    target:self
                                                  selector:@selector(iADScroll)
                                                  userInfo:nil
                                                   repeats:YES];
}

#pragma mark - TwentyImageAnimation

- (void)twentyImageAnimation
{
    if (self.num == 3020) {
        [_timer invalidate];
        self.timer = nil;
        [self performSelector:@selector(twentyImageViewHide) withObject:nil afterDelay:0.3];
        return;
    }
    UIImageView *imageView = (UIImageView *)[self.twentyImageView viewWithTag:_num];
    [UIView animateWithDuration:0.2 animations:^{
        imageView.alpha = 1;
    }];
    _num++;
}

- (void)twentyImageViewHide
{
    [UIView animateWithDuration:0.3 animations:^{
        self.twentyImageView.alpha = 0;
    } completion:^(BOOL finished) {
        self.twentyImageView.hidden = YES;
        [self performSelector:@selector(iADTimerFire) withObject:nil afterDelay:0.5];
    }];
}

#pragma mark - Life Cycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self initData];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    [self initControlShadow];
    

    
    [self initiADView];
    // 创建
    _num = 3000;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                                  target:self
                                                selector:@selector(twentyImageAnimation)
                                                userInfo:nil
                                                 repeats:YES];
    //self.view.hidden = YES;
    
    self.searchModuleView.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.timer invalidate];
    self.carousel.hidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
