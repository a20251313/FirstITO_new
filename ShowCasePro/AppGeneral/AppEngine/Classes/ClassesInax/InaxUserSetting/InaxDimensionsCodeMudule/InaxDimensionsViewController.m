//
//  DimensionsViewController.m
//  ShowCasePro
//
//  Created by yczx on 13-11-25.
//  Copyright (c) 2013年 yczx. All rights reserved.
//

#import "InaxDimensionsViewController.h"
#import <ZBarSDK.h>
#import "DatabaseOption+DIYFolder.h"
#import "LibraryAPI.h"

@interface InaxDimensionsViewController ()<ZBarReaderDelegate,UIImagePickerControllerDelegate>
{
    UIImageView *scanImageView;
    NSTimer *timer;
}

@end

@implementation InaxDimensionsViewController

#pragma mark -
#pragma mark - ZBar delegate -

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    id<NSFastEnumeration> results = [info objectForKey: ZBarReaderControllerResults];
    if ([info count]>2) {
        int quality = 0;
        ZBarSymbol *bestResult = nil;
        for(ZBarSymbol *sym in results) {
            int q = sym.quality;
            if(quality < q) {
                quality = q;
                bestResult = sym;
            }
        }
        [self performSelector: @selector(presentResult:) withObject: bestResult afterDelay: .001];
    }else {
        ZBarSymbol *symbol = nil;
        for(symbol in results)
            break;
        [self performSelector: @selector(presentResult:) withObject: symbol afterDelay: .001];
    }
    //[picker dismissViewControllerAnimated:YES completion:nil];
}

- (void) presentResult: (ZBarSymbol*)sym {
    if (sym) {
        NSString *tempStr = sym.data;
        if ([sym.data canBeConvertedToEncoding:NSShiftJISStringEncoding]) {
            tempStr = [NSString stringWithCString:[tempStr cStringUsingEncoding:NSShiftJISStringEncoding] encoding:NSUTF8StringEncoding];
        }
        
        if (![tempStr hasPrefix:Dimensions_Per]) {
            
            NSLog(@"非法二维码");
            
            return;
        }
        
        NSLog(@"扫描出的二维码：%@",tempStr);
        
        DatabaseOption *dbo = [[DatabaseOption alloc] init];
        BOOL b = [dbo insertFolderByShareString:tempStr];
        NSString *result = nil;
        if (b) {
            result = @"插入成功";
        } else result = @"插入失败";
        
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"扫描结果" message:result delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [av show];
    }
}


#pragma mark - 
#pragma mark - view appear -

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:Nil message:@"不支持模拟器" delegate:Nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [av show];
        return;
    }
    
    ZBarReaderViewController *reader = [ZBarReaderViewController new];
    reader.readerDelegate = self;
    reader.supportedOrientationsMask = ZBarOrientationMaskAll;

    //覆盖层
    UIImageView *overlay = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
    overlay.image = [UIImage imageNamed:@"cameraoverlay"];
    overlay.userInteractionEnabled = YES;
    reader.cameraOverlayView = overlay;
    
    
    UIImage *scanEffect = [UIImage imageNamed:@"scaneffect"];
    scanImageView = [[UIImageView alloc] initWithFrame:CGRectMake(215, 85, scanEffect.size.width / 2, scanEffect.size.height / 2)];
    scanImageView.image = scanEffect;
    [overlay addSubview:scanImageView];
    
    [timer invalidate];
    timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(moveScanEffect) userInfo:nil repeats:YES];
    [timer fire];
    
    ZBarImageScanner *scanner = reader.scanner;
    
    [scanner setSymbology:ZBAR_I25 config:ZBAR_CFG_ENABLE to:0];
    
    [self presentViewController:reader animated:NO completion:^
    {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
        
        UIView *overlay = reader.cameraOverlayView;
        
        UIView *bar = [self creatNavigationBar];
        
        [overlay addSubview:bar];
        
    }];
}


- (UIView *) creatNavigationBar
{
    UIView *bar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024, 85)];
    bar.backgroundColor = [UIColor clearColor];
    
    UIImageView *bgImage = [[UIImageView alloc] initWithFrame:bar.frame];
    bgImage.image = [UIImage imageNamed:@"inax_nav_bg"];
    [bar addSubview:bgImage];
    
    UIImage *buttonImage = [UIImage imageNamed:@"inax_nav_back"];
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(35, 30, 81, 33);
    [backButton setImage:buttonImage forState:UIControlStateNormal];
    backButton.backgroundColor = [UIColor clearColor];
    [backButton addTarget:self action:@selector(backBtnEvent) forControlEvents:UIControlEventTouchUpInside];
    backButton.adjustsImageWhenHighlighted = NO;
    [bar addSubview:backButton];
    
    return bar;
}


- (void)backBtnEvent
{
    [self dismissViewControllerAnimated:NO completion:^{
        
    }];
    
    [self.navigationController popViewControllerAnimated:NO];
}


-(void) moveScanEffect
{
    [UIView animateWithDuration:1.8 animations:^
     {
         scanImageView.frame = CGRectMake(scanImageView.frame.origin.x, 545, scanImageView.frame.size.width, scanImageView.frame.size.height);
     }
     completion:^(BOOL finished) {
         
         scanImageView.frame = CGRectMake(scanImageView.frame.origin.x, 85, scanImageView.frame.size.width, scanImageView.frame.size.height);
     }];
    
    
//    if (scanImageView.frame.origin.y > 400)
//    {
//        [UIView animateWithDuration:2 animations:^
//        {
//            scanImageView.frame = CGRectMake(scanImageView.frame.origin.x, 85, scanImageView.frame.size.width, scanImageView.frame.size.height);
//        }];
//    }
//    else
//    {
//        [UIView animateWithDuration:2 animations:^
//        {
//            scanImageView.frame = CGRectMake(scanImageView.frame.origin.x, 545, scanImageView.frame.size.width, scanImageView.frame.size.height);
//        }];
//    }
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [timer invalidate];
}


#pragma mark -
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
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    self.view.backgroundColor = [UIColor clearColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
