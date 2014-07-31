//
//  InaxSalesOutletsViewController.m
//  ShowCasePro
//
//  Created by Mac on 14-3-18.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "InaxSalesOutletsViewController.h"


#define Animation_Duration_Inax_SalesOutlets 0.25
#define Animation_Duration_lxgroup 0.25

typedef void(^endBlock)(void);
@interface InaxSalesOutletsViewController ()
{
    //地图上的深色省份
    __weak IBOutlet UIImageView *map_liaoning;
    __weak IBOutlet UIImageView *map_shandong;
    __weak IBOutlet UIImageView *map_shanghai;
    __weak IBOutlet UIImageView *map_ningxia;
    __weak IBOutlet UIImageView *map_shanxi;
    __weak IBOutlet UIImageView *map_sichuan;
    __weak IBOutlet UIImageView *map_hunan;
    __weak IBOutlet UIImageView *map_jiangxi;
    __weak IBOutlet UIImageView *map_guangxi;
    __weak IBOutlet UIImageView *map_guangdong;
    
    //地图上的蓝点
    __weak IBOutlet UIImageView *point_liaoning1;
    __weak IBOutlet UIImageView *point_liaoning2;
    __weak IBOutlet UIImageView *point_shandong1;
    __weak IBOutlet UIImageView *point_shandong2;
    __weak IBOutlet UIImageView *point_shanghai1;
    __weak IBOutlet UIImageView *point_shanghai2;
    __weak IBOutlet UIImageView *point_ningxia1;
    __weak IBOutlet UIImageView *point_shanxi1;
    __weak IBOutlet UIImageView *point_sichuan1;
    __weak IBOutlet UIImageView *point_hunan1;
    __weak IBOutlet UIImageView *point_jiangxi1;
    __weak IBOutlet UIImageView *point_guangxi1;
    __weak IBOutlet UIImageView *point_guangdong1;
    __weak IBOutlet UIImageView *point_guangdong2;
    
    
    //
    __weak IBOutlet UIView *masterView;
    
    //
    __weak IBOutlet UIView *listView;
}


@property (nonatomic , strong) NSMutableArray *mapArray;
@property (nonatomic , strong) UIImageView *currentAreaList;

@property (nonatomic , strong) NSMutableArray *pointArray;
- (IBAction)tapLiaoNing:(UIButton *)sender;
- (IBAction)tapShanDong:(UIButton *)sender;
- (IBAction)tapJiangSu:(UIButton *)sender;
- (IBAction)tapJiangXi:(UIButton *)sender;
- (IBAction)tapHuNan:(UIButton *)sender;
- (IBAction)tapGuangdong:(UIButton *)sender;
- (IBAction)tapGuangXi:(UIButton *)sender;
- (IBAction)tapSichuan:(UIButton *)sender;
- (IBAction)tapShanxi:(UIButton *)sender;
- (IBAction)tapYinChuan:(UIButton *)sender;


- (IBAction)cityButtonTouched:(id)sender;
@end

@implementation InaxSalesOutletsViewController

#pragma mark - user operate event -



#pragma mark - hide button event -

- (IBAction)hideMasterView:(id)sender
{
    float alpha = masterView.alpha;
    
    if (alpha)
    {
        if (!listView.alpha)
        {
            [self bgButtonEvent];
            return;
        }
        
        alpha = 0;
    }
    else
    {
        alpha = 1;
    }
    
    [UIView animateWithDuration:Animation_Duration_lxgroup animations:^{
        masterView.alpha = alpha;
    }];
    
}



- (void) showArea:(UIImageView *)imageView
{
    for (UIImageView *iv in self.mapArray)
    {
        iv.hidden = YES;
    }
    
    imageView.hidden = NO;
    
}

- (void) changeListContent:(NSString *)areaName
{
    if (areaName)
    {
        if (listView.alpha == 1)
        {
            [self hideListView:^
             {
                 [self showAreaList:areaName];
             }
                         delay:Animation_Duration_lxgroup];
        }
        else
        {
            [self changeAreaList:areaName];
        }
        
        
    }
    else
    {
        [self hideAreaList:^{
            [self showListView];
        } delay:Animation_Duration_lxgroup];
    }
}

- (void) showListView
{
    [UIView animateWithDuration:Animation_Duration_lxgroup animations:^
     {
         listView.alpha = 1;
     }];
}

- (void) hideListView:(endBlock)block delay:(float)delayTime
{
    [UIView animateWithDuration:Animation_Duration_lxgroup animations:^
     {
         listView.alpha = 0;
         
     } completion:^(BOOL finished)
     {
         double delayInSeconds = delayTime;
         dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
         dispatch_after(popTime, dispatch_get_main_queue(),block);
     }];
}

- (void) showAreaList:(NSString *)areaName
{
    UIImage *image = [UIImage imageNamed:areaName];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, image.size.width/2, image.size.height/2)];
    imageView.image = image;
    imageView.backgroundColor = [UIColor clearColor];
    imageView.alpha = 0;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 10, 500, 600)];
    scrollView.contentSize = CGSizeMake(363, imageView.frame.size.height+30);
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.showsVerticalScrollIndicator = NO;
    
    [scrollView addSubview:imageView];
    [masterView addSubview:scrollView];
    
    [UIView animateWithDuration:Animation_Duration_lxgroup animations:^
     {
         imageView.alpha = 1;
     }
                     completion:^(BOOL finished) {
                         self.currentAreaList = imageView;
                     }];
}

- (void) hideAreaList:(endBlock)block delay:(float)delayTime
{
    [UIView animateWithDuration:Animation_Duration_lxgroup animations:^
     {
         self.currentAreaList.alpha = 0;
         
     } completion:^(BOOL finished)
     {
         for (UIView *view in masterView.subviews)
         {
             if (view == listView)
             {
                 continue;
             }
             
             [view removeFromSuperview];
         }
         
         //[self.currentAreaList removeFromSuperview];
         self.currentAreaList = nil;
         
         double delayInSeconds = delayTime;
         dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
         dispatch_after(popTime, dispatch_get_main_queue(),block);
     }];
}

- (void) changeAreaList:(NSString *)areaName
{
    [self hideAreaList:^{
        [self showAreaList:areaName];
    } delay:Animation_Duration_lxgroup];
}


#pragma mark - bg button event -


- (IBAction)bgButtonEvent
{
    [self showArea:nil];
    [self changeListContent:nil];
}

#pragma mark - view did appear -

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self randomShowPoint];
}

//随机选中尚未显示的小点 显示
- (void) randomShowPoint
{
    int count = self.pointArray.count;
    
    if (!count)
    {
        return;
    }
    
    int index = arc4random() % count;
    
    [self showPoint:index];
}

//将选中的小点显示
- (void) showPoint:(int)index
{
    if (index < self.pointArray.count)
    {
        UIImageView *iv = (UIImageView *)[self.pointArray objectAtIndex:index];
        
        [UIView animateWithDuration:0.07 animations:^
         {
             iv.alpha = 1;
             
         }completion:^(BOOL finished)
         {
             //将已经显示的点移除
             [self.pointArray removeObject:iv];
             //继续显示其他小点
             [self randomShowPoint];
         }];
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
    
    self.mapArray = [NSMutableArray arrayWithObjects:
                     map_liaoning,
                     map_shandong,
                     map_shanghai,
                     map_ningxia,
                     map_shanxi,
                     map_sichuan,
                     map_hunan,
                     map_jiangxi,
                     map_guangxi,
                     map_guangdong,
                     nil];
    
    for (UIImageView *iv in self.mapArray)
    {
        iv.hidden = YES;
    }
    
    self.pointArray = [NSMutableArray arrayWithObjects:
                       point_liaoning1,
                       point_liaoning2,
                       point_shandong1,
                       point_shandong2,
                       point_shanghai1,
                       point_shanghai2,
                       point_ningxia1,
                       point_shanxi1,
                       point_sichuan1,
                       point_hunan1,
                       point_jiangxi1,
                       point_guangxi1,
                       point_guangdong1,
                       point_guangdong2,
                       nil];
    
    for (UIImageView *iv in self.pointArray)
    {
        iv.alpha = 0;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - area button event -
- (IBAction)cityButtonTouched:(id)sender
{
    int buttonTag = ((UIButton *)sender).tag;
    
    UIImageView *hightLightImageView = nil;
    NSString *detailImageName = nil;
    
    switch (buttonTag)
    {
            //上海
        case 1:
        {
            hightLightImageView = map_shanghai;
            detailImageName = @"inax_so_shanghai";
        }
            break;
            //苏州
        case 2:
        {
            hightLightImageView = map_shanghai;
            detailImageName = @"inax_so_suzhou";
        }
            break;
            //南京
        case 3:
        {
            hightLightImageView = map_shanghai;
            detailImageName = @"inax_so_nanjing";
            
        }
            break;
            //南通
        case 4:
        {
            hightLightImageView = map_shanghai;
            detailImageName = @"inax_so_nantong";
        }
            break;
            //无锡
        case 5:
        {
            hightLightImageView = map_shanghai;
            detailImageName = @"inax_so_wuxi";
        }
            break;
            //扬州
        case 6:
        {
            hightLightImageView = map_shanghai;
            detailImageName = @"inax_so_yangzhou";
        }
            break;
            //靖江
        case 7:
        {
            hightLightImageView = map_shanghai;
            detailImageName = @"inax_so_jingjiang";
        }
            break;
            //张家港
        case 8:
        {
            hightLightImageView = map_shanghai;
            detailImageName = @"inax_so_zhangjiagang";
        }
            break;
            //徐州
        case 9:
        {
            hightLightImageView = map_shanghai;
            detailImageName = @"inax_so_xuzhou";
        }
            break;
            //常州
        case 10:
        {
            hightLightImageView = map_shanghai;
            detailImageName = @"inax_so_changzhou";
        }
            break;
            //盐城
        case 11:
        {
            hightLightImageView = map_shanghai;
            detailImageName = @"inax_so_yancheng";
        }
            break;
            //江阴
        case 12:
        {
            hightLightImageView = map_shanghai;
            detailImageName = @"inax_so_jiangyin";
        }
            break;
            //连云港
        case 13:
        {
            hightLightImageView = map_shanghai;
            detailImageName = @"inax_so_lianyungang";
        }
            break;
            //南昌
        case 14:
        {
            hightLightImageView = map_jiangxi;
            detailImageName = @"inax_so_nanchang";
        }
            break;
            //长沙
        case 15:
        {
            hightLightImageView = map_hunan;
            detailImageName = @"inax_so_changsha";
        }
            break;
            //大连
        case 16:
        {
            hightLightImageView = map_shandong;
            detailImageName = @"inax_so_dalian";
        }
            break;
            //沈阳
        case 17:
        {
            hightLightImageView = map_liaoning;
            detailImageName = @"inax_so_shenyang";
        }
            break;
            //西安
        case 18:
        {
            hightLightImageView = map_shanxi;
            detailImageName = @"inax_so_xian";
        }
            break;
            //银川
        case 19:
        {
            hightLightImageView = map_ningxia;
            detailImageName = @"inax_so_yinchuan";
        }
            break;
            //南宁
        case 20:
        {
            hightLightImageView = map_guangxi;
            detailImageName = @"inax_so_nanning";
        }
            break;
            //广州
        case 21:
        {
            hightLightImageView = map_guangdong;
            detailImageName = @"inax_so_guangzhou";
        }
            break;
            //深圳
        case 22:
        {
            hightLightImageView = map_guangdong;
            detailImageName = @"inax_so_shenzhen";
        }
            break;
            
        default:
            break;
    }
    
    if (hightLightImageView && detailImageName)
    {
        [self showArea:hightLightImageView];
        [self changeListContent:detailImageName];
    }
}



- (IBAction)tapLiaoNing:(UIButton *)sender
{
    UIImageView *hightLightImageView = nil;
    NSString *detailImageName = nil;
    hightLightImageView = map_liaoning;
    detailImageName = @"inax_so_liaoning_detail";
    [self showArea:hightLightImageView];
    [self changeListContent:detailImageName];
}

- (IBAction)tapShanDong:(UIButton *)sender
{
    UIImageView *hightLightImageView = nil;
    NSString *detailImageName = nil;
    hightLightImageView = map_shandong;
    detailImageName = @"inax_so_shandong_detail";
    [self showArea:hightLightImageView];
    [self changeListContent:detailImageName];
}

- (IBAction)tapJiangSu:(UIButton *)sender
{
    UIImageView *hightLightImageView = nil;
    NSString *detailImageName = nil;
    hightLightImageView = map_shanghai;
    detailImageName = @"inax_so_jiangsu_detail";
    [self showArea:hightLightImageView];
    [self changeListContent:detailImageName];
}

- (IBAction)tapJiangXi:(UIButton *)sender
{
    UIImageView *hightLightImageView = nil;
    NSString *detailImageName = nil;
    hightLightImageView = map_jiangxi;
    detailImageName = @"inax_so_nanchang_detail";
    [self showArea:hightLightImageView];
    [self changeListContent:detailImageName];
}

- (IBAction)tapHuNan:(UIButton *)sender
{
    UIImageView *hightLightImageView = nil;
    NSString *detailImageName = nil;
    hightLightImageView = map_hunan;
    detailImageName = @"inax_so_hunan_detail";
    [self showArea:hightLightImageView];
    [self changeListContent:detailImageName];
}

- (IBAction)tapGuangdong:(UIButton *)sender
{
    UIImageView *hightLightImageView = nil;
    NSString *detailImageName = nil;
    hightLightImageView = map_guangdong;
    detailImageName = @"inax_so_guangdong_detail";
    [self showArea:hightLightImageView];
    [self changeListContent:detailImageName];
}

- (IBAction)tapGuangXi:(UIButton *)sender
{
    UIImageView *hightLightImageView = nil;
    NSString *detailImageName = nil;
    hightLightImageView = map_guangxi;
    detailImageName = @"inax_so_nanning_detail";
    [self showArea:hightLightImageView];
    [self changeListContent:detailImageName];
}

- (IBAction)tapSichuan:(UIButton *)sender
{
    UIImageView *hightLightImageView = nil;
    NSString *detailImageName = nil;
    hightLightImageView = map_sichuan;
    detailImageName = @"inax_so_sichuan_detail";
    [self showArea:hightLightImageView];
    [self changeListContent:detailImageName];
}

- (IBAction)tapShanxi:(UIButton *)sender
{
    UIImageView *hightLightImageView = nil;
    NSString *detailImageName = nil;
    hightLightImageView = map_shanxi;
    detailImageName = @"inax_so_xian_detail";
    [self showArea:hightLightImageView];
    [self changeListContent:detailImageName];
}

- (IBAction)tapYinChuan:(UIButton *)sender
{
    UIImageView *hightLightImageView = nil;
    NSString *detailImageName = nil;
    hightLightImageView = map_ningxia;
    detailImageName = @"inax_so_yinchuan_detail";
    [self showArea:hightLightImageView];
    [self changeListContent:detailImageName];
}
@end
