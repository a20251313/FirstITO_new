//
//  InaxSuccessfulProjectsViewController.m
//  ShowCasePro
//
//  Created by Mac on 14-3-18.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "InaxSuccessfulProjectsViewController.h"
#define Animation_Duration_InaxSuccessfulProject 0.7
@interface InaxSuccessfulProjectsViewController ()
{
    __weak IBOutlet UIImageView *topimage;
    
    __weak IBOutlet UIImageView *middleImage;
    
    __weak IBOutlet UIImageView *bottomImage;
    
    __weak IBOutlet UIImageView *topRefImage;
    
    __weak IBOutlet UIImageView *middleRefImage;
    
    __weak IBOutlet UIImageView *bottomRefImage;
   
    __weak IBOutlet UIView *topListView;
    
    __weak IBOutlet UIScrollView *refView;
    
    __weak IBOutlet UIImageView *topBlueImg;
    
    __weak IBOutlet UIImageView *middleBlueImg;
   
    __weak IBOutlet UIImageView *bottomBlueImg;
    UIScrollView *changbaishanScrollView;
    
    UIScrollView *shanghaishiboScrollView;
    
    
  
    UIButton  *btnMakeSure;
    UITextField  *textInput;
    int             m_iclickChangeBtn;  //1 top 2 middle 3 bottom
    NSMutableArray  *m_arrayTopData;
    NSMutableArray  *m_arrayBottomData;
    NSMutableArray  *m_arrayMiddleData;
    
}

@property(strong,nonatomic) UIButton  *preciousBtn;
@property(strong,nonatomic) UIImageView *preciousImgView;
@property(strong,nonatomic) UIImageView *preciousRefImgView;
@property(strong,nonatomic) UIImageView *preciousBlowImgView;
@property(nonatomic,strong)NSMutableArray *changbaishanArrayImage;
@property(nonatomic,strong)NSMutableArray *shanghaishiboArrayImage;
@end




#define INAXHOTELARRAY      @"INAXHOTELARRAY"
#define INAXHOUSEARRAY      @"INAXHOUSEARRAY"
#define INAXPUBLICARRAY     @"INAXPUBLICARRAY"
@implementation InaxSuccessfulProjectsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)setInputViewHidden:(BOOL)bHide
{
    
    
    CGFloat fXpoint = 293;
    CGFloat fwidth = 683+48-fXpoint;
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
        [bgView setBackgroundColor:[UIColor colorWithRed:36.0/255.0 green:139.0/255.0 blue:218.0/255.0 alpha:1]];
        
        
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
    
    
    if (!m_arrayTopData)
    {
        m_arrayTopData = [[NSMutableArray alloc] init];
    }
    if (!m_arrayMiddleData)
    {
        m_arrayMiddleData = [[NSMutableArray alloc] init];
    }
    if (!m_arrayBottomData)
    {
        m_arrayBottomData = [[NSMutableArray alloc] init];
    }
    NSArray *arrayHotel = @[@"无锡希尔顿酒店",@"苏州香格里拉酒店",@"苏州新城花园二期",@"靖江滨江花园酒店",@"济南东海顺丰大酒店",@"济南枣庄清御园大酒店",@"山东广饶东营国际大酒店",@"上海衡山至尊酒店",@"南京双门楼酒店",@"杭州灵隐九里松酒店",@"长沙远大T30酒店",@"长沙中通戴斯酒店",@"西安中兴和泰酒店",@"南昌宾馆",@"北京长白山国际酒店"];
    NSArray *arrayHouse = @[@"杭州绿城花园",@"海南华润石梅湾公寓",@"哈尔滨盛合天下",@"长沙达美精装公寓",@"大连绿城深蓝中心",@"大连柏丽柏悦国际公寓",@"上海金桥碧云公寓",@"宁波恒元悦府",@"杭州绿城花园",@"沈阳华润万象城"];
    
    NSArray *arrayPublic = @[@"上海世博会",@"上海仲盛商业广场",@"长沙珠江花城",@"哈尔滨盛合天下",@"长沙达美精装公寓",@"大连柏丽柏悦国际公寓",@"上海金桥碧云公寓",@"宁波恒元悦府",@"杭州绿城花园",@"沈阳华润万象城",@"长沙中通戴斯酒店",@"西安中兴和泰酒店",@"南昌宾馆"];
    
   // [m_arrayTopData addObjectsFromArray:arrayHotel];
  //  [m_arrayMiddleData addObjectsFromArray:arrayHouse];
  //  [m_arrayBottomData addObjectsFromArray:arrayPublic];
    NSArray *arrayData = [[NSUserDefaults standardUserDefaults] valueForKey:INAXHOTELARRAY];
    
    if (arrayData.count)
    {
        [m_arrayTopData addObjectsFromArray:arrayData];
    }else
    {
        [m_arrayTopData addObjectsFromArray:arrayHotel];
        
    }
    arrayData = [[NSUserDefaults standardUserDefaults] valueForKey:INAXHOUSEARRAY];
    
    if (arrayData.count)
    {
        [m_arrayMiddleData addObjectsFromArray:arrayData];
    }else
    {
        [m_arrayMiddleData addObjectsFromArray:arrayHouse];
    }
   arrayData = [[NSUserDefaults standardUserDefaults] valueForKey:INAXPUBLICARRAY];
    
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
        [refView addSubview:labelText];
        [labelText setText:arrayData[i]];
        
    }
    
    
    [refView setContentSize:CGSizeMake(refView.frame.size.width, fypoint+fheight)];
    [refView setBackgroundColor:[UIColor colorWithRed:232.0/255.0 green:250.0/255.0 blue:254.0/255.0 alpha:1]];
    refView.clipsToBounds = YES;
    refView.showsHorizontalScrollIndicator = NO;
    refView.showsVerticalScrollIndicator = NO;
    
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
    
    [refView setBackgroundColor:[UIColor colorWithRed:232.0/255.0 green:250.0/255.0 blue:254.0/255.0 alpha:1]];
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
                [[NSUserDefaults standardUserDefaults] setObject:m_arrayTopData forKey:INAXHOTELARRAY];
                
                break;
            case 2:
                [m_arrayMiddleData addObject:textInput.text];
                 [[NSUserDefaults standardUserDefaults] setObject:m_arrayMiddleData forKey:INAXHOUSEARRAY];
                break;
            case 3:
                [m_arrayBottomData addObject:textInput.text];
                 [[NSUserDefaults standardUserDefaults] setObject:m_arrayBottomData forKey:INAXPUBLICARRAY];
                break;
                
            default:
                break;
        }
        
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [self reloadDataWithScrollerView:refView];
        
    }
  
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addArrayData];
    // Do any additional setup after loading the view from its nib.
    
    middleImage.alpha = 0;
    bottomImage.alpha = 0;
   
    _preciousBtn  = (UIButton*)[self.view viewWithTag:10];
    _preciousImgView = (UIImageView*)[self.view viewWithTag:3];
   // _preciousBlowImgView = (UIImageView*)[self.view viewWithTag:5];
    
    _preciousBlowImgView = nil;
    _preciousRefImgView = (UIImageView*)[self.view viewWithTag:4];
    
    
    _changbaishanArrayImage = [NSMutableArray arrayWithCapacity:1];
    for(int i = 1;i <2 ;i++){
        NSString *imgName = @"inax_sp_changbaishan.png";
        UIImage *img = [UIImage imageNamed:imgName];
        [_changbaishanArrayImage addObject:img];
    }
    _shanghaishiboArrayImage = [NSMutableArray arrayWithCapacity:1];
    
    UIImage *imgShang = [UIImage imageNamed:@"inax_sp_shanghaishibo"];
    [_shanghaishiboArrayImage addObject:imgShang];
    
    [self.view viewWithTag:90].hidden = YES;
    [self.view viewWithTag:99].hidden = YES;
    [self.view viewWithTag:91].hidden = YES;

}
#pragma mark - button method -

- (IBAction)topBtnPressed:(UIButton *)sender {
    m_iclickChangeBtn = 1;
    if(_preciousBlowImgView != topimage)
    {
        [self.view viewWithTag:99].hidden = YES;
       shanghaishiboScrollView.hidden = YES;
        [self.view viewWithTag:91].hidden = YES;
         changbaishanScrollView.hidden = YES;
               refView.alpha = 1;
        topListView.alpha = 1;
        _preciousImgView.alpha = 0;
        _preciousBtn.alpha= 1;
        _preciousRefImgView.alpha = 0;
        [UIView animateWithDuration:Animation_Duration_InaxSuccessfulProject animations:^{
            _preciousBlowImgView.alpha = 0;
        }];
        
        _preciousBlowImgView = topimage;
        
        
        _preciousRefImgView  = topRefImage;
        
        sender.imageView.alpha = 1;
        _preciousBtn = sender;
        
        topBlueImg.alpha = 1;
        _preciousImgView = topBlueImg;
        [UIView animateWithDuration:Animation_Duration_InaxSuccessfulProject animations:^{
            topimage.alpha = 1;
            topRefImage.alpha = 1;
            CGRect rect = CGRectMake(293, 175, 582, 275);
            refView.frame = rect;
            CGRect rect1 = CGRectMake(683, 129, 192, 45);
            topListView.frame = rect1;
            [self.view viewWithTag:90].hidden = NO;

            
        }];
        
        
    }
    
    [self reloadDataWithScrollerView:refView];

    
}
- (IBAction)middleBtnPressed:(UIButton *)sender {
   
      m_iclickChangeBtn = 2;
    if(_preciousBlowImgView != middleImage)
    {
        changbaishanScrollView.hidden = YES;
        shanghaishiboScrollView.hidden = YES;
        [self.view viewWithTag:99].hidden = YES;
       [self.view viewWithTag:91].hidden = YES;
        [self.view viewWithTag:90].hidden = YES;
        refView.alpha = 1;
        topListView.alpha = 1;
        _preciousImgView.alpha = 0;
        _preciousBtn.alpha= 1;
        _preciousRefImgView.alpha = 0;
        [UIView animateWithDuration:Animation_Duration_InaxSuccessfulProject animations:^{
            _preciousBlowImgView.alpha = 0;
                   }];
       
        _preciousBlowImgView = middleImage;
        
       
        _preciousRefImgView  = middleRefImage;
        
        sender.imageView.alpha = 1;
        _preciousBtn = sender;
        
        middleBlueImg.alpha = 1;
        _preciousImgView = middleBlueImg;
        [UIView animateWithDuration:Animation_Duration_InaxSuccessfulProject animations:^{
             middleImage.alpha = 1;
             middleRefImage.alpha = 1;
            CGRect rect = CGRectMake(293, 311, 584, 275);
            refView.frame = rect;
            CGRect rect1 = CGRectMake(683, 267, 192, 45);
            topListView.frame = rect1;
            
        }];

        
    }
  
      [self reloadDataWithScrollerView:refView];
}
- (IBAction)bottomBtnPressed:(UIButton *)sender {
    
      m_iclickChangeBtn = 3;
    if(_preciousBlowImgView != bottomImage)
    {
         shanghaishiboScrollView.hidden = YES;
        changbaishanScrollView.hidden = YES;
        [self.view viewWithTag:99].hidden = YES;
     
        [self.view viewWithTag:90].hidden = YES;
        refView.alpha = 1;
        topListView.alpha = 1;
        _preciousImgView.alpha = 0;
        _preciousBtn.alpha= 1;
        _preciousRefImgView.alpha = 0;
        [UIView animateWithDuration:Animation_Duration_InaxSuccessfulProject animations:^{
            _preciousBlowImgView.alpha = 0;
        }];
        
        _preciousBlowImgView = bottomImage;
        
        
        _preciousRefImgView  = bottomRefImage;
        
        sender.imageView.alpha = 1;
        _preciousBtn = sender;
        
        bottomBlueImg.alpha = 1;
        _preciousImgView = bottomBlueImg;
        [UIView animateWithDuration:Animation_Duration_InaxSuccessfulProject animations:^{
            bottomImage.alpha = 1;
            bottomRefImage.alpha = 1;
            CGRect rect = CGRectMake(293, 311, 584, 275);
            refView.frame = rect;
            CGRect rect1 = CGRectMake(683, 267, 192, 45);
            topListView.frame = rect1;
            [self.view viewWithTag:91].hidden = NO;
            
        }];
        
        
    }
    
      [self reloadDataWithScrollerView:refView];

}
- (IBAction)clearBtn:(UIButton *)sender {
    topBlueImg.alpha = 0;
    bottomBlueImg.alpha = 0;
    middleBlueImg.alpha =0;
    topListView.alpha = 0;
    refView.alpha = 0;
    _preciousBlowImgView = nil;
    [self.view viewWithTag:90].hidden = YES;
    [self.view viewWithTag:99].hidden = YES;
    [self.view viewWithTag:91].hidden = YES;
    
 }
- (IBAction)moveToLeftBtnPressed:(UIButton *)sender {
    if(changbaishanScrollView.hidden==NO)
    {
        
        [changbaishanScrollView setContentOffset:CGPointMake(190,0) animated:YES];
        
    }

}
- (IBAction)moveToRightBtnPressed:(UIButton *)sender {
    if(changbaishanScrollView.hidden==NO)
    {
        
        [changbaishanScrollView setContentOffset:CGPointMake(-10,0) animated:YES];
        
    }

}
- (IBAction)topCloseBtn:(id)sender {
    
    [self setNameLabelHidden:NO];
   if(topimage.alpha == 1){
    if(changbaishanScrollView !=nil){
    changbaishanScrollView.hidden = YES;
    [self.view viewWithTag:99].hidden = YES;
    if(topimage.alpha ==1)
    topRefImage.alpha = 1;
    [self.view viewWithTag:90].hidden = NO;
    }
   }
   if(bottomImage.alpha == 1){
     if(shanghaishiboScrollView != nil)
    shanghaishiboScrollView.hidden = YES;
    [self.view viewWithTag:99].hidden = YES;
    [self.view viewWithTag:91].hidden = NO;
    if(bottomImage.alpha == 1)
        bottomRefImage.alpha =1;
    }
}

- (IBAction)changbaishangAddBtn:(id)sender {
    
     [self setNameLabelHidden:YES];
    if(shanghaishiboScrollView != nil){
    [shanghaishiboScrollView removeFromSuperview];
    shanghaishiboScrollView = nil;
    }
    
    changbaishanScrollView.hidden = NO;
    topRefImage.alpha = 0;
    refView.backgroundColor = [UIColor whiteColor];
    if(changbaishanScrollView ==nil){
    changbaishanScrollView = [self createScrollView:_changbaishanArrayImage frame:CGRectMake(0, 20, 581.5, 274)];
    [refView addSubview:  changbaishanScrollView];
    [refView bringSubviewToFront:changbaishanScrollView];
    }
    [self.view viewWithTag:99].hidden = NO;
    refView.alpha = 1;
    [self.view viewWithTag:90].hidden = YES;
}
- (IBAction)shanghaishiboAddBtn:(id)sender {
    
     [self setNameLabelHidden:YES];
     if(changbaishanScrollView !=nil){
    [changbaishanScrollView removeFromSuperview];
    changbaishanScrollView =nil;
     }
    bottomRefImage.alpha = 0;
    [self.view viewWithTag:91].hidden = YES;
    
    refView.backgroundColor = [UIColor whiteColor];
    if(shanghaishiboScrollView == nil){
    shanghaishiboScrollView = [self createScrollView:_shanghaishiboArrayImage frame:CGRectMake(0, 20, 581.5, 274)];
    [refView addSubview:  shanghaishiboScrollView];
    [refView bringSubviewToFront:shanghaishiboScrollView];
    }
    [self.view viewWithTag:99].hidden = NO;
    refView.alpha = 1;
    shanghaishiboScrollView.hidden = NO;
    
}



-(UIScrollView*)createScrollView:(NSMutableArray *)imgArray  frame: (CGRect)frame
{
    //[refScrollView]
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:frame];
    
    scrollView.pagingEnabled = NO;
    scrollView.delegate = self;
    
    scrollView.bounces = YES;
    [scrollView setShowsHorizontalScrollIndicator:NO];
    [scrollView setShowsVerticalScrollIndicator:NO];
    NSInteger count = [imgArray count];
    UIImage *img =  [UIImage imageNamed:@"ecocarat_ph_do_changbaishang1"];
    [scrollView setContentSize:CGSizeMake(img.size.width/2*count+100, 274)];
    
    
    // scrollView.backgroundColor = [UIColor blueColor];
    for(NSInteger i = 1;i< count+1;i++)
    {
        UIImage *img= [imgArray objectAtIndex:(i-1)];
        UIImageView *imgView =[[UIImageView alloc] initWithFrame:CGRectMake((i-1)*img.size.width/2+i*23, 10, img.size.width/2, img.size.height/2)];
        
        imgView.image = img;
        
        [scrollView addSubview:imgView];
        
    }
    
    //[scrollView setBackgroundColor:[UIColor colorWithRed:232.0/255.0 green:250.0/255.0 blue:254.0/255.0 alpha:1]];
    
    return scrollView;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
