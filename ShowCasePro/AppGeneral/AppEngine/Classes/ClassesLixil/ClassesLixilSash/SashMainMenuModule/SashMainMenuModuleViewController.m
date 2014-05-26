//
//  SashMainMenuModuleViewController.m
//  ShowCasePro
//
//  Created by Mac on 14-4-8.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "SashMainMenuModuleViewController.h"
#import "SashShareBubbles.h"
#import "SashShowProductsViewController.h"
#import "SashSuitesCollectionViewController.h"
#import "SashBrandConceptViewController.h"
#import "SashLeadingTechViewController.h"
#import "Sash3DRoomViewController.h"
#import "SashPhilosophyViewController.h"

@interface SashMainMenuModuleViewController ()<SashShareBubblesDelegate>
{
    SashShareBubbles *shareBubbles;
}

@end

@implementation SashMainMenuModuleViewController

-(void) sashShareBubbles:(SashShareBubbles *)shareBubbles tappedBubbleWithType:(SashShareBubbleType)bubbleType
{
    UIViewController *willPushViewController = nil;
    switch (bubbleType) {
            // 产品展示
        case SashMenuItemType_ProductShow:
        {
            SashShowProductsViewController *vc = [SashShowProductsViewController new];
            willPushViewController = vc;
        }
            break;
            // 套间合集
        case SashMenuItemType_Colletion:
        {
            SashSuitesCollectionViewController *vc = [SashSuitesCollectionViewController new];
            willPushViewController = vc;
        }
            break;
            // 品牌理念
        case SashMenuItemType_BrandConcept:
        {
            SashBrandConceptViewController *vc = [SashBrandConceptViewController new];
            willPushViewController = vc;
            
        }
            break;
            // 领先技术
        case SashMenuItemType_LeadingTech:
        {
            SashLeadingTechViewController *vc = [SashLeadingTechViewController new];
            willPushViewController = vc;
        }
            break;
            // 3d空间
        case SashMenuItemType_3DRoom:
        {
            //            Sash3DRoomViewController *vc = [Sash3DRoomViewController new];
            //            willPushViewController = vc;
        }
            break;
            // 工程案例
        case SashMenuItemType_Philosophy:
        {
            SashPhilosophyViewController *vc = [SashPhilosophyViewController new];
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
    
    shareBubbles = [[SashShareBubbles alloc] initWithPoint:CGPointMake(1024/2, 768/2+85) radius:0 inView:self.view];
    shareBubbles.delegate = self;
    
    [shareBubbles show];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
