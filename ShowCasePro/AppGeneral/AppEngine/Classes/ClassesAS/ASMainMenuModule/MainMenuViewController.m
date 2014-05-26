//
//  MainMenuViewController.m
//  ShowCasePro
//
//  Created by yczx on 13-11-25.
//  Copyright (c) 2013年 yczx. All rights reserved.
//

#import "MainMenuViewController.h"

//#import "MainViewController.h"

#import "MacroDefine.h"
#import "ASDepthModalViewController.h"
#import "CoreAnimationEffect.h"
#import "AAShareBubbles.h"

#import "WarehoueViewController.h"
//#import "ASCatageryViewController.h"
#import "ASMenuViewController.h"
#import "DiyViewController.h"
#import "FavouriteViewController.h"
#import "ShopCartViewController.h"
#import "DimensionsViewController.h"
#import "CalculateViewController.h"
#import "UserSettingViewController.h"
#import "ASNewProductVC.h"
#import "SuccessfulProjects.h"
#import "ASCollectionViewController.h"
#import "ASVideoViewController.h"
#import "ASHistoryViewController.h"
#import "RetailStoresViewController.h"
#import "LeadingTech.h"
#import "InspirationViewController.h"
#import "ASShowProduct.h"

@interface MainMenuViewController () <UIPopoverControllerDelegate>//, ASMenuViewControllerDelegate
{
    int nums;
    
    AAShareBubbles *shareBubbles;
}


//@property (nonatomic, strong) MainViewController *mainViewController;

@property(nonatomic,strong) NSTimer *timer;

@property (nonatomic, strong) ASMenuViewController *menuviewController;
//@property (nonatomic, strong) UIPopoverController *popoverController1;

@end

@implementation MainMenuViewController


#pragma mark - ASMenuViewControllerDelegate

//- (void)asMenuViewControllerDidSelectedViewControllerName:(NSString *)viewControllerName
//{
//    //    NSLog(@"viewControllerName:>>%@ ---", viewControllerName);
//    if (viewControllerName != nil && ![viewControllerName isEqualToString:@""]) {
//        UIViewController *viewController = [[NSClassFromString(viewControllerName) alloc] initWithNibName:viewControllerName bundle:nil];
//        [self.popoverController1Base dismissPopoverAnimated:NO];
//        [self.navigationController pushViewController:viewController animated:YES];
//    }
//}

#pragma mark - UIPopoverControllerDelegate

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    [popoverController dismissPopoverAnimated:YES];
}

#pragma mark - Handle Action
//
//- (IBAction)pushMainViewWithChooseOption:(id)sender {
//    if (self.mainViewController == nil) {
//        // 初始化主框架
//        self.mainViewController = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
//    }
//    
//    // 选择要显示的页面
////    if (((UIButton *)sender).tag == 1) {
////        self.mainViewController.chooseViewContorllerName = @"ProSearchViewController";
////    } else if (((UIButton *)sender).tag == 2) {
////        self.mainViewController.chooseViewContorllerName = @"DiyViewController";
////    } else {
////        self.mainViewController.chooseViewContorllerName = @"ChooseBrandForInfoViewController";
////    }
//    
//    switch (((UIButton *)sender).tag) {
//        case 50:
//            self.mainViewController.chooseViewContorllerName = @"ChooseBrandForInfoViewController";
//            break;
//        case 60:
//            self.mainViewController.chooseViewContorllerName = @"SearchViewController";
//            break;
//        case 170:
//            self.mainViewController.chooseViewContorllerName = @"CalculateViewController";
//            break;
//        case 190:
//            self.mainViewController.chooseViewContorllerName = @"WarehoueViewController";
//            break;
//        case 90:
//            self.mainViewController.chooseViewContorllerName = @"FavouriteViewController";
//            break;
//        case 40:
//            return;
//            self.mainViewController.chooseViewContorllerName = @"";
//            break;
//        case 100:
//            self.mainViewController.chooseViewContorllerName = @"ShopCartViewController";
//            break;
//        case 8:
//            self.mainViewController.chooseViewContorllerName = @"DiyViewController";
//            break;
//        case 70:
//            self.mainViewController.chooseViewContorllerName = @"ProSearchViewController";
//            break;
//        case 180:
//            self.mainViewController.chooseViewContorllerName = @"DimensionsViewController";
//            break;
//        case 150:
////            self.mainViewController.chooseViewContorllerName = @"UserSettingViewController";
//        {
//            UIViewController *controlView = [[NSClassFromString(@"UserSettingViewController") alloc] initWithNibName:@"UserSettingViewController" bundle:nil];
//            [ASDepthModalViewController presentView:controlView.view];
//            [[UIApplication sharedApplication].keyWindow.rootViewController addChildViewController:controlView];
//        }
//            return;
//            break;
//        default:
//            break;
//    }
//    
//    [self.navigationController pushViewController:self.mainViewController animated:YES];
//}

//- (IBAction)asMenuButtonClicked:(id)sender {
//    if (self.menuviewController == nil) {
//        self.menuviewController = [[ASMenuViewController alloc] initWithNibName:@"ASMenuViewController" bundle:nil];
//        self.menuviewController.delegate = self;
//    }
//    if (self.popoverController1 == nil) {
//        UIPopoverController *popoverController = [[UIPopoverController alloc] initWithContentViewController:self.menuviewController];
//        popoverController.popoverContentSize = CGSizeMake(190, 400);
//        popoverController.backgroundColor = [UIColor colorWithRed:64/255. green:64/255. blue:64/255. alpha:1];
//        popoverController.delegate = self;
//        self.popoverController1 = popoverController;
//    }
//    [self.popoverController1 presentPopoverFromRect:((UIButton *)sender).frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
//}

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
    // Do any additional setup after loading the view from its nib.
    nums = 0;
    
    if(shareBubbles) {
        shareBubbles = nil;
    }
    shareBubbles = [[AAShareBubbles alloc] initWithPoint:CGPointMake(1024/2, 768/2+100) radius:0 inView:self.view];
    shareBubbles.delegate = self;

    [shareBubbles show];
    
    
}

#pragma mark -
#pragma mark AAShareBubbles

-(void)aaShareBubbles:(AAShareBubbles *)shareBubbles tappedBubbleWithType:(AAShareBubbleType)bubbleType
{
    UIViewController *willPushViewController = nil;
    switch (bubbleType) {
            // 产品展示
        case AAMenuItemType_ProductShow:{
//            ASCatageryViewController *asCatageryViewController = [[ASCatageryViewController alloc] initWithNibName:@"ASCatageryViewController" bundle:nil];
//            willPushViewController = asCatageryViewController;
            
            ASShowProduct *sp = [ASShowProduct new];
            willPushViewController = sp;
        }
            NSLog(@"AAMenuItemType_ProductShow");
            break;
            // 套间合计
        case AAMenuItemType_Colletion:
            NSLog(@"AAMenuItemType_Colletion");
        {
            ASCollectionViewController *newTechViewController = [[ASCollectionViewController alloc] initWithNibName:@"ASCollectionViewController" bundle:nil];
            willPushViewController = newTechViewController;
            
        }
            break;
            // 品牌历史
        case AAMenuItemType_BrandHis:
        {
            ASHistoryViewController *aSHistoryViewController = [[ASHistoryViewController alloc] initWithNibName:@"ASHistoryViewController" bundle:nil];
            willPushViewController = aSHistoryViewController;
        }
            NSLog(@"AAMenuItemType_BrandHis");
            break;
            // 新品速递
        case AAMenuItemType_NewProduct:{
            ASNewProductVC *newProduct = [[ASNewProductVC alloc] init];
            willPushViewController = newProduct;
        }
            NSLog(@"AAMenuItemType_NewProduct");
            break;
            // 设计灵感
        case AAMenuItemType_LingGan:
        {
            InspirationViewController *inspirationViewController = [[InspirationViewController alloc] initWithNibName:@"InspirationViewController" bundle:nil];
            willPushViewController = inspirationViewController;
        }
            NSLog(@"AAMenuItemType_LingGan");
            break;
            // 工程案例
        case AAMenuItemType_SuccessCase:
            NSLog(@"AAMenuItemType_SuccessCase");
        {
            
            SuccessfulProjects *SuccessViewController = [[SuccessfulProjects alloc] init];
            willPushViewController = SuccessViewController;
            
        }
            break;
            // 领先科技
        case AAMenuItemType_NewTechnoledge:{
//            NewTechViewController *newTechViewController = [[NewTechViewController alloc] initWithNibName:@"NewTechViewController" bundle:nil];
//            willPushViewController = newTechViewController;
            LeadingTech *leadingTech = [[LeadingTech alloc] initWithNibName:@"LeadingTech" bundle:nil];
            willPushViewController = leadingTech;
        }
            NSLog(@"AAMenuItemType_NewTechnoledge");
//        {
//            NewTechViewController *newTechController = [[NewTechViewController alloc] initWithNibName:@"NewTechViewController" bundle:nil];
//            willPushViewController = newTechController;
//        }
            
            break;
            // 品牌广告片
        case AAMenuItemType_BrandVideo:
            NSLog(@"AAMenuItemType_BrandVideo");
        {
            ASVideoViewController *videoViewController = [[ASVideoViewController alloc] initWithNibName:@"ASVideoViewController" bundle:nil];
            willPushViewController = videoViewController;
        }
            break;
            // 销售网点
        case AAMenuItemType_WangDian:{
//            WarehoueViewController *warehoueViewController = [[WarehoueViewController alloc] initWithNibName:@"WarehoueViewController" bundle:nil];
//            willPushViewController = warehoueViewController;
            RetailStoresViewController *retailStoresViewController = [[RetailStoresViewController alloc] initWithNibName:@"RetailStoresViewController" bundle:nil];
            willPushViewController = retailStoresViewController;
        }
            NSLog(@"AAMenuItemType_WangDian");
            break;
        default:
            break;
    }
    
    [self.navigationController pushViewController:willPushViewController animated:NO];
    
    
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//     self.navigationController.navigationBarHidden = YES;
//    
//    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(menuItemOrderByFadeOut) userInfo:nil repeats:YES];
//    [self.timer fire];
    
   // [shareBubbles show];
    
   // [self.view bringSubviewToFront:self.asMenuButton];
}

-(void)menuItemOrderByFadeOut
{
    
    if (nums < 200)
    {
        nums += 10;
        UIView *menuItem =  (UIView *)[self.view viewWithTag:nums];
        [CoreAnimationEffect animationFadeOut:menuItem];
        NSLog(@"nums is----------------- %d",nums);
        
    }else
    {
        nums = 0;
        [self.timer invalidate];
        
        UIView *menuItem =  (UIView *)[self.view viewWithTag:8];
        [CoreAnimationEffect animationFadeOut:menuItem];
    }
    
}

-(void)viewDidDisappear:(BOOL)animated
{
    for (int i=10; i<=200; i++) {
     
        UIView *menuItem =  (UIView *)[self.view viewWithTag:i];
        if (menuItem)
        {
                
            [menuItem setAlpha:0];
        }
        
    }
    
//    UIView *menuItem =  (UIView *)[self.view viewWithTag:8];
//    [menuItem setAlpha:0];
//
    [super viewDidDisappear:animated];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
