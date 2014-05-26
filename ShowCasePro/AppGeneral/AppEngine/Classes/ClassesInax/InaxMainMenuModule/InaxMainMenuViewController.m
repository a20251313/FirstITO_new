//
//  InaxMainMenuViewController.m
//  ShowCasePro
//
//  Created by Mac on 14-3-18.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "InaxMainMenuViewController.h"
#import "InaxShareBubbles.h"

#import "InaxShowProductsViewController.h"
#import "InaxSuiteCollectionViewController.h"
#import "InaxBrandHistoryViewController.h"
#import "InaxNewProductsViewController.h"
#import "Inax3DRoomViewController.h"
#import "InaxSuccessfulProjectsViewController.h"
#import "InaxLeadingTechViewController.h"
#import "InaxBrandConceptViewController.h"
#import "InaxSalesOutletsViewController.h"

@interface InaxMainMenuViewController ()<InaxShareBubblesDelegate>
{
    InaxShareBubbles *shareBubbles;
}

@end

@implementation InaxMainMenuViewController

-(void)inaxShareBubbles:(InaxShareBubbles *)shareBubbles tappedBubbleWithType:(InaxShareBubbleType)bubbleType
{
    UIViewController *willPushViewController = nil;
    switch (bubbleType) {
            // 产品展示
        case InaxMenuItemType_ProductShow:
        {
            InaxShowProductsViewController *vc = [InaxShowProductsViewController new];
            willPushViewController = vc;
            
        }
            
            break;
            // 套间合集
        case InaxMenuItemType_Colletion:
        {
            InaxSuiteCollectionViewController *vc = [InaxSuiteCollectionViewController new];
            willPushViewController = vc;
        }
            break;
            // 品牌历史
        case InaxMenuItemType_BrandHis:
        {
            InaxBrandHistoryViewController *vc = [InaxBrandHistoryViewController new];
            willPushViewController = vc;
            
        }
            break;
            // 新品速递
        case InaxMenuItemType_NewProduct:
        {
            InaxNewProductsViewController *vc = [InaxNewProductsViewController new];
            willPushViewController = vc;
        }
            break;
            // 3d空间
        case InaxMenuItemType_inax3DRoom:
        {
//            Inax3DRoomViewController *vc = [Inax3DRoomViewController new];
//            willPushViewController = vc;
        }
            break;
            // 工程案例
        case InaxMenuItemType_SuccessCase:
        {
            InaxSuccessfulProjectsViewController *vc = [InaxSuccessfulProjectsViewController new];
            willPushViewController = vc;
        }
            break;
            // 领先技术
        case InaxMenuItemType_NewTechnoledge:
        {
            InaxLeadingTechViewController *vc = [InaxLeadingTechViewController new];
            willPushViewController = vc;
        }
            break;
            // 品牌理念
        case InaxMenuItemType_BrandConcept:
        {
            InaxBrandConceptViewController *vc = [InaxBrandConceptViewController new];
            willPushViewController = vc;
        }
            break;
            // 销售网络
        case InaxMenuItemType_WangDian:
        {
            InaxSalesOutletsViewController *vc = [InaxSalesOutletsViewController new];
            willPushViewController = vc;
        }
            break;
        default:
            break;
    }
    
    if (willPushViewController)
    {
        [self.navigationController pushViewController:willPushViewController animated:NO];
    }
}


#pragma mark - life cycle -

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
    
    if(shareBubbles) {
        shareBubbles = nil;
    }
    
    shareBubbles = [[InaxShareBubbles alloc] initWithPoint:CGPointMake(1024/2, 768/2+85) radius:0 inView:self.view];
    shareBubbles.delegate = self;
    
    [shareBubbles show];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
