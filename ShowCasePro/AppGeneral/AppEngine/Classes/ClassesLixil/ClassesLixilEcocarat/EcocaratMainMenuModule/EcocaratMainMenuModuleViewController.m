//
//  EcocaratMainMenuModuleViewController.m
//  ShowCasePro
//
//  Created by Mac on 14-4-2.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "EcocaratMainMenuModuleViewController.h"
#import "EcocaratShareBubbles.h"
#import "EcocaratShowProductsViewController.h"
#import "EcocaratSuitesCollectionViewController.h"
#import "EcocaratBrandConceptViewController.h"
#import "EcocaratNewProductsViewController.h"
#import "Ecocarat3DRoomViewController.h"
#import "EcocaratPhilosophyViewController.h"
#import "EcocaratLeadingTechViewController.h"
#import "EcocaratCommercialsViewController.h"
#import "EcocaratSalesOutletsViewController.h"

@interface EcocaratMainMenuModuleViewController ()<EcocaratShareBubblesDelegate>
{
    EcocaratShareBubbles *shareBubbles;
}

@end

@implementation EcocaratMainMenuModuleViewController

-(void) ecocaratShareBubbles:(EcocaratShareBubbles *)shareBubbles tappedBubbleWithType:(EcocaratShareBubbleType)bubbleType
{
    UIViewController *willPushViewController = nil;
    switch (bubbleType) {
            // 产品展示
        case EcocaratMenuItemType_ProductShow:
        {
            EcocaratShowProductsViewController *vc = [EcocaratShowProductsViewController new];
            willPushViewController = vc;
        }
            
            break;
            // 套间合集
        case EcocaratMenuItemType_Colletion:
        {
            EcocaratSuitesCollectionViewController *vc = [EcocaratSuitesCollectionViewController new];
            willPushViewController = vc;
        }
            break;
            // 品牌理念
        case EcocaratMenuItemType_BrandConcept:
        {
            EcocaratBrandConceptViewController *vc = [EcocaratBrandConceptViewController new];
            willPushViewController = vc;
            
        }
            break;
            // 新品速递
        case EcocaratMenuItemType_NewProducts:
        {
            EcocaratNewProductsViewController *vc = [EcocaratNewProductsViewController new];
            willPushViewController = vc;
        }
            break;
            // 3d空间
        case EcocaratMenuItemType_3DRoom:
        {
//            Ecocarat3DRoomViewController *vc = [Ecocarat3DRoomViewController new];
//            willPushViewController = vc;
        }
            break;
            // 工程案例
        case EcocaratMenuItemType_Philosophy:
        {
            EcocaratPhilosophyViewController *vc = [EcocaratPhilosophyViewController new];
            willPushViewController = vc;
        }
            break;
            // 领先技术
        case EcocaratMenuItemType_LeadingTech:
        {
            EcocaratLeadingTechViewController *vc = [EcocaratLeadingTechViewController new];
            willPushViewController = vc;
        }
            break;
            // 广告片
        case EcocaratMenuItemType_Commercials:
        {
            EcocaratCommercialsViewController *vc = [EcocaratCommercialsViewController new];
            willPushViewController = vc;
        }
            break;
            // 销售网点
        case EcocaratMenuItemType_SalesOutlets:
        {
            EcocaratSalesOutletsViewController *vc = [EcocaratSalesOutletsViewController new];
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
    
    shareBubbles = [[EcocaratShareBubbles alloc] initWithPoint:CGPointMake(1024/2, 768/2+85) radius:0 inView:self.view];
    shareBubbles.delegate = self;
    
    [shareBubbles show];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
