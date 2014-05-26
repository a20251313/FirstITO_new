//
//  LixilGroupInfoViewController.m
//  ShowCasePro
//
//  Created by lvpw on 14-2-23.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "LixilGroupInfoViewController.h"

@interface LixilGroupInfoViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIImageView *page;

@end

@implementation LixilGroupInfoViewController

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.tag == 2) {
        CGPoint offset = scrollView.contentOffset;
        self.page.image = [UIImage imageNamed:[NSString stringWithFormat:@"lixilgroupinfopage%d", (int)offset.y/511+2]];
    } else {
        CGPoint offset = scrollView.contentOffset;
        self.page.image = [UIImage imageNamed:[NSString stringWithFormat:@"lixilgroupinfopage%d", (int)offset.y/683+1]];
    }
    
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
    
    self.searchModuleView.hidden = YES;
    
    // Do any additional setup after loading the view from its nib.
    UIScrollView *outScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 85, 1024, 683)];
    outScrollView.contentSize = CGSizeMake(1024, 1366);
    outScrollView.backgroundColor = [UIColor colorWithRed:200/250. green:200/250. blue:200/250. alpha:1];
    outScrollView.pagingEnabled = YES;
    outScrollView.showsHorizontalScrollIndicator = NO;
    outScrollView.showsVerticalScrollIndicator = NO;
    outScrollView.bounces = NO;
    outScrollView.delegate = self;
    outScrollView.tag = 1;
    outScrollView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0);
    
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1024, 683)];
    imageView1.image = [UIImage imageNamed:@"lixilgroupinfoimage0"];
//    UIImageView *page0 = [[UIImageView alloc] initWithFrame:CGRectMake(892, 553, 69/2, 185/2)];
//    page0.image = [UIImage imageNamed:@"lixilgroupinfopage1"];
//    [imageView1 addSubview:page0];
    UIImageView *imageViewTingliu = [[UIImageView alloc] initWithFrame:CGRectMake(0, 684, 1024, 172)];
    imageViewTingliu.image = [UIImage imageNamed:@"lixilgroupinfotingliu"];
    [outScrollView addSubview:imageView1];
    [outScrollView addSubview:imageViewTingliu];
    [self.view addSubview:outScrollView];
    
    UIScrollView *inScrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 855, 1024, 511)];
    inScrollview.contentSize = CGSizeMake(1024, 2555);
    inScrollview.pagingEnabled = YES;
    inScrollview.showsVerticalScrollIndicator = NO;
    inScrollview.showsHorizontalScrollIndicator = NO;
    inScrollview.bounces = NO;
    inScrollview.delegate = self;
    inScrollview.tag = 2;
    for (int i = 0; i < 5; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 511*i, 1024, 511)];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"lixilgroupinfoimage%d", i+1]];
//        UIImageView *page = [[UIImageView alloc] initWithFrame:CGRectMake(892, 381, 69/2, 185/2)];
//        page.image = [UIImage imageNamed:[NSString stringWithFormat:@"lixilgroupinfopage%d", i+2]];
//        [imageView addSubview:page];
        [inScrollview addSubview:imageView];
    }
    [outScrollView addSubview:inScrollview];
    
    UIImageView *page = [[UIImageView alloc] initWithFrame:CGRectMake(892, 640, 69/2, 185/2)];
    page.image = [UIImage imageNamed:[NSString stringWithFormat:@"lixilgroupinfopage%d", 1]];
    self.page = page;
    [self.view addSubview:page];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
