//
//  FavouriteViewController.m
//  ShowCasePro
//
//  Created by LX on 13-11-23.
//  Copyright (c) 2013年 yczx. All rights reserved.
//

#import "FavouriteViewController.h"

#import "APPaginalTableView.h"
#import "CollapsedCellViewController.h"
#import "ExpandedViewController.h"
#import "HMSegmentedControl.h"
#import "DatabaseOption+Tfavorite.h"

@interface FavouriteViewController () <APPaginalTableViewDataSource, APPaginalTableViewDelegate, CommentChangeProtocol>

@property (nonatomic, strong)APPaginalTableView *paginalTableView;
@property (nonatomic, strong)NSArray *tableViewData;
@property (nonatomic, strong)NSArray *months;
@property (nonatomic, strong)HMSegmentedControl *segmentedControl;

@end

@implementation FavouriteViewController

#pragma mark - CommentChangeProtocol

- (void)expandedViewControllerCommentDidChange:(ExpandedViewController *)expandedViewController
{
    self.tableViewData = [[[DatabaseOption alloc]init]selectFavoriteByYearMonth:self.months[self.segmentedControl.selectedIndex]];
    [self.paginalTableView reloadData];
}

#pragma mark - APPaginalTableViewDataSource

- (NSUInteger)numberOfElementsInPaginalTableView:(APPaginalTableView *)paginalTableView
{
    return self.tableViewData.count;
}

- (UIView *)paginalTableView:(APPaginalTableView *)paginalTableView collapsedViewAtIndex:(NSUInteger)index
{
    return [self createCollapsedViewAtIndex:index];
}

- (UIView *)paginalTableView:(APPaginalTableView *)paginalTableView expandedViewAtIndex:(NSUInteger)index
{
    return  [self createExpandedViewAtIndex:index];
}

#pragma mark - APPaginalTableViewDelegate

- (BOOL)paginalTableView:(APPaginalTableView *)managerView openElementAtIndex:(NSUInteger)index onChangeHeightFrom:(CGFloat)initialHeight toHeight:(CGFloat)finalHeight
{
    BOOL open = _paginalTableView.isExpandedState;
    APPaginalTableViewElement *element = [managerView elementAtIndex:index];
    
    if (initialHeight > finalHeight) { //open
        open = finalHeight > element.expandedHeight * 0.8f;
    }
    else if (initialHeight < finalHeight) { //close
        open = finalHeight > element.expandedHeight * 0.2f;
    }
    return open;
}

- (void)paginalTableView:(APPaginalTableView *)paginalTableView didSelectRowAtIndex:(NSUInteger)index
{
    [_paginalTableView openElementAtIndex:index completion:nil animated:YES];
}

#pragma mark - Internal

- (UIView *)createCollapsedViewAtIndex:(NSUInteger)index
{
    CollapsedCellViewController *collapsedCellViewController = [[CollapsedCellViewController alloc] init];
    collapsedCellViewController.favorite = self.tableViewData[index];
    collapsedCellViewController.view.frame = CGRectMake(0.f, 0.f, _paginalTableView.frame.size.width, 170.f);
    [self addChildViewController:collapsedCellViewController];
    return collapsedCellViewController.view;
}

- (UIView *)createExpandedViewAtIndex:(NSUInteger)index
{
    ExpandedViewController *expandedViewController = [[ExpandedViewController alloc] init];
    expandedViewController.favorite = self.tableViewData[index];
    expandedViewController.view.frame = (CGRect){.origin=CGPointMake(0, 0),.size=_paginalTableView.frame.size};
    expandedViewController.delegate = self;
    [self addChildViewController:expandedViewController];
    
    return expandedViewController.view;
}

#pragma mark - Initialization

- (void)initData
{
    DatabaseOption *dbo = [[DatabaseOption alloc]init];
    self.months = [dbo monthsToSelect];
    if (self.months.count==0) {
        return;
    }
    self.tableViewData = [dbo selectFavoriteByYearMonth:self.months[0]];
}

- (void)initSegmentedControl
{
//    HMSegmentedControl *segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:[NSArray arrayWithObjects:@"今天", @"九月", @"七月", @"六月", @"五月", @"四月", @"三月", nil]];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(118, 0, 4, 748)];
    view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"indicator"]];
    [self.view addSubview:view];
    
    NSMutableArray *array = [NSMutableArray array];
    for (NSString *str in self.months) {
        NSString *temp = [NSString stringWithFormat:@"%@月", [str substringToIndex:2]];
        [array addObject:temp];
    }
    HMSegmentedControl *segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:array];
    segmentedControl.selectionIndicatorMode = HMSelectionIndicatorVertical;
    [segmentedControl setSelectionIndicatorHeight:4.0f];
    [segmentedControl setBackgroundColor:[UIColor colorWithRed:33/255. green:33/255. blue:33/255. alpha:1]];
    [segmentedControl setTextColor:[UIColor colorWithRed:77/255. green:77/255. blue:77/255. alpha:1.]];
    [segmentedControl setSelectionIndicatorColor:[UIColor colorWithRed:184/255. green:156/255. blue:101/255. alpha:1.]];
    [segmentedControl setSegmentEdgeInset:UIEdgeInsetsMake(0, 6, 0, 6)];
    [segmentedControl setCenter:CGPointMake(100, 374)];
    __weak HMSegmentedControl *segmentedControl1 = segmentedControl;
    [segmentedControl setIndexChangeBlock:^(NSUInteger index){
        // 更新界面显示（放大）
        [segmentedControl1 setNeedsDisplay];
        // 选中月份，更新右边数据
        self.tableViewData = [[[DatabaseOption alloc]init]selectFavoriteByYearMonth:self.months[index]];
//        NSLog(@"Selected index %i (via block)", index);
        [self.paginalTableView reloadData];
    }];
    self.segmentedControl = segmentedControl;
    [self.view addSubview:segmentedControl];
    CGAffineTransform at = CGAffineTransformMakeRotation(M_PI_2);
    at = CGAffineTransformTranslate(at, -200, 0);
    [segmentedControl setTransform:at];
    
}

- (void)initPaginalTableView
{
    _paginalTableView = [[APPaginalTableView alloc] initWithFrame:CGRectMake(200, 0, 700, 700)];
    _paginalTableView.dataSource = self;
    _paginalTableView.delegate = self;
    [self.view addSubview:_paginalTableView];
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
    
    self.view.backgroundColor = [UIColor colorWithRed:33./255 green:33./255 blue:33./255 alpha:1.];
    
    if (self.tableViewData.count)
    {
        [self initSegmentedControl];
        
        [self initPaginalTableView];
    }
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self initData];
    
    if (self.tableViewData.count)
    {
       [self.paginalTableView reloadData];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
