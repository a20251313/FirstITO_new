//
//  CollapsedCellViewController.m
//  LearnAppaginaTableView
//
//  Created by CY-004 on 13-11-19.
//  Copyright (c) 2013年 CY. All rights reserved.
//

#import "CollapsedCellViewController.h"
#import "HorizontalScroller.h"
#import "LibraryAPI.h"
#import "ProductDetailView.h"
#import "LixilProductDetailView.h"
#import "InaxProductDetailView.h"

@interface CollapsedCellViewController () <HorizontalScrollerDelegate>

@end

@implementation CollapsedCellViewController

#pragma mark - HorizontalScrollerDelegate

- (NSInteger)numberOfViewsForHorizontalScroller:(HorizontalScroller *)scroller
{
    return self.favorite.details.count;
}

- (UIView *)horizontalScroller:(HorizontalScroller *)scroller viewAtIndex:(int)index
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 10, 80, 60)];
    imageView.image = [[LibraryAPI sharedInstance] getImageFromPath:((TfavoriteDetail *)self.favorite.details[index]).productimg scale:16];
    [view addSubview:imageView];
    view.backgroundColor = [UIColor whiteColor];
    return view;
}

- (void)horizontalScroller:(HorizontalScroller *)scroller clickedViewAtIndex:(int)index
{
    TfavoriteDetail *detail = (TfavoriteDetail *)self.favorite.details[index];
    
    //根据品牌不同设置不同背景
    if ((![[LibraryAPI sharedInstance].currentBrandID isEqualToString:@"2"])&&(![[LibraryAPI sharedInstance].currentBrandID isEqualToString:@"3"])) //lixil
    {
        LixilProductDetailView *detailView = [[LixilProductDetailView alloc]init];
        detailView.productid = detail.productid;
        [self.navigationController pushViewController:detailView animated:NO];
    }
    else if ([[LibraryAPI sharedInstance].currentBrandID isEqualToString:@"3"]) //inax
    {
        InaxProductDetailView *detailView = [[InaxProductDetailView alloc]init];
        detailView.productid = detail.productid;
        [self.navigationController pushViewController:detailView animated:NO];
    }
    else
    {
        ProductDetailView *detailView = [[ProductDetailView alloc]init];
        detailView.productid = detail.productid;
        [self.navigationController pushViewController:detailView animated:NO];
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
	// Do any additional setup after loading the view.
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 735, 200)];
    // 添加label控件显示哪一天
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(4, 75, 40, 20)];
    label.text = [NSString stringWithFormat:@"%@日", self.favorite.day];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:15.f];
    label.textColor = [UIColor colorWithRed:107/255. green:107/255. blue:107/255. alpha:1];
    label.backgroundColor = [UIColor clearColor];
    // 添加贯穿视图的黑线
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(54, 0, 6, 170)];
    lineView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"line"]];
    // 添加黑圆结点
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(47, 75, 20, 20)];
    imageView.image = [UIImage imageNamed:@"cycle_blank"];
    imageView.backgroundColor = [UIColor clearColor];
    // 添加内容视图
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(67, 24, 685, 152)];
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:(CGRect){.origin=CGPointMake(0, 0), .size=contentView.frame.size}];
    bgView.backgroundColor = [UIColor clearColor];
    bgView.image = [[UIImage imageNamed:@"content_bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 20, 30, 0)];
    [contentView addSubview:bgView];
    // 添加滚动视图显示收藏图片
    HorizontalScroller *scroller = [[HorizontalScroller alloc] initWithFrame:CGRectMake(44, 10, 570, 102)];
    scroller.delegate = self;
//    scroller.backgroundColor = [UIColor colorWithRed:68/255. green:68/255. blue:68/255. alpha:1];
    [contentView addSubview:scroller];
    // 显示备注
    UILabel *beizhu = [[UILabel alloc] initWithFrame:CGRectMake(44, 112, 570, 30)];
    beizhu.backgroundColor = [UIColor clearColor];
    beizhu.text = self.favorite.comment;
    beizhu.textColor = [UIColor whiteColor];
    [contentView addSubview:beizhu];
    
    [view addSubview:label];
    [view addSubview:lineView];
    [view addSubview:imageView];
    [view addSubview:contentView];
    
    [self.view addSubview:view];
//    self.view.backgroundColor = [UIColor colorWithRed:68./255. green:68./255. blue:68./255. alpha:1.];
    self.view.backgroundColor = [UIColor clearColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
