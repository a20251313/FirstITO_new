//
//  LixilHistoryViewController.m
//  ShowCasePro
//
//  Created by lvpw on 14-2-22.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "LixilHistoryViewController.h"

@interface LixilHistoryViewController ()
{
    UIImageView *imageView;
}

@property (nonatomic, strong) UIImageView *xian;
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation LixilHistoryViewController

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
    
    self.searchModuleView.hidden = YES;
    
    UIImage *nianchiImage = [UIImage imageNamed:@"nianchichang"];
    UIImage *greImage = [UIImage imageNamed:@"gre"];
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 85, 1024, 683)];
    _scrollView = scrollView;
    scrollView.contentSize = CGSizeMake(nianchiImage.size.width/2, nianchiImage.size.height/2+483);
    scrollView.bounces = YES;
    scrollView.scrollEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = YES;
    
    UIImageView *yuan = [[UIImageView alloc] initWithFrame:CGRectMake(510, 520, 87/2, 87/2)];
    yuan.image = [UIImage imageNamed:@"yuan1000"];
    [scrollView addSubview:yuan];
    
    [scrollView setContentOffset:CGPointMake(0, 200)];
    
    _xian = [[UIImageView alloc] initWithFrame:CGRectMake(529, 520, 2, 43.5)];
    _xian.image = [UIImage imageNamed:@"xiam"];
    _xian.contentMode = UIViewContentModeScaleToFill;
    [scrollView addSubview:_xian];
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 683, 1024, nianchiImage.size.height/2)];
    imageView.image = nianchiImage;
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
        _xian.frame = CGRectMake(529, 0, 2, 883);
    } completion:^(BOOL finished) {
        imageView.hidden = NO;
        [_scrollView scrollRectToVisible:CGRectMake(0, 683, 1024, 683) animated:YES];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
