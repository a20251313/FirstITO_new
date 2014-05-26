//
//  LixiCustomDizhiView.m
//  ShowCasePro
//
//  Created by Ran Jingfu on 5/15/14.
//  Copyright (c) 2014 yczx. All rights reserved.
//

#import "LixiCustomDizhiView.h"


#define MoxuanViewTag   100
#define HeyeViewTag     200
#define HuanbaoViewTag  300
#define MengkuanViewTag 400
#define BashouViewTag   500
#define DingzhiViewTag  600


@implementation LixiCustomDizhiViewModel

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self)
    {
        self.chooseBashou = [aDecoder decodeBoolForKey:@"chooseBashou"];
        self.chooseDingzhi = [aDecoder decodeBoolForKey:@"chooseDingzhi"];
        self.chooseHeye = [aDecoder decodeBoolForKey:@"chooseHeye"];
        self.chooseHuanbao = [aDecoder decodeBoolForKey:@"chooseHuanbao"];
        self.chooseMengkuan = [aDecoder decodeBoolForKey:@"chooseMengkuan"];
        self.chooseMoxuan = [aDecoder decodeBoolForKey:@"chooseMoxuan"];
        self.storedate = [aDecoder decodeObjectForKey:@"storedate"];
        
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeBool:self.chooseMoxuan forKey:@"chooseMoxuan"];
    [aCoder encodeBool:self.chooseBashou forKey:@"chooseBashou"];
    [aCoder encodeBool:self.chooseHeye forKey:@"chooseHeye"];
    [aCoder encodeBool:self.chooseHuanbao forKey:@"chooseHuanbao"];
    [aCoder encodeBool:self.chooseMengkuan forKey:@"chooseMengkuan"];
    [aCoder encodeBool:self.chooseMoxuan forKey:@"chooseMoxuan"];
    [aCoder encodeObject:self.storedate forKey:@"storedate"];
    
    
}



@end



@interface LixiCustomDizhiView ()
{
    __weak  IBOutlet    UIView  *bgView;
    __weak  IBOutlet    UIScrollView  *m_scrollView;
    __weak IBOutlet UIImageView *coverImage;
    __weak IBOutlet UIView *coverView;
    BOOL ismoxuan;
    
}
@property(nonatomic,strong)LixiCustomDizhiViewModel *model;
@property(nonatomic,strong)UIButton *cusview;
@end
@implementation LixiCustomDizhiView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
- (void)viewDidLoad
{
    
    _cusview.alpha = 0;
  

}

-(NSString*)storeModelPath
{
    return [kDocuments stringByAppendingPathComponent:@"LixiCustomDizhiViewModel"];
}

-(void)storeModel:(LixiCustomDizhiViewModel*)model
{
    BOOL suc = [NSKeyedArchiver archiveRootObject:model toFile:[self storeModelPath]];
    if (!suc)
    {
        debugLog(@"storeModel fail:%@",[self storeModelPath]);
    }
}


-(void)awakeFromNib
{
    
    [m_scrollView setContentSize:CGSizeMake(m_scrollView.frame.size.width, m_scrollView.frame.size.height)];
    
  //for (int i = 0; i < 2; i++)
  //  {
     //   UIImageView *imagetemp = [[UIImageView alloc] initWithFrame:CGRectMake((1)*m_scrollView.frame.size.width, 0, m_scrollView.frame.size.width, m_scrollView.frame.size.height)];
      //  imagetemp.image = [UIImage imageNamed:[NSString stringWithFormat:@"pruduct_dizhi_scroll%d.png",i+1]];
     //   imagetemp.userInteractionEnabled = YES;
     //   [m_scrollView addSubview:imagetemp];
        m_scrollView.pagingEnabled = YES;
  //  }
}
-(IBAction)closeAction:(UIButton*)sender
{
    UIView  *hiddView = [bgView viewWithTag:sender.tag-1];
    hiddView.hidden = YES;
    ismoxuan = NO;
    
}
-(IBAction)showBashouAction:(UIButton*)sender
{
    UIView  *view = [bgView viewWithTag:BashouViewTag];
    view.hidden = NO;
    
}
-(IBAction)showHeyeAction:(UIButton*)sender
{
    UIView  *view = [bgView viewWithTag:HeyeViewTag];
    view.hidden = NO;
    
}
-(IBAction)showMoxuanAction:(UIButton*)sender
{
    UIView  *view = [bgView viewWithTag:MoxuanViewTag];
    view.hidden = NO;
    ismoxuan = YES;
}
-(IBAction)showMengkuanAction:(UIButton*)sender
{
    UIView  *view = [bgView viewWithTag:MengkuanViewTag];
    view.hidden = NO;
    
}
-(IBAction)showDingzhiAction:(UIButton*)sender
{
    UIView  *view = [bgView viewWithTag:DingzhiViewTag];
    view.hidden = NO;
    
}
-(IBAction)ShowHuanbaoAction:(UIButton*)sender
{
    UIView  *view = [bgView viewWithTag:HuanbaoViewTag];
    view.hidden = NO;
}
- (IBAction)xiangxi1Btn:(id)sender {
  if(ismoxuan == YES)
  {
    _cusview = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 751, 629)];
    
    [_cusview addTarget:self action:@selector(tapImageView) forControlEvents:UIControlEventTouchUpInside];
    [m_scrollView addSubview:_cusview];
   
    [_cusview setBackgroundImage:[UIImage imageNamed:@"pruduct_dizhi_scroll2.png"] forState:UIControlStateNormal];
    _cusview.alpha = 1;
  }
}

- (IBAction)xiangxi2Btn:(id)sender {
    if(ismoxuan == YES)
    {
    _cusview = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 751, 629)];
    
    [_cusview addTarget:self action:@selector(tapImageView) forControlEvents:UIControlEventTouchUpInside];
    [m_scrollView addSubview:_cusview];
    
    [_cusview setBackgroundImage:[UIImage imageNamed:@"pruduct_dizhi_scroll1.png"] forState:UIControlStateNormal];
    _cusview.alpha = 1;
    }
}

- (IBAction)xiangxi3Btn:(id)sender {
    if(ismoxuan == YES)
    {
    _cusview = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 751, 629)];
    
    [_cusview addTarget:self action:@selector(tapImageView) forControlEvents:UIControlEventTouchUpInside];
    [m_scrollView addSubview:_cusview];
    
    [_cusview setBackgroundImage:[UIImage imageNamed:@"pruduct_dizhi_scroll1.png"] forState:UIControlStateNormal];
    _cusview.alpha = 1;
    }
}

-(void)tapImageView
{
    _cusview.alpha = 0;
    NSLog(@"ddddd");
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
