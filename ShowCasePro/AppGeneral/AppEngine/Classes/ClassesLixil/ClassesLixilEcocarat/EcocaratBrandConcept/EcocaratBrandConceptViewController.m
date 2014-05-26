//
//  EcocaratBrandConceptViewController.m
//  ShowCasePro
//
//  Created by Mac on 14-4-2.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "EcocaratBrandConceptViewController.h"

@interface EcocaratBrandConceptViewController ()
{
    
    UIScrollView *des;
   
}
@property (nonatomic, strong) NSMutableArray *desImgArray;
@end

@implementation EcocaratBrandConceptViewController

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
    _desImgArray = [NSMutableArray arrayWithCapacity:23];
    UIImage *desImage =  [UIImage imageNamed:@"ecocrat_bc_des"];
    [_desImgArray addObject:desImage];

    
    des = [self creatScrollView:CGRectMake(657, 194, 305, 479) imageArray:_desImgArray];
    
    [self.view addSubview:des];
}
- (UIScrollView*) creatScrollView:(CGRect)frame imageArray:(NSMutableArray*)imgArray
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:frame];
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    
    scrollView.bounces = NO;
    [scrollView setShowsHorizontalScrollIndicator:NO];
    [scrollView setShowsVerticalScrollIndicator:NO];
    scrollView.alwaysBounceVertical = YES;
    int count = [imgArray count];
    [scrollView setContentSize:CGSizeMake(305, 701)];
    
    scrollView.backgroundColor = [UIColor clearColor];
    
    for (int i = 0; i<count; i++) {
        
        UIImage *img =  [imgArray objectAtIndex:i];
        UIImageView   *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 305, 701)];
        imgView.image = img;
        
        [scrollView addSubview:imgView];
    }
    
    return scrollView;
}
- (IBAction)scrollBtn:(id)sender {
    
    if(des.contentOffset.x<-100)return;
    
    
    [des setContentOffset:CGPointMake(0, 230) animated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
