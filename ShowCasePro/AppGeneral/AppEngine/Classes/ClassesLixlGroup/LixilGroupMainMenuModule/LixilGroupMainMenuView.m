//
//  LixilGroupMainMenuView.m
//  ShowCasePro
//
//  Created by yczx on 14-2-23.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "LixilGroupMainMenuView.h"
#import "LixilGrouShareBubbles.h"
#import "LixilTetra.h"
#import "LixilGroupInfoViewController.h"
#import "LixilHistoryViewController.h"
#import "OneStopServiceViewController.h"
#import "LXGroup.h"
#import "LixilGroupVideoController.h"

@interface LixilGroupMainMenuView ()<LixilGrouShareBubblesDelegate>
{
     LixilGrouShareBubbles *shareBubbles;
}

@end

@implementation LixilGroupMainMenuView

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
    
  //  [self hideNaviBar:YES];
    
    if(shareBubbles) {
        shareBubbles = nil;
    }
    
    shareBubbles = [[LixilGrouShareBubbles alloc] initWithPoint:CGPointMake(1024/2, 768/2+100) radius:0 inView:self.view];
    shareBubbles.delegate = self;
    
    [shareBubbles show];
    
    self.searchModuleView.hidden = YES;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark AAShareBubbles

-(void)aaShareBubbles:(LixilGrouShareBubbles *)shareBubbles tappedBubbleWithType:(LixilGrouShareBubbleType)bubbleType
{
    UIViewController *willPushViewController = nil;
    switch (bubbleType) {
            // 集团介绍
        case AAMenuItemType_GroupIntraduce:
        {
            LixilGroupInfoViewController *lgIView = [[LixilGroupInfoViewController alloc] initWithNibName:@"LixilGroupInfoViewController" bundle:nil];
            willPushViewController = lgIView;
            
        }

            break;
            // 企业理念
        case AAMenuItemType_QiYelinian:
        {
            LixilTetra *ltViewController = [[LixilTetra alloc] initWithNibName:@"LixilTetra" bundle:nil];
            willPushViewController = ltViewController;
        }
            break;
            // 一站式服务
        case AAMenuItemType_Service:
        {
//            OneStopServiceViewController *oneView = [[OneStopServiceViewController alloc] initWithNibName:@"OneStopServiceViewController" bundle:nil];
            
            OneStopServiceViewController *oneView = [[OneStopServiceViewController alloc]init];
            willPushViewController = oneView;
            
        }
            break;
            // 集团历史
        case AAMenuItemType_GroupHis:{
            LixilHistoryViewController *groupHistView = [[LixilHistoryViewController alloc] initWithNibName:@"LixilHistoryViewController" bundle:nil];
            willPushViewController = groupHistView;
            
            
        }
            break;
            // 集团视频
        case AAMenuItemType_GroupVideo:
        {
            LixilGroupVideoController *lgvc = [[LixilGroupVideoController alloc] init];
            willPushViewController = lgvc;
        }
            break;
            // 企业网点
        case AAMenuItemType_GroupWandian:
        {
            LXGroup *lbvc = [[LXGroup alloc] init];
            willPushViewController = lbvc;
        }
            break;
        default:
            break;
    }
    
    [self.navigationController pushViewController:willPushViewController animated:NO];

}



@end
