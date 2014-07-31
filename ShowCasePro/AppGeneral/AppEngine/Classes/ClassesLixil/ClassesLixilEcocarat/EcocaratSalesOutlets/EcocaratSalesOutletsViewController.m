//
//  EcocaratSalesOutletsViewController.m
//  ShowCasePro
//
//  Created by Mac on 14-4-2.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "EcocaratSalesOutletsViewController.h"

#define Animation_Duration_lxgroup 0.25

typedef void(^endBlock)(void);

@interface EcocaratSalesOutletsViewController ()
{
    //地图上的深色省份
    __weak IBOutlet UIImageView *map_anhui;
    __weak IBOutlet UIImageView *map_beijing;
    __weak IBOutlet UIImageView *map_fujian;
    __weak IBOutlet UIImageView *map_gansu;
    __weak IBOutlet UIImageView *map_guangdong;
    __weak IBOutlet UIImageView *map_heilongjiang;
    __weak IBOutlet UIImageView *map_hunan;
    __weak IBOutlet UIImageView *map_liaoning;
    __weak IBOutlet UIImageView *map_neimenggu;
    __weak IBOutlet UIImageView *map_shan_xi;
    __weak IBOutlet UIImageView *map_shandong;
    __weak IBOutlet UIImageView *map_shanghai;
    __weak IBOutlet UIImageView *map_shanxi;
    __weak IBOutlet UIImageView *map_sichuan;
    __weak IBOutlet UIImageView *map_zhejiang;
    __weak IBOutlet UIImageView *map_ningxia;
    
    //地图上的点
    __weak IBOutlet UIImageView *point1;
    __weak IBOutlet UIImageView *point2;
    __weak IBOutlet UIImageView *point3;
    __weak IBOutlet UIImageView *point4;
    __weak IBOutlet UIImageView *point5;
    __weak IBOutlet UIImageView *point6;
    __weak IBOutlet UIImageView *point7;
    __weak IBOutlet UIImageView *point8;
    __weak IBOutlet UIImageView *point9;
    __weak IBOutlet UIImageView *point10;
    __weak IBOutlet UIImageView *point11;
    __weak IBOutlet UIImageView *point12;
    __weak IBOutlet UIImageView *point13;
    __weak IBOutlet UIImageView *point14;
    __weak IBOutlet UIImageView *point15;
    __weak IBOutlet UIImageView *point16;
    __weak IBOutlet UIImageView *point17;
    __weak IBOutlet UIImageView *point18;
    __weak IBOutlet UIImageView *point19;
    
    
    
    //
    __weak IBOutlet UIView *masterView;
    
    //
    __weak IBOutlet UIView *listView;
}

@property (nonatomic , strong) NSMutableArray *mapArray;

@property (nonatomic , strong) NSMutableArray *pointArray;

@property (nonatomic , strong) UIImageView *currentAreaList;
- (IBAction)tapLiaoNing:(UIButton *)sender;
- (IBAction)tapBeiJing:(UIButton *)sender;
- (IBAction)tapShanDong:(UIButton *)sender;
- (IBAction)tapJiangSu:(UIButton *)sender;
- (IBAction)tapFujian:(UIButton *)sender;
- (IBAction)tapShanXi:(UIButton *)sender;
- (IBAction)tapHuBei:(UIButton *)sender;
- (IBAction)tapHuNan:(UIButton *)sender;
- (IBAction)tapSiChuan:(UIButton *)sender;
- (IBAction)tapGuangDong:(UIButton *)sender;



@end

@implementation EcocaratSalesOutletsViewController

#pragma mark -  button method -

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
    
    int scrollViewWitdh = 400;
    
    if (imageView.frame.size.width > scrollViewWitdh)
    {
        scrollViewWitdh = imageView.frame.size.width;
    }
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 10, scrollViewWitdh, 600)];
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
#pragma mark --- area cities envent-
- (IBAction)tapLiaoNing:(UIButton *)sender
{
    UIImageView *hightLightImageView = nil;
    NSString *detailImageName = nil;
    hightLightImageView = map_liaoning;
    detailImageName = @"ecocarat_so_city_liaoning_detail";
    [self showArea:hightLightImageView];
    [self changeListContent:detailImageName];
}
- (IBAction)tapBeiJing:(UIButton *)sender
{
    UIImageView *hightLightImageView = nil;
    NSString *detailImageName = nil;
    hightLightImageView = map_beijing;
    detailImageName = @"ecocarat_so_city_beijing_detail";
    [self showArea:hightLightImageView];
    [self changeListContent:detailImageName];
}
- (IBAction)tapShanDong:(UIButton *)sender
{
    UIImageView *hightLightImageView = nil;
    NSString *detailImageName = nil;
    hightLightImageView = map_shandong;
    detailImageName = @"ecocarat_so_city_shandong_detail";
    [self showArea:hightLightImageView];
    [self changeListContent:detailImageName];
}
- (IBAction)tapJiangSu:(UIButton *)sender
{
    UIImageView *hightLightImageView = nil;
    NSString *detailImageName = nil;
    hightLightImageView = map_shanghai;
    detailImageName = @"ecocarat_so_city_jiangsu_detail";
    [self showArea:hightLightImageView];
    [self changeListContent:detailImageName];
}
- (IBAction)tapFujian:(UIButton *)sender
{
    UIImageView *hightLightImageView = nil;
    NSString *detailImageName = nil;
    hightLightImageView = map_zhejiang;
    detailImageName = @"ecocarat_so_city_jiangsu_detail";
    [self showArea:hightLightImageView];
    [self changeListContent:detailImageName];
}
- (IBAction)tapShanXi:(UIButton *)sender
{
    UIImageView *hightLightImageView = nil;
    NSString *detailImageName = nil;
    hightLightImageView = map_shan_xi;
    detailImageName = @"ecocarat_so_city_shanxi_detail";
    [self showArea:hightLightImageView];
    [self changeListContent:detailImageName];
}
- (IBAction)tapHuBei:(UIButton *)sender
{

    
}
- (IBAction)tapHuNan:(UIButton *)sender
{
    UIImageView *hightLightImageView = nil;
    NSString *detailImageName = nil;
    hightLightImageView = map_hunan;
    detailImageName = @"ecocarat_so_city_hunan_detail";
    [self showArea:hightLightImageView];
    [self changeListContent:detailImageName];
}
- (IBAction)tapSiChuan:(UIButton *)sender
{
    UIImageView *hightLightImageView = nil;
    NSString *detailImageName = nil;
    hightLightImageView = map_sichuan;
    detailImageName = @"ecocarat_so_city_sichuan_detail";
    [self showArea:hightLightImageView];
    [self changeListContent:detailImageName];
}
- (IBAction)tapGuangDong:(UIButton *)sender
{
    UIImageView *hightLightImageView = nil;
    NSString *detailImageName = nil;
    hightLightImageView = map_guangdong;
    detailImageName = @"ecocarat_so_city_guangdong_detail";
    [self showArea:hightLightImageView];
    [self changeListContent:detailImageName];
}
#pragma mark - area button event -


- (IBAction)cityButtonTouched:(id)sender
{
    int buttonTag = ((UIButton *)sender).tag;
    
    UIImageView *hightLightImageView = nil;
    NSString *detailImageName = nil;
    
    switch (buttonTag)
    {
            //大连
        case 1:
        {
            hightLightImageView = map_liaoning;
            detailImageName = @"ecocarat_so_city_dalian";
        }
            break;
            //常熟
        case 2:
        {
            hightLightImageView = map_shanghai;
            detailImageName = @"ecocarat_so_city_changshu";
        }
            break;
            //常州
        case 3:
        {
            hightLightImageView = map_shanghai;
            detailImageName = @"ecocarat_so_city_changzhou";
        }
            break;
            //广州
        case 4:
        {
            hightLightImageView = map_guangdong;
            detailImageName = @"ecocarat_so_city_guangzhou";
        }
            break;
            //靖江
        case 5:
        {
            hightLightImageView = map_shanghai;
            detailImageName = @"ecocarat_so_city_jingjiang";
        }
            break;
            //烟台
        case 6:
        {
            hightLightImageView = map_shandong;
            detailImageName = @"ecocarat_so_city_yantai";
        }
            break;
            //威海
        case 7:
        {
            hightLightImageView = map_shandong;
            detailImageName = @"ecocarat_so_city_weihai";
        }
            break;
            //青岛
        case 8:
        {
            hightLightImageView = map_shandong;
            detailImageName = @"ecocarat_so_city_qingdao";
        }
            break;
            //北京
        case 9:
        {
            hightLightImageView = map_beijing;
            detailImageName = @"ecocarat_so_city_beijing";
        }
            break;
            //哈尔滨
        case 10:
        {
            hightLightImageView = map_heilongjiang;
            detailImageName = @"ecocarat_so_city_haerbin";
        }
            break;
            //昆山
        case 11:
        {
            hightLightImageView = map_shanghai;
            detailImageName = @"ecocarat_so_city_kunshan";
        }
            break;
            //连云港
        case 12:
        {
            hightLightImageView = map_shanghai;
            detailImageName = @"ecocarat_so_city_lianyungang";
        }
            break;
            //南通
        case 13:
        {
            hightLightImageView = map_shanghai;
            detailImageName = @"ecocarat_so_city_nantong";
        }
            break;
            //兰州
        case 14:
        {
            hightLightImageView = map_gansu;
            detailImageName = @"ecocarat_so_city_lanzhou";
        }
            break;
            //上海
        case 15:
        {
            hightLightImageView = map_shanghai;
            detailImageName = @"ecocarat_so_city_shanghai";
        }
            break;
            //苏州
        case 16:
        {
            hightLightImageView = map_shanghai;
            detailImageName = @"ecocarat_so_city_suzhou";
        }
            break;
            //南京
        case 17:
        {
            hightLightImageView = map_shanghai;
            detailImageName = @"ecocarat_so_city_nanjing";
        }
            break;
            //无锡
        case 18:
        {
            hightLightImageView = map_shanghai;
            detailImageName = @"ecocarat_so_city_wuxi";
        }
            break;
            //深圳
        case 19:
        {
            hightLightImageView = map_guangdong;
            detailImageName = @"ecocarat_so_city_shenzhen";
        }
            break;
            //杭州
        case 20:
        {
            hightLightImageView = map_zhejiang;
            detailImageName = @"ecocarat_so_city_hangzhou";
        }
            break;
            //沈阳
        case 21:
        {
            hightLightImageView = map_liaoning;
            detailImageName = @"ecocarat_so_city_shenyang";
        }
            break;
            //台州
        case 22:
        {
            hightLightImageView = map_zhejiang;
            detailImageName = @"ecocarat_so_city_taizhou";
        }
            break;
            //成都
        case 23:
        {
            hightLightImageView = map_sichuan;
            detailImageName = @"ecocarat_so_city_chengdu";
        }
            break;
            //西安
        case 24:
        {
            hightLightImageView = map_shan_xi;
            detailImageName = @"ecocarat_so_city_xian";
        }
            break;
            //徐州
        case 25:
        {
            hightLightImageView = map_shanghai;
            detailImageName = @"ecocarat_so_city_xuzhou";
        }
            break;
            //盐城
        case 26:
        {
            hightLightImageView = map_shanghai;
            detailImageName = @"ecocarat_so_city_yancheng";
        }
            break;
            //扬州
        case 27:
        {
            hightLightImageView = map_shanghai;
            detailImageName = @"ecocarat_so_city_yangzhou";
        }
            break;
            //银川
        case 28:
        {
            hightLightImageView = map_ningxia;
            detailImageName = @"ecocarat_so_city_yinchuan";
        }
            break;
            //张家港
        case 29:
        {
            hightLightImageView = map_shanghai;
            detailImageName = @"ecocarat_so_city_zhangjiagang";
        }
            break;
            //长沙
        case 30:
        {
            hightLightImageView = map_hunan;
            detailImageName = @"ecocarat_so_city_changsha";
        }
            break;
            //呼和浩特
        case 31:
        {
            hightLightImageView = map_neimenggu;
            detailImageName = @"ecocarat_so_city_huhehaote";
        }
            break;
            //宝鸡
        case 32:
        {
            hightLightImageView = map_shan_xi;
            detailImageName = @"ecocarat_so_city_baoji";
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
                     map_anhui,
                     map_beijing,
                     map_fujian,
                     map_gansu,
                     map_guangdong,
                     map_heilongjiang,
                     map_hunan,
                     map_liaoning,
                     map_neimenggu,
                     map_shan_xi,
                     map_shandong,
                     map_shanghai,
                     map_shanxi,
                     map_sichuan,
                     map_zhejiang,
                     map_ningxia,
                     nil];
    
    for (UIImageView *iv in self.mapArray)
    {
        iv.hidden = YES;
    }
    
    self.pointArray = [NSMutableArray arrayWithObjects:
                       point1,
                       point2,
                       point3,
                       point4,
                       point5,
                       point6,
                       point7,
                       point8,
                       point9,
                       point10,
                       point11,
                       point12,
                       point13,
                       point14,
                       point15,
                       point16,
                       point17,
                       point18,
                       point19,
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

- (IBAction)tapiaoNing:(UIButton *)sender {
}
@end

