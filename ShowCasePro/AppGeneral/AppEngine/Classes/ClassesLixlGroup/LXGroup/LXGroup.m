//
//  LXGroup.m
//  LXGroupDemo
//
//  Created by Mac on 14-3-10.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import "LXGroup.h"
#import "UserGuideTips.h"
#define Animation_Duration_lxgroup 0.25

typedef void(^endBlock)(void);

@interface LXGroup ()
{
    
    __weak IBOutlet UIView *masterView;
    __weak IBOutlet UIView *listView;
    
    
    //对应深色区域
    __weak IBOutlet UIImageView *chinaMap;
    __weak IBOutlet UIImageView *northMap;
    __weak IBOutlet UIImageView *middleEastMap;
    __weak IBOutlet UIImageView *eastMap;
    __weak IBOutlet UIImageView *northEastMap;
    __weak IBOutlet UIImageView *northWestMap;
    __weak IBOutlet UIImageView *middleMap;
    __weak IBOutlet UIImageView *westMap;
    __weak IBOutlet UIImageView *southMap;
    
    
    
    //各个小点  随机出现
    __weak IBOutlet UIImageView *pointNorthEast1;
    __weak IBOutlet UIImageView *pointNorthEast2;
    __weak IBOutlet UIImageView *pointNorth1;
    __weak IBOutlet UIImageView *pointNorth2;
    __weak IBOutlet UIImageView *pointNorth3;
    __weak IBOutlet UIImageView *pointChina1;
    __weak IBOutlet UIImageView *pointChina2;
    __weak IBOutlet UIImageView *pointChina3;
    __weak IBOutlet UIImageView *pointChina4;
    __weak IBOutlet UIImageView *pointEast1;
    __weak IBOutlet UIImageView *pointEast2;
    __weak IBOutlet UIImageView *pointUnuse1;
    __weak IBOutlet UIImageView *pointUnuse2;
    __weak IBOutlet UIImageView *pointSouth1;
    __weak IBOutlet UIImageView *pointSouth2;
    __weak IBOutlet UIImageView *pointSouth3;
    __weak IBOutlet UIImageView *pointSouth4;
    __weak IBOutlet UIImageView *pointNorthWest1;
    __weak IBOutlet UIImageView *pointWest1;
    __weak IBOutlet UIImageView *pointMiddle1;
    
}

@property (nonatomic , strong) NSArray *mapArray;

@property (nonatomic , strong) UIImageView *currentAreaList;

@property (nonatomic , strong) NSMutableArray *pointArray;//所有的小点  进入后随机依次出现

@end

@implementation LXGroup

- (IBAction)backButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}

- (IBAction)settingButton:(id)sender
{
    
}




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
    [masterView addSubview:imageView];
    
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

#pragma mark - area button event -

- (IBAction)chinaArea
{
    [self showArea:chinaMap];
    [self changeListContent:@"lx_group_china"];
}

- (IBAction)northArea
{
    [self showArea:northMap];
    [self changeListContent:@"lx_group_north"];
}

- (IBAction)middleEastArea
{
    [self showArea:middleEastMap];
    [self changeListContent:@"lx_group_middle_east"];
}

- (IBAction)eastArea
{
    [self showArea:eastMap];
    [self changeListContent:@"lx_group_east"];
}

- (IBAction)northEastArea
{
    [self showArea:northEastMap];
    [self changeListContent:@"lx_group_north_east"];
}

- (IBAction)northWestArea
{
    [self showArea:northWestMap];
    [self changeListContent:@"lx_group_north_west"];
}

- (IBAction)middleArea
{
    [self showArea:middleMap];
    [self changeListContent:@"lx_group_middle"];
}

- (IBAction)westArea
{
    [self showArea:westMap];
    [self changeListContent:@"lx_group_west"];
}

- (IBAction)southArea
{
    [self showArea:southMap];
    [self changeListContent:@"lx_group_south"];
}


#pragma mark - hide button event -


- (IBAction)hideButtonEvent
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

    UserGuideTips *userGuideTip = [UserGuideTips shareInstance];
    [userGuideTip showUserGuideView:self.view tipKey:@"LixiGroup" imageNamePre:@"lixiiGroupTip"];
    
    
    self.searchModuleView.hidden = YES;
    
    self.mapArray = [NSArray arrayWithObjects:
                     chinaMap,
                     northMap,
                     middleEastMap,
                     eastMap,
                     northEastMap,
                     northWestMap,
                     middleMap,
                     westMap,
                     southMap,
                     nil];
    
    for (UIImageView *iv in self.mapArray)
    {
        iv.hidden = YES;
    }
    
    self.pointArray = [NSMutableArray arrayWithObjects:
                       pointNorthEast1,
                       pointNorthEast2,
                       pointNorth1,
                       pointNorth2,
                       pointNorth3,
                       pointChina1,
                       pointChina2,
                       pointChina3,
                       pointChina4,
                       pointEast1,
                       pointEast2,
                       pointUnuse1,
                       pointUnuse2,
                       pointSouth1,
                       pointSouth2,
                       pointSouth3,
                       pointSouth4,
                       pointNorthWest1,
                       pointWest1,
                       pointMiddle1,
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

@end
