//
//  SuiteIntroduceViewController.m
//  ShowCasePro
//
//  Created by yczx on 14-1-22.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "SuiteIntroduceViewController.h"
#import "Suites.h"
#import "DatabaseOption+Suites.h"
#import "URBMediaFocusViewController.h"


@interface SuiteIntroduceViewController ()
{

}

@property (nonatomic, strong) URBMediaFocusViewController *mediaFocusController;

@property(nonatomic,strong)Suites *suite;

@end

@implementation SuiteIntroduceViewController

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
    
    // 0.根据传递过来的ID 查找对应的 SuitID
    NSString *temID = [self getSuiteIDByTransforID:_suiteID];
    
    // 1.根据传递id 查询系列数
    self.suite = [self getSuiteInfoByID:temID];
    // 2.获取系列数据后填充系列介绍和图片
    [self setViewInfoByData:_suite];
    
    self.mediaFocusController = [[URBMediaFocusViewController alloc] init];
	self.mediaFocusController.delegate = self;
    
    
}

// 0.根据传递过来的ID 查找对应的 SuitID
-(NSString *)getSuiteIDByTransforID:(NSString *)suite
{
    int returnID = 0;
    NSInteger suiteID = [suite intValue];
    switch (suiteID) {
        case 1:
            returnID = 3;
            break;
        case 2:
            returnID = 5;
            break;
        case 3:
            returnID = 4;
            break;
        case 4:
            returnID = 123;
            break;
        case 5:
            returnID = 1;
            break;
        case 6:
            returnID = 2;
            break;
        case 7:
            returnID = 8;
            break;
        case 8:
            returnID = 6;
            break;
        case 9:
            returnID = 9;
            break;
        case 10:
            returnID = 7;
            break;
        case 11:
            returnID = 12;
            break;
        case 12:
            returnID = 14;
            break;
        case 13:
            returnID = 11;
            break;
            
        default:
            break;
    }
    
    return [NSString stringWithFormat:@"%d",returnID];
}


// 1.根据传递id 查询系列数据
-(Suites *) getSuiteInfoByID:(NSString *)suiteID
{
    Suites *suite = nil;

    DatabaseOption *dbo = [[DatabaseOption alloc] init];
    suite = [dbo getSuiteBysuiteid:suiteID];
    
    return suite;
}

// 2.获取系列数据后填充系列介绍和图片
-(void)setViewInfoByData:(Suites *)data
{
    [self.suite_Name setText:data.name];
    [self.suiteIntroduce setText:data.intro];

    UIImage *iconImage = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",kLibrary,data.img1]];
   
    self.suite_Ico.image = iconImage;
    
    CALayer *lay  = self.suite_Ico.layer;//获取ImageView的层
    [lay setMasksToBounds:YES];
    [lay setCornerRadius:25];//值越大，角度越圆
    
    
    [self addTapGestureToView:self.suite_Ico];
}


- (void)showFocusView:(UITapGestureRecognizer *)gestureRecognizer {
	//[self.mediaFocusController showImage:[UIImage imageNamed:@"seattle01.jpg"] fromView:self.thumbnailView inView:self.view];

	if (gestureRecognizer.view == self.suite_Ico) {
		[self.mediaFocusController showImage:self.suite_Ico.image fromView:gestureRecognizer.view];
	}
	
}


- (void)addTapGestureToView:(UIView *)view {
	UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showFocusView:)];
	tapRecognizer.numberOfTapsRequired = 1;
	tapRecognizer.numberOfTouchesRequired = 1;
	[view addGestureRecognizer:tapRecognizer];
}



#pragma mark - URBMediaFocusViewControllerDelegate Methods

- (void)mediaFocusViewControllerDidAppear:(URBMediaFocusViewController *)mediaFocusViewController {
	NSLog(@"focus view appeared");
}

- (void)mediaFocusViewControllerDidDisappear:(URBMediaFocusViewController *)mediaFocusViewController {
	NSLog(@"focus view disappeared");
}

- (void)mediaFocusViewController:(URBMediaFocusViewController *)mediaFocusViewController didFinishLoadingImage:(UIImage *)image {
	NSLog(@"focus view finished loading image");
}

- (void)mediaFocusViewController:(URBMediaFocusViewController *)mediaFocusViewController didFailLoadingImageWithError:(NSError *)error {
	NSLog(@"focus view failed loading image: %@", error);
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
