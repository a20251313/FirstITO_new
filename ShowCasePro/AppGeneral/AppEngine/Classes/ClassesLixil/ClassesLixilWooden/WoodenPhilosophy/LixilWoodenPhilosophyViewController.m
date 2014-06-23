//
//  LixilWoodenPhilosophyViewController.m
//  ShowCasePro
//
//  Created by Mac on 14-3-27.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "LixilWoodenPhilosophyViewController.h"
#define Animation_Duration_WoodenPhilosophy 0.7



#define WOODLENDOMESTICARRAY  @"WOODLENDOMESTICARRAY"
#define WOODLENOVERSEASARRAY  @"WOODLENOVERSEASARRAY"
@interface LixilWoodenPhilosophyViewController ()
{
    
    __weak IBOutlet UIImageView *middleImage;
    __weak IBOutlet UIImageView *bottomImage;
   
    
    __weak IBOutlet UIImageView *middleRefImage;
    __weak IBOutlet UIImageView *bottomRefImage;
    __weak IBOutlet UIScrollView *refView;
    __weak IBOutlet UIView *topListView;
  
    __weak IBOutlet UIImageView *middleBlueImg;
    __weak IBOutlet UIImageView *bottomBlueImg;
   
    __weak IBOutlet UIScrollView *lzhyScrollView;
    UIImage *lzImg;
    
    
    
    UIButton  *btnMakeSure;
    UITextField  *textInput;
    int             m_iclickChangeBtn;  //2 middle 3 bottom
    NSMutableArray  *m_arrayTopData;
    NSMutableArray  *m_arrayBottomData;
    NSMutableArray  *m_arrayMiddleData;
    
}
@property(strong,nonatomic) UIButton  *preciousBtn;
@property(strong,nonatomic) UIImageView *preciousImgView;
@property(strong,nonatomic) UIImageView *preciousRefImgView;
@property(strong,nonatomic) UIImageView *preciousBlowImgView;

@end

@implementation LixilWoodenPhilosophyViewController

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
    [self addArrayData];
    bottomImage.alpha = 0;
    topListView.alpha = 0;
    refView.alpha = 0;
    
    _preciousBtn  = (UIButton*)[self.view viewWithTag:10];
    _preciousImgView = (UIImageView*)[self.view viewWithTag:3];
    _preciousBlowImgView = (UIImageView*)[self.view viewWithTag:5];
    _preciousRefImgView = (UIImageView*)[self.view viewWithTag:4];
    lzhyScrollView.contentSize = CGSizeMake(800, 274);
    
     lzImg = [UIImage imageNamed:@"wooden_ph_lzhyItem"];

    UIImageView *item = [[UIImageView alloc] initWithFrame:CGRectMake(24, 13, lzImg.size.width/2, lzImg.size.height/2)];
    item.image = lzImg;
    [lzhyScrollView addSubview:item];
    
    
    
    
    
    lzhyScrollView.hidden = YES;
    [self.view viewWithTag:99].hidden = YES;
    [self.view viewWithTag:95].hidden = YES;
    
}


#pragma mark   add actions

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
    
    fypoint = topListView.frame.origin.y;
    [bgView setFrame:CGRectMake(fXpoint, fypoint, fwidth, fheight)];
    bgView.hidden = bHide;
    
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
    NSArray *arrayHouse = @[@"兰州鸿运润园项目",@"荣域别墅区室内建材",@"星湖国际高级公寓室内建材",@"湖山新意高级公寓室内建材",@"中山湖滨一号高级公寓室内建材",@"世茂运河城高级公寓室内建材",@"东方花园高级公寓室内建材",@"金石别苏区T12玄关门",@"南山别墅区11A双休和C25子母玄关门",@"杭州灵隐九里松酒店",@"长沙远大T30酒店",@"长沙中通戴斯酒店",@"西安中兴和泰酒店",@"南昌宾馆"];
    
    NSArray *arrayPublic = @[@"WORLD CITY TOWER",@"PARK CITY TOYOSU",@"WONDER BAY CITY SAZAN",@"SHIBAURA ISLAND CAPE TOWER",@"BRILLLIA ARIAKE SKY TOWER",@"BRILLIA MARE ARIAKE",@"SHIBAURA ISLAND BROOM",@"CAPITAL MARK TOWER",@"SHIBAURA ISLAND GROVE TOWER",@"SHIBAYRA ISLAND AIR",@"MILLENARY TOWERS",@"CATELINA MITA TOWER",@"RELIZE GARDEN",@"GRAND HORAIZON TOKYO BAY"];
    
   // [m_arrayTopData addObjectsFromArray:arrayHotel];
   // [m_arrayMiddleData addObjectsFromArray:arrayHouse];
   // [m_arrayBottomData addObjectsFromArray:arrayPublic];
   NSArray *arrayData = [[NSUserDefaults standardUserDefaults] valueForKey:WOODLENDOMESTICARRAY];
    
    if (arrayData.count)
    {
        [m_arrayMiddleData addObjectsFromArray:arrayData];
    }else
    {
        [m_arrayMiddleData addObjectsFromArray:arrayHouse];
    }
    arrayData = [[NSUserDefaults standardUserDefaults] valueForKey:WOODLENOVERSEASARRAY];
    
    if (arrayData.count)
    {
        [m_arrayBottomData addObjectsFromArray:arrayData];
    }else
    {
        [m_arrayBottomData addObjectsFromArray:arrayPublic];
    }

    
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
            case 1:
                [m_arrayTopData addObject:textInput.text];
                [[NSUserDefaults standardUserDefaults] setObject:m_arrayTopData forKey:WOODLENOVERSEASARRAY];
                
                break;
            case 2:
                [m_arrayMiddleData addObject:textInput.text];
                [[NSUserDefaults standardUserDefaults] setObject:m_arrayMiddleData forKey:WOODLENDOMESTICARRAY];
                break;
            case 3:
                [m_arrayBottomData addObject:textInput.text];
                [[NSUserDefaults standardUserDefaults] setObject:m_arrayBottomData forKey:WOODLENOVERSEASARRAY];
                break;
                
            default:
                break;
        }
        
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [self reloadDataWithScrollerView:refView];
        
    }
    
    
}

#pragma mark - button method -

- (IBAction)middleBtnPressed:(UIButton *)sender {
    
    m_iclickChangeBtn = 2;
    if(_preciousBlowImgView != middleImage)
    {
        [self.view viewWithTag:99].hidden = NO;
        [self.view viewWithTag:95].hidden = YES;
        topListView.alpha = 1;

        refView.alpha = 1;
        
        lzhyScrollView.alpha = 0;

        _preciousImgView.alpha = 0;
        _preciousBtn.alpha= 1;
        _preciousRefImgView.alpha = 0;
        
       //        [UIView animateWithDuration:Animation_Duration_WoodenPhilosophy animations:^{
//            _preciousBlowImgView.alpha = 0;
//        }];
        
        
        
        _preciousRefImgView  = middleRefImage;
        
        sender.imageView.alpha = 1;
        _preciousBtn = sender;
        
        middleBlueImg.alpha = 1;
        _preciousImgView = middleBlueImg;
        [UIView animateWithDuration:Animation_Duration_WoodenPhilosophy animations:^{
            _preciousBlowImgView.alpha = 0;

           
            middleRefImage.alpha = 1;
         //   CGRect rect = CGRectMake(293, 311, 584, 275);
       //     refView.frame = rect;
         //   CGRect rect1 = CGRectMake(683, 267, 192, 45);
        //    topListView.frame = rect1;
            
        }];
         middleImage.alpha = 1;
        _preciousBlowImgView = middleImage;

        
    }
    
    [self reloadDataWithScrollerView:refView];
    
}
- (IBAction)bottomBtnPressed:(UIButton *)sender {
    
    m_iclickChangeBtn = 3;
    if(_preciousBlowImgView != bottomImage)
    {
        [self.view viewWithTag:99].hidden = YES;
       [self.view viewWithTag:95].hidden = YES;
        topListView.alpha = 1;

        refView.alpha = 1;

        lzhyScrollView.alpha = 0;

        _preciousImgView.alpha = 0;
        _preciousBtn.alpha= 1;
        _preciousRefImgView.alpha = 0;
//        [UIView animateWithDuration:Animation_Duration_WoodenPhilosophy animations:^{
//            _preciousBlowImgView.alpha = 0;
//        }];
        
        
        _preciousRefImgView  = bottomRefImage;
        
        sender.imageView.alpha = 1;
        _preciousBtn = sender;
        
        bottomBlueImg.alpha = 1;
        _preciousImgView = bottomBlueImg;
        [UIView animateWithDuration:Animation_Duration_WoodenPhilosophy animations:^{
            bottomImage.alpha = 1;
            bottomRefImage.alpha = 1;
            _preciousBlowImgView.alpha = 0;

         //   CGRect rect = CGRectMake(293, 311, 584, 275);
        //    refView.frame = rect;
         //   CGRect rect1 = CGRectMake(683, 267, 192, 45);
        //    topListView.frame = rect1;
            
        }];
        _preciousBlowImgView = bottomImage;

        
    }
    
    [self reloadDataWithScrollerView:refView];
    
}
- (IBAction)clearBtn:(UIButton *)sender {
    
    
    [self setNameLabelHidden:NO];
    if(middleImage.alpha ==1){
        [self.view viewWithTag:99].hidden = YES;
         [self.view viewWithTag:95].hidden = YES;
        _preciousBlowImgView = nil;
        refView.alpha = 0;
        topListView.alpha = 0;
        middleBlueImg.alpha = 0;
        
        lzhyScrollView.hidden = YES;
        
        
    }
    if(bottomImage.alpha ==1){
        _preciousBlowImgView = nil;
        refView.alpha = 0;
        topListView.alpha = 0;
        bottomBlueImg.alpha = 0;
        lzhyScrollView.hidden = YES;
        
    }
    
    
        }
- (IBAction)lzhyBtnPressed:(UIButton *)sender {
    if(middleImage.alpha ==1)
{
    
    [self setNameLabelHidden:YES];
    _preciousRefImgView.alpha = 0;
    lzhyScrollView.hidden = NO;
    lzhyScrollView.alpha = 1;
    [self.view viewWithTag:99].hidden = YES;
    [self.view viewWithTag:95].hidden = NO;
}
   //    for(int i = 0; i<3;i++)
//    {
//        UIImageView *item = [[UIImageView alloc] initWithFrame:CGRectMake(24*(i+1), 13, 225, 225)];
//        item.image = [UIImage imageNamed:[NSString stringWithFormat:@"wooden_ph_lzhy%d", i+1]];
//        [lzhyScrollView addSubview:item];
//    }
}
- (IBAction)bacToMain:(id)sender {
    
    
    
    [self setNameLabelHidden:NO];
    lzhyScrollView.hidden = YES;
    middleRefImage.alpha = 1;
    [self.view viewWithTag:95].hidden = YES;
    [self.view viewWithTag:99].hidden = NO;
}
- (IBAction)leftBtnPressed:(id)sender {
    
    if(lzhyScrollView.hidden == NO)
    {
    
    [lzhyScrollView setContentOffset:CGPointMake(190,0) animated:YES];
    }

}
- (IBAction)rightBtnPressed:(id)sender {
    if(lzhyScrollView.hidden == NO)
    {
       
        [lzhyScrollView setContentOffset:CGPointMake(-10, 0) animated:YES];
    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
