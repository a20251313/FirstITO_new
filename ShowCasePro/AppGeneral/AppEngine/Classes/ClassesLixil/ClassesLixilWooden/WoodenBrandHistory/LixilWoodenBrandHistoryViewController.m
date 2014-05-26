//
//  LixilWoodenBrandHistoryViewController.m
//  ShowCasePro
//
//  Created by Mac on 14-3-27.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "LixilWoodenBrandHistoryViewController.h"

@interface LixilWoodenBrandHistoryViewController ()
{
    UIImageView *imageView;
}
@property (nonatomic, strong) UIImageView *xian;
@property (nonatomic, strong) UIImage *nianchiImage;
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation LixilWoodenBrandHistoryViewController

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
    
    _nianchiImage = [UIImage imageNamed:@"wooden_bh_history"];
    UIImage *greImage = [UIImage imageNamed:@"gre"];
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 85, 1024, 683)];
    _scrollView = scrollView;
    scrollView.contentSize = CGSizeMake(_nianchiImage.size.width/2, _nianchiImage.size.height/2+1200*2+200);
    scrollView.bounces = YES;
    scrollView.scrollEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = YES;
    
    UIImageView *yuan = [[UIImageView alloc] initWithFrame:CGRectMake(462, 520, 87/2, 87/2)];
    yuan.image = [UIImage imageNamed:@"yuan1000"];
    [scrollView addSubview:yuan];
    
    [scrollView setContentOffset:CGPointMake(0, 200)];
    
    _xian = [[UIImageView alloc] initWithFrame:CGRectMake(481, 520, 2.3, 44)];
    _xian.image = [UIImage imageNamed:@"xiam"];
    _xian.contentMode = UIViewContentModeScaleToFill;
    [scrollView addSubview:_xian];
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 1200, 1024, _nianchiImage.size.height/2+1200)];
    imageView.image = _nianchiImage;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [scrollView addSubview:imageView];
    [self.view addSubview:scrollView];
    UIImageView *greImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 85, 1024, 683)];
    greImageView.image = greImage;
    [self.view addSubview:greImageView];
    
    imageView.hidden = YES;
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [UIView animateWithDuration:2 animations:^{
        _xian.frame = CGRectMake(481, 0, 2.3, 1000);
    } completion:^(BOOL finished) {
        imageView.hidden = NO;
        [_scrollView scrollRectToVisible:CGRectMake(0, 763, 1024, 700) animated:YES];
        _xian.frame = CGRectMake(481, 0, 2.3, _nianchiImage.size.height/2+3000);
        
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
