//
//  LeadingTech.m
//  LeadingTechTest
//
//  Created by Mac on 14-2-20.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import "LeadingTech.h"
#import "POPDViewController.h"

#define Animation_Druation  0.5
#define Cell_Tag            123191047


#define Cell_Title  @"Cell_Title"
#define Cell_Detail @"Cell_Detail"
#define Cell_Image  @"Cell_Image"
#define Cell_Icon   @"Cell_Icon"

@interface LeadingTech ()
{
    __weak IBOutlet UIImageView *bg;
    
    //几道光的效果
    __weak IBOutlet UIImageView *lightBg;
    
    __weak IBOutlet UIImageView *hengwen;
    __weak IBOutlet UIImageView *ganying;
    __weak IBOutlet UIImageView *taocifaxin;
    __weak IBOutlet UIImageView *shuangchongchaoqiang;
    __weak IBOutlet UIImageView *gaoxiaochongshui;
    __weak IBOutlet UIImageView *younengfaxin;
    __weak IBOutlet UIImageView *shuangchonghongxi;
    __weak IBOutlet UIImageView *linyufang;
    __weak IBOutlet UIImageView *zhinenglinyu;
    
    __weak IBOutlet UIImageView *empty1;
    __weak IBOutlet UIImageView *empty2;
    __weak IBOutlet UIImageView *empty3;
    __weak IBOutlet UIImageView *empty4;
    __weak IBOutlet UIImageView *empty5;
    
    BOOL moved;//用于判断是否已经散开
    
    
    UIImageView *cellDetailView;//中间的详细视图
    
    UIView *leftIntroView; //左侧的滑出视图
    
    DynamicImageView *div;    //滑出视图上的icon
    POPDViewController *popView;//可展开的详细介绍
}

//所有对象
@property(nonatomic,strong) NSArray *allObjects;
//所有对象的frame
@property(nonatomic,strong) NSMutableArray *allObjectsFrame;
//所有对象改变后的frame
@property(nonatomic,strong) NSArray *allObjectsMovedFrame;

//可展开介绍数据源数组
@property(nonatomic,strong) NSArray *dataSourceArray;

@end

@implementation LeadingTech







#pragma mark - tap gesture -

- (void) cellTaped:(UITapGestureRecognizer *)tap
{
    int index = tap.view.tag - Cell_Tag;
    
    if (!moved)
    {
        moved = YES;
        
        lightBg.alpha = 0;
        
        [self fitDataWithIndex:index];
        
        [UIView animateWithDuration:Animation_Druation animations:^
         {
             for (UIImageView *iv in self.allObjects)
             {
                 CGRect frame = CGRectFromString([self.allObjectsMovedFrame objectAtIndex:[self.allObjects indexOfObject:iv]]);
                 
                 iv.frame = frame;
             }
             
             cellDetailView.alpha = 1;
             
             CGRect frame = leftIntroView.frame;
             frame.origin.x = 10;
             leftIntroView.frame = frame;
             
         } completion:^(BOOL finished)
         {
             double delayInSeconds = 0.5;
             dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
             dispatch_after(popTime, dispatch_get_main_queue(),^{
                 [div moveLight];
             });
             
         }];
    }
    else
    {
        [self fitDataWithIndex:index];
    }
}

- (void) fitDataWithIndex:(int)index
{
    NSDictionary *dic = [self.dataSourceArray objectAtIndex:index];
    
    //左边滑出视图的icon
    div.image = [UIImage imageNamed:[dic objectForKey:Cell_Icon]];
    [div moveLight];
    
    //中间部分的详细介绍
    cellDetailView.image = [UIImage imageNamed:[dic objectForKey:Cell_Image]];
    
    //左边详细介绍的数据源
    [self changePopviewData:dic];
}

- (void) bgTaped
{
    if (moved)
    {
        [UIView animateWithDuration:Animation_Druation animations:^
         {
             for (UIImageView *iv in self.allObjects)
             {
                 CGRect frame = CGRectFromString([self.allObjectsFrame objectAtIndex:[self.allObjects indexOfObject:iv]]);
                 
                 iv.frame = frame;
             }
             
             
             cellDetailView.alpha = 0;
             
             CGRect frame = leftIntroView.frame;
             frame.origin.x = -310;
             leftIntroView.frame = frame;

         } completion:^(BOOL finished)
         {
             moved = NO;
             
             lightBg.alpha = 1;
         }];
    }
}

#pragma mark - life cycle -

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        if ([UIDevice currentDevice].systemVersion.floatValue >=7.0)
        {
            self.edgesForExtendedLayout = UIRectEdgeNone;
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.allObjects = [NSArray arrayWithObjects:
                            hengwen,
                            ganying,
                            taocifaxin,
                            shuangchongchaoqiang,
                            gaoxiaochongshui,
                            younengfaxin,
                            shuangchonghongxi,
                            linyufang,
                            zhinenglinyu,
                            empty1,
                            empty2,
                            empty3,
                            empty4,
                            empty5,
                            nil];
    
    self.allObjectsFrame = [NSMutableArray array];
    
    for (UIImageView *iv in self.allObjects)
    {
        NSString *ivFrame = NSStringFromCGRect(iv.frame);
        
        [self.allObjectsFrame addObject:ivFrame];
        
        iv.tag = Cell_Tag + [self.allObjects indexOfObject:iv];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellTaped:)];
        tap.numberOfTapsRequired = 1;
        tap.numberOfTouchesRequired = 1;
        [iv addGestureRecognizer:tap];
    }
    
    self.allObjectsMovedFrame = [NSArray arrayWithObjects:
                                 NSStringFromCGRect(CGRectMake(70, 419, 173, 151)),
                                 NSStringFromCGRect(CGRectMake(696, 531, 173, 151)),//感应技术
                                 NSStringFromCGRect(CGRectMake(203, 496, 173, 151)),
                                 NSStringFromCGRect(CGRectMake(828, 0, 173, 151)),
                                 NSStringFromCGRect(CGRectMake(695, 76, 173, 151)),
                                 NSStringFromCGRect(CGRectMake(696, 380, 173, 151)),
                                 NSStringFromCGRect(CGRectMake(828, 152, 173, 151)),
                                 NSStringFromCGRect(CGRectMake(828, 304, 173, 151)),
                                 NSStringFromCGRect(CGRectMake(828, 456, 173, 151)),
                                 NSStringFromCGRect(CGRectMake(313, 26, 173, 151)),
                                 NSStringFromCGRect(CGRectMake(562, 152, 173, 151)),
                                 NSStringFromCGRect(CGRectMake(329, 719, 173, 151)),
                                 NSStringFromCGRect(CGRectMake(1100, 203, 173, 151)),
                                 NSStringFromCGRect(CGRectMake(203, 343, 173, 151)),//empty5
                                 nil];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgTaped)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [bg addGestureRecognizer:tap];
    
    moved = NO;
    
    
    
    UIImage *cellDetailImage = [UIImage imageNamed:@"lt_taocifaxin_detail"];
    CGSize cellDetailSize = cellDetailImage.size;
    cellDetailView = [[UIImageView alloc] initWithFrame:CGRectMake((1024-cellDetailSize.width/2)/2, (768-cellDetailSize.height/2)/2-50, cellDetailSize.width/2, cellDetailSize.height/2)];
    cellDetailView.image = cellDetailImage;
    [self.view addSubview:cellDetailView];
    cellDetailView.alpha = 0;
    
    leftIntroView = [[UIView alloc] initWithFrame:CGRectMake(-310, 10, 150, 700)];
    leftIntroView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:leftIntroView];
    
    div = [[DynamicImageView alloc] initWithFrame:CGRectMake(10, 10, 122, 122)];
    div.image = [UIImage imageNamed:@"lt_taocifaxin_icon"];
    [leftIntroView addSubview:div];
    
    
    /////////////////点击某个cell后将数据源替换成对应的array
    NSDictionary *dic_hengwen = [NSDictionary dictionaryWithObjects:@[@[@"lt_hengwenjishu_intro1",
                                                                           @"lt_hengwenjishu_intro2"],
                                                                      @[@"lt_hengwenjishu_intro1_detail",
                                                                        @"lt_hengwenjishu_intro2_detail"],
                                                                         @"lt_hengwenjishu_icon",
                                                                         @"lt_hengwenjishu_detail"]
                                                               forKeys:@[Cell_Title,Cell_Detail,Cell_Icon,Cell_Image]];
    
    NSDictionary *dic_ganying = [NSDictionary dictionaryWithObjects:@[@[@"lt_ganyingjishu_intro1",
                                                                        @"lt_ganyingjishu_intro2",
                                                                        @"lt_ganyingjishu_intro3",
                                                                        @"lt_ganyingjishu_intro4"],
                                                                         @[@"lt_ganyingjishu_intro1_detail",
                                                                           @"lt_ganyingjishu_intro2_detail",
                                                                           @"lt_ganyingjishu_intro3_detail",
                                                                           @"lt_ganyingjishu_intro4_detail"],
                                                                      @"lt_ganyingjishu_icon",
                                                                      @"lt_ganyingjishu_detail"]
                                                               forKeys:@[Cell_Title,Cell_Detail,Cell_Icon,Cell_Image]];
    
    NSDictionary *dic_taocifaxin = [NSDictionary dictionaryWithObjects:@[@[@"lt_taocifaxin_intro1",
                                                                           @"lt_taocifaxin_intro2",
                                                                           @"lt_taocifaxin_intro3"],
                                                                         @[@"lt_taocifaxin_intro1_detail",
                                                                           @"lt_taocifaxin_intro2_detail",
                                                                           @"lt_taocifaxin_intro3_detail"],
                                                                         @"lt_taocifaxin_icon",
                                                                         @"lt_taocifaxin_detail"]
                                                               forKeys:@[Cell_Title,Cell_Detail,Cell_Icon,Cell_Image]];
    
    NSDictionary *dic_shuangchongchaoqiang = [NSDictionary dictionaryWithObjects:@[@[@"lt_shuangchongchaoqiang_intro1",
                                                                                     @"lt_shuangchongchaoqiang_intro2",
                                                                                     @"lt_shuangchongchaoqiang_intro3",
                                                                                     @"lt_shuangchongchaoqiang_intro4",
                                                                                     @"lt_shuangchongchaoqiang_intro5",
                                                                                     @"lt_shuangchongchaoqiang_intro6"],
                                                                                   @[@"lt_shuangchongchaoqiang_intro1_detail",
                                                                                     @"lt_shuangchongchaoqiang_intro2_detail",
                                                                                     @"lt_shuangchongchaoqiang_intro3_detail",
                                                                                     @"lt_shuangchongchaoqiang_intro4_detail",
                                                                                     @"lt_shuangchongchaoqiang_intro5_detail",
                                                                                     @"lt_shuangchongchaoqiang_intro6_detail"],
                                                                                   @"lt_shuangchongchaoqiang_icon",
                                                                                   @"lt_shuangchongchaoqiang_detail"]
                                                               forKeys:@[Cell_Title,Cell_Detail,Cell_Icon,Cell_Image]];
    
    NSDictionary *dic_gaoxiaochongshui = [NSDictionary dictionaryWithObjects:@[@[@"lt_gaoxiaochongshui_intro1",
                                                                                 @"lt_gaoxiaochongshui_intro2",
                                                                                 @"lt_gaoxiaochongshui_intro3",
                                                                                 @"lt_gaoxiaochongshui_intro4"],
                                                                         @[@"lt_gaoxiaochongshui_intro1_detail",
                                                                           @"lt_gaoxiaochongshui_intro2_detail",
                                                                           @"lt_gaoxiaochongshui_intro3_detail",
                                                                           @"lt_gaoxiaochongshui_intro4_detail"],
                                                                               @"lt_gaoxiaochongshui_icon",
                                                                               @"lt_gaoxiaochongshui_detail"]
                                                               forKeys:@[Cell_Title,Cell_Detail,Cell_Icon,Cell_Image]];
    
    NSDictionary *dic_younengfaxin = [NSDictionary dictionaryWithObjects:@[@[@"lt_younengfaxin_intro1"],
                                                                         @[@"lt_younengfaxin_intro1_detail"],
                                                                           @"lt_younengfaxin_icon",
                                                                           @"lt_younengfaxin_detail"]
                                                               forKeys:@[Cell_Title,Cell_Detail,Cell_Icon,Cell_Image]];
    
    NSDictionary *dic_shuangchonghongxi = [NSDictionary dictionaryWithObjects:@[@[@"lt_shuangchonghongxi_intro1",
                                                                                  @"lt_shuangchonghongxi_intro2",
                                                                                  @"lt_shuangchonghongxi_intro3",
                                                                                  @"lt_shuangchonghongxi_intro4"],
                                                                                @[@"lt_shuangchonghongxi_intro1_detail",
                                                                                  @"lt_shuangchonghongxi_intro2_detail",
                                                                                  @"lt_shuangchonghongxi_intro3_detail",
                                                                                  @"lt_shuangchonghongxi_intro4_detail"],
                                                                                @"lt_shuangchonghongxi_icon",
                                                                                @"lt_shuangchonghongxi_detail"]
                                                               forKeys:@[Cell_Title,Cell_Detail,Cell_Icon,Cell_Image]];
    
    NSDictionary *dic_linyufang = [NSDictionary dictionaryWithObjects:@[@[@"lt_linyufang_intro1",
                                                                          @"lt_linyufang_intro2",
                                                                          @"lt_linyufang_intro3",
                                                                          @"lt_linyufang_intro4",
                                                                          @"lt_linyufang_intro5"],
                                                                        @[@"lt_linyufang_intro1_detail",
                                                                          @"lt_linyufang_intro2_detail",
                                                                          @"lt_linyufang_intro3_detail",
                                                                          @"lt_linyufang_intro4_detail",
                                                                          @"lt_linyufang_intro5_detail"],
                                                                        @"lt_linyufang_icon",
                                                                        @"lt_linyufang_detail"]
                                                               forKeys:@[Cell_Title,Cell_Detail,Cell_Icon,Cell_Image]];
    
    NSDictionary *dic_zhinenglinyu = [NSDictionary dictionaryWithObjects:@[@[@"lt_zhinenglinyu_intro1"],
                                                                         @[@"lt_zhinenglinyu_intro1_detail"],
                                                                           @"lt_zhinenglinyu_icon",
                                                                           @"lt_zhinenglinyu_detail"]
                                                               forKeys:@[Cell_Title,Cell_Detail,Cell_Icon,Cell_Image]];
    
    
    self.dataSourceArray = [NSArray arrayWithObjects:
                            dic_hengwen,
                            dic_ganying,
                            dic_taocifaxin,
                            dic_shuangchongchaoqiang,
                            dic_gaoxiaochongshui,
                            dic_younengfaxin,
                            dic_shuangchonghongxi,
                            dic_linyufang,
                            dic_zhinenglinyu,
                            nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 更换新的popview -

- (void) changePopviewData:(NSDictionary *)dic
{
    if (popView)
    {
        [popView.view removeFromSuperview];
        [popView removeFromParentViewController];
    }
    
    popView = [[POPDViewController alloc] initWithTitleArray:[dic objectForKey:Cell_Title]  detailArray:[dic objectForKey:Cell_Detail]];
    popView.view.frame = CGRectMake(10, 130, 300, leftIntroView.frame.size.height);
    [popView.tableView reloadData];
    [leftIntroView addSubview:popView.view];
    [self addChildViewController:popView];
}

@end






