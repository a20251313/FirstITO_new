//
//  SashPhilosophyViewController.m
//  ShowCasePro
//
//  Created by Mac on 14-4-8.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "SashPhilosophyViewController.h"
#define Animation_Duration_EcocaratPhilosophy 1


#define SASHDOMESTICARRAY @"SASHDOMESTICARRAY"
@interface SashPhilosophyViewController ()
{
    __weak IBOutlet UIImageView *middleImage;
    __weak IBOutlet UIImageView *bottomImage;
    __weak IBOutlet UIScrollView *refView;
    __weak IBOutlet UIView *topView;
    __weak IBOutlet UIImageView *middleBlueImg;
    __weak IBOutlet UIImageView *bottomBlueImg;
    
    UIImageView *desImg;

    
    
    UIButton  *btnMakeSure;
    UITextField  *textInput;
    int             m_iclickChangeBtn;  //2 middle 3 bottom
    NSMutableArray  *m_arrayTopData;
    NSMutableArray  *m_arrayBottomData;
    NSMutableArray  *m_arrayMiddleData;

}

@end

@implementation SashPhilosophyViewController

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
    middleImage.alpha = 1;
    bottomImage.alpha = 0;
    
    [self addArrayData];
}

#pragma mark   add actions
-(void)setInputViewHidden:(BOOL)bHide
{
    
    
    CGFloat fXpoint = 438;
    CGFloat fwidth = 832+48-fXpoint;
    CGFloat fypoint = 150;
    CGFloat fheight = 45;
    //  293 683+48
    UIView  *bgView = [self.view viewWithTag:1234567];
    if (!bgView && !bHide)
    {
        bgView = [[UIView alloc] initWithFrame:CGRectMake(fXpoint, fypoint, fwidth, fheight)];
        bgView.tag = 1234567;
        textInput = [[UITextField alloc] initWithFrame:CGRectMake(5, 2, fwidth-48-5, 40)];
        [bgView addSubview:textInput];
        btnMakeSure = [[UIButton alloc] initWithFrame:CGRectMake(fwidth-60, 5, 60, 35)];
        [btnMakeSure setTitle:@"确定" forState:UIControlStateNormal];
        [btnMakeSure setBackgroundColor:[UIColor clearColor]];
        [bgView addSubview:btnMakeSure];
        [btnMakeSure addTarget:self action:@selector(makeSureAdd:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:bgView];
        [bgView setBackgroundColor:[UIColor colorWithRed:214.0/255.0 green:91.0/255.0 blue:29.0/255.0 alpha:1]];
        
        
    }
    
    fypoint = topView.frame.origin.y;
    [bgView setFrame:CGRectMake(fXpoint, fypoint, fwidth, fheight)];
    bgView.hidden = bHide;
    
}


-(void)setNameLabelHidden:(BOOL)bhide
{
    for (UILabel *label in refView.subviews)
    {
        if ([label isKindOfClass:[UILabel class]])
        {
            label.hidden = bhide;
        }
        
    }
}

-(IBAction)clickAddMethod:(id)sender
{
    [self setInputViewHidden:NO];
}

-(void)addArrayData
{
    
    
    
    if (!m_arrayMiddleData)
    {
        m_arrayMiddleData = [[NSMutableArray alloc] init];
    }
    if (!m_arrayBottomData)
    {
        m_arrayBottomData = [[NSMutableArray alloc] init];
    }
    //   NSArray *arrayHotel = @[@"无锡希尔顿酒店",@"苏州香格里拉酒店",@"苏州新城花园二期",@"靖江滨江花园酒店",@"济南东海顺丰大酒店",@"济南枣庄清御园大酒店",@"山东广饶东营国际大酒店",@"上海衡山至尊酒店",@"南京双门楼酒店",@"杭州灵隐九里松酒店",@"长沙远大T30酒店",@"长沙中通戴斯酒店",@"西安中兴和泰酒店",@"南昌宾馆",@"北京长白山国际酒店"];
    NSArray *arrayHouse = @[@"昆山 同和工厂",@"杭州绿城西溪PJ",@"大连THK工厂",@"积水HOUSE中国",@"扬州 豪第坊",@"MISAWA-HOME 昆明",@"大阪风情III期",@"麦岛麦尔文艺墅"];
    
    //NSArray *arrayPublic = @[@"WORLD CITY TOWER",@"PARK CITY TOYOSU",@"WONDER BAY CITY SAZAN",@"SHIBAURA ISLAND CAPE TOWER",@"BRILLLIA ARIAKE SKY TOWER",@"BRILLIA MARE ARIAKE",@"SHIBAURA ISLAND BROOM",@"CAPITAL MARK TOWER",@"SHIBAURA ISLAND GROVE TOWER",@"SHIBAYRA ISLAND AIR",@"MILLENARY TOWERS",@"CATELINA MITA TOWER",@"RELIZE GARDEN",@"GRAND HORAIZON TOKYO BAY"];
    
    // [m_arrayTopData addObjectsFromArray:arrayHotel];
 //   [m_arrayMiddleData addObjectsFromArray:arrayHouse];
  //  [m_arrayBottomData addObjectsFromArray:arrayPublic];
    NSArray *arrayData = [[NSUserDefaults standardUserDefaults] valueForKey:SASHDOMESTICARRAY];
    
    if (arrayData.count)
    {
        [m_arrayMiddleData addObjectsFromArray:arrayData];
    }else
    {
         [m_arrayMiddleData addObjectsFromArray:arrayHouse];
    }
    /*arrayData = [[NSUserDefaults standardUserDefaults] valueForKey:WOODLENOVERSEASARRAY];
    
    if (arrayData.count)
    {
        [m_arrayBottomData addObjectsFromArray:arrayData];
    }*/
    
    
}

-(void)reloadDataWithScrollerView:(UIView*)scrollView
{
    [self setInputViewHidden:YES];
    
    for (UILabel *label in scrollView.subviews)
    {
        if ([label isKindOfClass:[UILabel class]])
        {
            [label removeFromSuperview];
        }
    }
    
    NSMutableArray *arrayData = nil;
    switch (m_iclickChangeBtn)
    {
        case 1:
            arrayData = m_arrayTopData;
            break;
        case 2:
            arrayData = m_arrayMiddleData;
            break;
        case 3:
            arrayData = m_arrayBottomData;
            break;
            
        default:
            break;
    }
    CGFloat   fsep = 10;
    CGFloat   fwidth = (scrollView.frame.size.width-10*3)/3;
    CGFloat   fxpoint = 10;
    CGFloat   fypoint = 10;
    CGFloat   fysep = 20;
    CGFloat   fheight = 30;
    for (int i = 0; i < arrayData.count;i++ )
    {
        fxpoint = (i%3)*(fsep+fwidth)+fsep;
        fypoint = (i/3)*fheight+fysep;
        
        UILabel *labelText = [[UILabel alloc] initWithFrame:CGRectMake(fxpoint, fypoint, fwidth, fheight)];
        [labelText setBackgroundColor:[UIColor clearColor]];
        [labelText setTextColor:[UIColor blackColor]];
        [labelText setFont:[UIFont systemFontOfSize:13]];
        labelText.adjustsFontSizeToFitWidth = YES;
        [refView addSubview:labelText];
        [labelText setText:arrayData[i]];
        
    }
    
    
    [refView setContentSize:CGSizeMake(refView.frame.size.width, fypoint+fheight)];
    
    //[UIColor colorWithRed:232.0/255.0 green:250.0/255.0 blue:254.0/255.0 alpha:1]
    [refView setBackgroundColor:[UIColor whiteColor]];
    refView.clipsToBounds = YES;
    refView.showsHorizontalScrollIndicator = NO;
    refView.showsVerticalScrollIndicator = NO;
    
}

-(void)makeSureAdd:(id)sender
{
    [self setInputViewHidden:YES];
    [self.view endEditing:YES];
    
    if ([textInput.text length])
    {
        switch (m_iclickChangeBtn)
        {
           /* case 1:
                [m_arrayTopData addObject:textInput.text];
                [[NSUserDefaults standardUserDefaults] setObject:m_arrayTopData forKey:WOODLENOVERSEASARRAY];
                
                break;*/
            case 2:
                [m_arrayMiddleData addObject:textInput.text];
                [[NSUserDefaults standardUserDefaults] setObject:m_arrayMiddleData forKey:SASHDOMESTICARRAY];
                break;
            case 3:
              //  [m_arrayBottomData addObject:textInput.text];
               // [[NSUserDefaults standardUserDefaults] setObject:m_arrayBottomData forKey:WOODLENOVERSEASARRAY];
                break;
                
            default:
                break;
        }
        
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [self reloadDataWithScrollerView:refView];
        
    }
    
    
}

#pragma MARK middleBtnPressed
- (IBAction)middleBtnPressed:(UIButton *)sender {
    
    m_iclickChangeBtn = 2;
    if(bottomBlueImg.alpha == 1)
    {
        bottomBlueImg.alpha = 0;
    }
    if(middleBlueImg.alpha !=1)
    {
        
        [UIView animateWithDuration:Animation_Duration_EcocaratPhilosophy animations:^{
            
            middleImage.alpha = 1;
            bottomImage.alpha = 0;
            
        }];
        
        refView.alpha = 1;
        middleBlueImg.alpha =1;
        topView.alpha =1;
       
     /*  UIImage *imgdes = [UIImage imageNamed:@"sash_ph_do_des.png"];
        
        desImg =[[UIImageView alloc] initWithFrame:CGRectMake(20, 10, imgdes.size.width/2, imgdes.size.height/2)];
        desImg.image = imgdes;
        [refView addSubview:desImg];
     */
    }
    
    [self reloadDataWithScrollerView:refView];
    
 //  if(desImg.alpha ==0) desImg.alpha = 1;

}
- (IBAction)bottomBtnPressed:(UIButton *)sender {
//    if(middleBlueImg.alpha == 1)
//    {
//        middleBlueImg.alpha = 0;
//    }
//    //if(bottomScroll.alpha!=1)bottomScroll.alpha =1;
//    
//    if(bottomBlueImg.alpha !=1)
//    {
//        
//        [UIView animateWithDuration:Animation_Duration_EcocaratPhilosophy animations:^{
//            middleImage.alpha = 0;
//            bottomImage.alpha = 1;
//            
//        }];
//        topView.alpha =1;
//        desImg.alpha = 0;
//        refView.alpha = 1;
//        bottomBlueImg.alpha =1;
//      
//    }
//    
//    
//    if(desImg.alpha ==1) desImg.alpha = 0;

}
- (IBAction)closeBtnPressed:(UIButton *)sender {
    

    if(middleBlueImg.alpha ==1)
    {
        middleBlueImg.alpha = 0;
        refView.alpha = 0;
        topView.alpha = 0;
        desImg.alpha = 0;
    }
    

}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
