//
//  SuccessfulProjects.m
//  SuccessfulProjectsTest
//
//  Created by Mac on 14-2-15.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import "SuccessfulProjects.h"

#define screenWidth     1024
#define screenWidth_2   2048

@interface SuccessfulProjects ()
{
    UIImageView *mainView;                       //上方的主view 所有view再这里显示
    
    ProjectGroup *hotelGroup;
    ProjectGroup *publicGroup;
    ProjectGroup *houseGroup;
    ProjectGroup *olympicsGroup;
    ProjectGroup *expoGroup;
}

@property (nonatomic , strong) NSArray *groupsArray;

@end

@implementation SuccessfulProjects

#pragma mark - user operation -

-(void)selectedGroup:(ProjectGroup *)group
{
    for (ProjectGroup *g in self.groupsArray)
    {
        if (g == group)
        {
            [g selectedProjects];
        }
        else
        {
            [g hideProjects];
        }
    }
}

-(void)OriginAllGroup
{
    for (ProjectGroup *group in self.groupsArray)
    {
        [group orginProjects];
    }
}

#pragma mark - init method -

-(void) initHotelGroup
{
    hotelGroup = [ProjectGroup new];
    
    ProjectObjectMain *hotel = [[ProjectObjectMain alloc] initWithPoint:CGPointMake(760, 80)
                                                       selectedPosition:20
                                                           hidePosition:760+screenWidth_2
                                                           andMoveDelay:0.2
                                                           andImageName:@"sp_hotel"
                                                         andButtonPoint:CGPointMake(80, 150)
                                                     andButtonImageName:@"sp_hotel_button"
                                                         andButtonBlock:^
    {
        [self selectedGroup:hotelGroup];
    }];
    
    [mainView addSubview:hotel];
    [hotelGroup addObject:hotel];
    
    ProjectBackButton *backButton = [[ProjectBackButton alloc] initWithPoint:CGPointMake(30+screenWidth_2, 50)
                                                         andSelectedPosition:30
                                                                    andDelay:0
                                                                andImageName:@"sp_hotel_backbutton"
                                                              andButtonBlock:^
    {
        [self OriginAllGroup];
    }];
    
    [mainView addSubview:backButton];
    [hotelGroup addObject:backButton];
    
    ProjectOthers *introImage = [[ProjectOthers alloc] initWithPoint:CGPointMake(550+screenWidth_2, 40)
                                                 andSelectedPosition:550
                                                            andDelay:0
                                                        andImageName:@"sp_hotel_intro"];
    [mainView addSubview:introImage];
    [hotelGroup addObject:introImage];
    
    ProjectOthers *list = [[ProjectOthers alloc] initWithPoint:CGPointMake(235+screenWidth, 180)
                                                andSelectedPosition:235
                                                           andDelay:0.2
                                                       andImageName:@"sp_hotel_text"];
    [mainView addSubview:list];
    [hotelGroup addObject:list];
    
    ProjectImages *images = [[ProjectImages alloc] initWithFrame:CGRectMake(400+screenWidth, 40, 250, 121)
                                             andSelectedPosition:400
                                                        andDelay:0.2
                                                   andImagesName:[NSArray arrayWithObjects:
                                                                  @"sp_hotel_image1",
                                                                  @"sp_hotel_image2",
                                                                  @"sp_hotel_image3",nil]
                                                  andImagesFrame:[NSArray arrayWithObjects:
                                                                  NSStringFromCGRect(CGRectMake(0, 0, 93, 57)),
                                                                  NSStringFromCGRect(CGRectMake(0, 61, 93, 60)),
                                                                  NSStringFromCGRect(CGRectMake(100, 0, 147, 100)),
                                                                  nil]];
    [mainView addSubview:images];
    [hotelGroup addObject:images];
}


-(void) initPublicGroup
{
    publicGroup = [ProjectGroup new];
    
    ProjectObjectMain *public = [[ProjectObjectMain alloc] initWithPoint:CGPointMake(400, 120)
                                                        selectedPosition:400
                                                            hidePosition:400+screenWidth_2
                                                            andMoveDelay:0.2
                                                            andImageName:@"sp_public"
                                                          andButtonPoint:CGPointMake(-30, 200)
                                                      andButtonImageName:@"sp_public_button"
                                                          andButtonBlock:^
    {
        [self selectedGroup:publicGroup];
    }];

    [mainView addSubview:public];
    [publicGroup addObject:public];
    
    ProjectBackButton *backButton = [[ProjectBackButton alloc] initWithPoint:CGPointMake(30+screenWidth_2, 20)
                                                         andSelectedPosition:30
                                                                    andDelay:0
                                                                andImageName:@"sp_public_intro"
                                                              andButtonBlock:^
                                     {
                                         [self OriginAllGroup];
                                     }];
    
    [mainView addSubview:backButton];
    [publicGroup addObject:backButton];
    
    ProjectOthers *publicPublic = [[ProjectOthers alloc] initWithPoint:CGPointMake(615-screenWidth, 170)
                                                andSelectedPosition:615
                                                           andDelay:0
                                                       andImageName:@"sp_public_public_button"];
    [mainView addSubview:publicPublic];
    [publicGroup addObject:publicPublic];
    
    ProjectOthers *publicBusiness = [[ProjectOthers alloc] initWithPoint:CGPointMake(170+screenWidth, 150)
                                                   andSelectedPosition:170
                                                              andDelay:0
                                                          andImageName:@"sp_public_business_button"];
    [mainView addSubview:publicBusiness];
    [publicGroup addObject:publicBusiness];

    ProjectImages *publicImages = [[ProjectImages alloc] initWithFrame:CGRectMake(870-screenWidth_2, 10, 145, 380)
                                             andSelectedPosition:870
                                                        andDelay:0.2
                                                   andImagesName:[NSArray arrayWithObjects:
                                                                  @"sp_public_public_image1",
                                                                  @"sp_public_public_image2",
                                                                  @"sp_public_public_image3",nil]
                                                  andImagesFrame:[NSArray arrayWithObjects:
                                                                  NSStringFromCGRect(CGRectMake(0, 0, 145, 154)),
                                                                  NSStringFromCGRect(CGRectMake(0, 158, 145, 142)),
                                                                  NSStringFromCGRect(CGRectMake(0, 305, 145, 81)),
                                                                  nil]];
    [mainView addSubview:publicImages];
    [publicGroup addObject:publicImages];
    
    ProjectImages *businessImages = [[ProjectImages alloc] initWithFrame:CGRectMake(55+screenWidth_2, 230, 70, 328)
                                                   andSelectedPosition:55
                                                              andDelay:0.2
                                                         andImagesName:[NSArray arrayWithObjects:
                                                                        @"sp_public_business_image1",
                                                                        @"sp_public_business_image2",
                                                                        @"sp_public_business_image3",
                                                                        @"sp_public_business_image4",nil]
                                                        andImagesFrame:[NSArray arrayWithObjects:
                                                                        NSStringFromCGRect(CGRectMake(0, 0, 70, 77)),
                                                                        NSStringFromCGRect(CGRectMake(0, 79, 70, 77)),
                                                                        NSStringFromCGRect(CGRectMake(0, 158, 70, 63)),
                                                                        NSStringFromCGRect(CGRectMake(0, 223, 70, 107)),
                                                                        nil]];
    [mainView addSubview:businessImages];
    [publicGroup addObject:businessImages];
    
    ProjectScrollObject *businessScroll = [[ProjectScrollObject alloc] initWithFrame:CGRectMake(200+screenWidth, 230, 150, 323)
                                                                 andSelectedPosition:200
                                                                            andDelay:0
                                                                   andTitleImageName:@"sp_public_business"
                                                                  andDeatilImageName:@"sp_public_business_text"];
    [mainView addSubview:businessScroll];
    [publicGroup addObject:businessScroll];
    
    ProjectScrollObject *publicScroll = [[ProjectScrollObject alloc] initWithFrame:CGRectMake(700-screenWidth, 250, 150, 323)
                                                                 andSelectedPosition:700
                                                                            andDelay:0
                                                                   andTitleImageName:@"sp_public_public"
                                                                  andDeatilImageName:@"sp_public_public_text"];
    [mainView addSubview:publicScroll];
    [publicGroup addObject:publicScroll];
}

-(void) initHouseGroup
{
    houseGroup = [ProjectGroup new];
    
    ProjectObjectMain *house = [[ProjectObjectMain alloc] initWithPoint:CGPointMake(0, 150)
                                                       selectedPosition:650
                                                           hidePosition:0+screenWidth_2
                                                           andMoveDelay:0.2
                                                           andImageName:@"sp_house"
                                                         andButtonPoint:CGPointMake(30, 300)
                                                     andButtonImageName:@"sp_house_button"
                                                         andButtonBlock:^
                                {
                                    [self selectedGroup:houseGroup];
                                }];
    
    [mainView addSubview:house];
    [houseGroup addObject:house];
    
    ProjectBackButton *backButton = [[ProjectBackButton alloc] initWithPoint:CGPointMake(30+screenWidth_2, 50)
                                                         andSelectedPosition:30
                                                                    andDelay:0
                                                                andImageName:@"sp_house_backbutton"
                                                              andButtonBlock:^
                                     {
                                         [self OriginAllGroup];
                                     }];
    
    [mainView addSubview:backButton];
    [houseGroup addObject:backButton];
    
    ProjectOthers *introImage = [[ProjectOthers alloc] initWithPoint:CGPointMake(600+screenWidth_2, 40)
                                                 andSelectedPosition:600
                                                            andDelay:0
                                                        andImageName:@"sp_house_intro"];
    [mainView addSubview:introImage];
    [houseGroup addObject:introImage];
    
    ProjectOthers *list = [[ProjectOthers alloc] initWithPoint:CGPointMake(30+screenWidth, 220)
                                                andSelectedPosition:30
                                                           andDelay:0.2
                                                       andImageName:@"sp_house_text"];
    [mainView addSubview:list];
    [houseGroup addObject:list];
    
    ProjectImages *images = [[ProjectImages alloc] initWithFrame:CGRectMake(406+screenWidth, 50, 277, 130)
                                             andSelectedPosition:406
                                                        andDelay:0.2
                                                   andImagesName:[NSArray arrayWithObjects:
                                                                  @"sp_house_image1",
                                                                  @"sp_house_image2",
                                                                  @"sp_house_image3",nil]
                                                  andImagesFrame:[NSArray arrayWithObjects:
                                                                  NSStringFromCGRect(CGRectMake(0, 0, 79, 130)),
                                                                  NSStringFromCGRect(CGRectMake(85, 0, 70, 130)),
                                                                  NSStringFromCGRect(CGRectMake(161, 0, 115, 75)),
                                                                  nil]];
    [mainView addSubview:images];
    [houseGroup addObject:images];
}

-(void) initOlympicsGroup
{
    olympicsGroup = [ProjectGroup new];
    
    ProjectObjectMain *olympics = [[ProjectObjectMain alloc] initWithPoint:CGPointMake(100, 480)
                                                          selectedPosition:550
                                                              hidePosition:100+screenWidth
                                                              andMoveDelay:0
                                                              andImageName:@"sp_olympics"
                                                            andButtonPoint:CGPointMake(50, 50)
                                                        andButtonImageName:@"sp_olympic_button"
                                                            andButtonBlock:^
                                {
                                    [self selectedGroup:olympicsGroup];
                                }];
    
    [mainView addSubview:olympics];
    [olympicsGroup addObject:olympics];
    
    ProjectBackButton *backButton = [[ProjectBackButton alloc] initWithPoint:CGPointMake(30+screenWidth_2, 50)
                                                         andSelectedPosition:30
                                                                    andDelay:0
                                                                andImageName:@"sp_olympic_backbutton"
                                                              andButtonBlock:^
                                     {
                                         [self OriginAllGroup];
                                     }];
    
    [mainView addSubview:backButton];
    [olympicsGroup addObject:backButton];
    
    ProjectOthers *introImage = [[ProjectOthers alloc] initWithPoint:CGPointMake(433+screenWidth_2, 40)
                                                 andSelectedPosition:433
                                                            andDelay:0
                                                        andImageName:@"sp_olympic_intro"];
    [mainView addSubview:introImage];
    [olympicsGroup addObject:introImage];
    
    ProjectOthers *list = [[ProjectOthers alloc] initWithPoint:CGPointMake(60+screenWidth, 220)
                                           andSelectedPosition:60
                                                      andDelay:0.2
                                                  andImageName:@"sp_olympic_text"];
    [mainView addSubview:list];
    [olympicsGroup addObject:list];
    
    ProjectImages *images = [[ProjectImages alloc] initWithFrame:CGRectMake(830+screenWidth, 50, 129, 138)
                                             andSelectedPosition:830
                                                        andDelay:0.2
                                                   andImagesName:[NSArray arrayWithObjects:
                                                                  @"sp_olympic_image1",
                                                                  @"sp_olympic_image2",
                                                                  @"sp_olympic_image3",nil]
                                                  andImagesFrame:[NSArray arrayWithObjects:
                                                                  NSStringFromCGRect(CGRectMake(0, 0, 129, 83)),
                                                                  NSStringFromCGRect(CGRectMake(0, 90, 72, 48)),
                                                                  NSStringFromCGRect(CGRectMake(79, 90, 49, 49)),
                                                                  nil]];
    [mainView addSubview:images];
    [olympicsGroup addObject:images];
}

-(void) initExpoGroup
{
    expoGroup = [ProjectGroup new];
    
    ProjectObjectMain *expo = [[ProjectObjectMain alloc] initWithPoint:CGPointMake(510, 420)
                                                      selectedPosition:20
                                                          hidePosition:510+screenWidth
                                                          andMoveDelay:0
                                                          andImageName:@"sp_expo"
                                                        andButtonPoint:CGPointMake(150, 50)
                                                    andButtonImageName:@"sp_expo_button"
                                                        andButtonBlock:^
                                   {
                                       [self selectedGroup:expoGroup];
                                   }];
    
    [mainView addSubview:expo];
    [expoGroup addObject:expo];
    
    ProjectBackButton *backButton = [[ProjectBackButton alloc] initWithPoint:CGPointMake(30+screenWidth_2, 50)
                                                         andSelectedPosition:30
                                                                    andDelay:0
                                                                andImageName:@"sp_expo_backbutton"
                                                              andButtonBlock:^
                                     {
                                         [self OriginAllGroup];
                                     }];
    
    [mainView addSubview:backButton];
    [expoGroup addObject:backButton];
    
    ProjectOthers *introImage = [[ProjectOthers alloc] initWithPoint:CGPointMake(350+screenWidth_2, 20)
                                                 andSelectedPosition:350
                                                            andDelay:0
                                                        andImageName:@"sp_expo_intro"];
    [mainView addSubview:introImage];
    [expoGroup addObject:introImage];
    
    ProjectOthers *list = [[ProjectOthers alloc] initWithPoint:CGPointMake(65+screenWidth, 200)
                                                andSelectedPosition:65
                                                           andDelay:0.2
                                                       andImageName:@"sp_expo_text"];
    [mainView addSubview:list];
    [expoGroup addObject:list];
    
    ProjectImages *images = [[ProjectImages alloc] initWithFrame:CGRectMake(800+screenWidth, 240, 164, 232)
                                             andSelectedPosition:800
                                                        andDelay:0.2
                                                   andImagesName:[NSArray arrayWithObjects:
                                                                  @"sp_expo_image1",
                                                                  @"sp_expo_image2",
                                                                  @"sp_expo_image3",
                                                                  @"sp_expo_image4",nil]
                                                  andImagesFrame:[NSArray arrayWithObjects:
                                                                  NSStringFromCGRect(CGRectMake(0, 0, 164, 60)),
                                                                  NSStringFromCGRect(CGRectMake(0, 66, 164, 53)),
                                                                  NSStringFromCGRect(CGRectMake(0, 126, 80, 107)),
                                                                  NSStringFromCGRect(CGRectMake(86, 126, 80, 107)),
                                                                  nil]];
    [mainView addSubview:images];
    [expoGroup addObject:images];
}

- (void) initView
{
    [self initHotelGroup];
    [self initPublicGroup];
    [self initHouseGroup];
    [self initExpoGroup];
    [self initOlympicsGroup];
    
    self.groupsArray = [NSArray arrayWithObjects:hotelGroup,publicGroup,houseGroup,olympicsGroup,expoGroup,nil];
}

#pragma mark - life cycle -

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.view.frame = CGRectMake(0, 0, 1024, 707);
        self.view.layer.masksToBounds = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    mainView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1024, 580)];
    mainView.backgroundColor = [UIColor clearColor];
    mainView.image = [UIImage imageNamed:@"sp_bg"];
    mainView.layer.masksToBounds = YES;
    mainView.userInteractionEnabled = YES;
    [self.view addSubview:mainView];
    
    UIImageView *bottomView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 570, 1024, 163)];
    bottomView.image = [UIImage imageNamed:@"sp_bottomimage"];
    [self.view addSubview:bottomView];
    
    [self initView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
