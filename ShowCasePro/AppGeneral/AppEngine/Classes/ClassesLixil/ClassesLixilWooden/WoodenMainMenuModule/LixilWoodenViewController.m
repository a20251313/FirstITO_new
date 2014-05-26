//
//  LixilWoodenViewController.m
//  ShowCasePro
//
//  Created by Mac on 14-3-27.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "LixilWoodenViewController.h"
#import "LixilShareBubbles.h"
#import "LixilWoodenPhilosophyViewController.h"
#import "LixilWoodenBrandHistoryViewController.h"
#import "LixilWooden3DRoomViewController.h"
#import "LixilWoodenSalesOutletsViewController.h"
#import "LixilWoodenBrandConceptViewController.h"
#import "LixilWoodenLeadingTechViewController.h"
#import "LixilWoodenFactioryIntrodutionViewController.h"
#import "LixilWoodenSuitesCollectionViewController.h"
#import "LixilWoodenShowProductsViewController.h"

@interface LixilWoodenViewController ()<LixilShareBubblesDelegate>
{
    LixilShareBubbles *shareBubbles;
}

@end

@implementation LixilWoodenViewController

-(void)lixilShareBubbles:(LixilShareBubbles *)shareBubbles tappedBubbleWithType:(LixilShareBubbleType)bubbleType
{
    UIViewController *willPushViewController = nil;
    switch (bubbleType) {
            // 产品展示
        case LixilMenuItemType_ProductShow:
        {
            LixilWoodenShowProductsViewController *vc = [LixilWoodenShowProductsViewController new];
            willPushViewController = vc;
        }
            
            break;
            // 套间合集
        case LixilMenuItemType_Colletion:
        {
            LixilWoodenSuitesCollectionViewController *vc = [LixilWoodenSuitesCollectionViewController new];
            willPushViewController = vc;
        }
            break;
            // 工厂介绍
        case LixilMenuItemType_FactioryIntrodution:
        {
            LixilWoodenFactioryIntrodutionViewController *vc = [LixilWoodenFactioryIntrodutionViewController new];
            willPushViewController = vc;
            
        }
            break;
            // 领先技术
        case LixilMenuItemType_LeadingTech:
        {
            LixilWoodenLeadingTechViewController *vc = [LixilWoodenLeadingTechViewController new];
            willPushViewController = vc;
        }
            break;
            // 品牌理念
        case LixilMenuItemType_BrandConcept:
        {
            LixilWoodenBrandConceptViewController *vc = [LixilWoodenBrandConceptViewController new];
            willPushViewController = vc;
        }
            break;
            // 销售网点
        case LixilMenuItemType_SalesOutlets:
        {
            LixilWoodenSalesOutletsViewController *vc = [LixilWoodenSalesOutletsViewController new];
            willPushViewController = vc;
        }
            break;
            // 3D空间
        case LixilMenuItemType_3DRoom:
        {
//            LixilWooden3DRoomViewController *vc = [LixilWooden3DRoomViewController new];
//            willPushViewController = vc;
        }
            break;
            // 品牌历史
        case LixilMenuItemType_BrandHistory:
        {
            LixilWoodenBrandHistoryViewController *vc = [LixilWoodenBrandHistoryViewController new];
            willPushViewController = vc;
        }
            break;
            // 工程案例
        case LixilMenuItemType_Philosophy:
        {
            LixilWoodenPhilosophyViewController *vc = [LixilWoodenPhilosophyViewController new];
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
    
    shareBubbles = [[LixilShareBubbles alloc] initWithPoint:CGPointMake(1024/2, 768/2+85) radius:0 inView:self.view];
    shareBubbles.delegate = self;
    
    [shareBubbles show];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
