//
//  WoodenLeadingTechZhiNengMenViewController.m
//  ShowCasePro
//
//  Created by CY-003 on 14-4-25.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "WoodenLeadingTechZhiNengMenViewController.h"
#import "UserGuideTips.h"
@interface WoodenLeadingTechZhiNengMenViewController ()
{
    BOOL isDetailView;
    UIImageView *pageImageView ;
}
@property(strong,nonatomic)NSMutableArray *fangdaoArray;
@property(strong,nonatomic)NSMutableArray *meiguangArray;
@property(strong,nonatomic)NSMutableArray *shushiArray;
@property(strong,nonatomic)UIScrollView *fangdaoScroll;
@property(strong,nonatomic)UIScrollView *meiguangScroll;
@property(strong,nonatomic)UIScrollView *shushiScroll;
@end

@implementation WoodenLeadingTechZhiNengMenViewController

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
     _fangdaoArray =[self addImgTothisMutableArrayWithCount:5 andImgString:@"wooden_lt_zhineng_main_fangdao"];
    
   _meiguangArray =[self addImgTothisMutableArrayWithCount:1 andImgString:@"wooden_lt_zhineng_main_meiguan"];
    _shushiArray  =[self addImgTothisMutableArrayWithCount:7 andImgString:@"wooden_lt_zhineng_main_shushi"];
    
    UserGuideTips *guideTips = [UserGuideTips shareInstance];
    [guideTips showUserGuideView:self.view tipKey:@"WoodenLeadingTechZhiNengMenViewController"  imageNamePre:@"wooden_lt_zhineng_guide"];

}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
       if(pageImageView!=nil)
    {
        if(_fangdaoScroll!=nil){
            
        CGPoint offset =  _fangdaoScroll.contentOffset;
        pageImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"wooden_lt_zhineng_main_fangdao_page%d", (int)offset.y/683+1]];
        }
        
        
        if(_meiguangScroll!=nil){
            
            CGPoint offset =  _meiguangScroll.contentOffset;
            pageImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"wooden_lt_zhineng_main_meiguan_page%d", (int)offset.y/683+1]];
        }
        if(_shushiScroll!=nil){
            
            CGPoint offset =  _shushiScroll.contentOffset;
            pageImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"wooden_lt_zhineng_main_shushi_page%d", (int)offset.y/683+1]];
        }

        
    }
    
    
    
}


-(NSMutableArray*)addImgTothisMutableArrayWithCount:(int)count andImgString:(NSString *)subString;
{
    
    NSMutableArray *arrayImg = [NSMutableArray arrayWithCapacity:count];
    for (int i =0; i< count; i++) {
        
        NSString *imgString= [NSString stringWithFormat:[subString stringByAppendingString:@"%d"],i+1];
        UIImage *img = [UIImage imageNamed:imgString];
        [arrayImg addObject:img];
        
    }

    return arrayImg;
}




- (UIScrollView*) creatScrollView:(CGRect)frame imageArray:(NSMutableArray*)imgArray
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:frame];
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
   
    scrollView.bounces = NO;
    [scrollView setShowsHorizontalScrollIndicator:NO];
    [scrollView setShowsVerticalScrollIndicator:NO];
    
    int count = [imgArray count];
    
    [scrollView setContentSize:CGSizeMake(1024, 683.0*count)];
    
    scrollView.backgroundColor = [UIColor clearColor];
    
    for (int i = 0; i<count; i++) {
        
        UIImage *img =  [imgArray objectAtIndex:i];
        UIImageView   *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, i*683.0, 1024, 683)];
        imgView.image = img;
        
        [scrollView addSubview:imgView];
    
    }
    
      return scrollView;
}



#pragma mark - button event
- (IBAction)toScrollBtnPressed:(id)sender {
    
    UIButton *button = (UIButton*)sender;
    
    if(button.tag == 1)
    {
        isDetailView = YES;
      _fangdaoScroll = [self creatScrollView:CGRectMake(0, 85, 1024, 683) imageArray:_fangdaoArray];
        
      [self.view addSubview:_fangdaoScroll];
      pageImageView = [[UIImageView alloc] initWithFrame:CGRectMake(892, 612, 72/2, 191/2)];
       NSString *pageImage = [NSString stringWithFormat:@"wooden_lt_zhineng_main_fangdao_page%d.png", 1];
      pageImageView.image =  [UIImage imageNamed:pageImage];
      [self.view addSubview:pageImageView];
    }
    if(button.tag == 2)
    {
        isDetailView = YES;
         _meiguangScroll= [self creatScrollView:CGRectMake(0, 85, 1024, 683) imageArray:_meiguangArray];
        
        [self.view addSubview: _meiguangScroll];
        pageImageView = [[UIImageView alloc] initWithFrame:CGRectMake(892, 612, 72/2, 191/2)];
        NSString *pageImage = [NSString stringWithFormat:@"wooden_lt_zhineng_main_meiguan_page%d.png", 1];
        pageImageView.image =  [UIImage imageNamed:pageImage];
        [self.view addSubview:pageImageView];
        
        
    }

    if(button.tag == 3)
    {
        isDetailView = YES;
        _shushiScroll = [self creatScrollView:CGRectMake(0, 85, 1024, 683) imageArray:_shushiArray];
        
        [self.view addSubview:_shushiScroll];
        pageImageView = [[UIImageView alloc] initWithFrame:CGRectMake(892, 612, 72/2, 191/2)];
        NSString *pageImage = [NSString stringWithFormat:@"wooden_lt_zhineng_main_shushi_page%d.png", 1];
        pageImageView.image =  [UIImage imageNamed:pageImage];
        [self.view addSubview:pageImageView];
    }
    
    
}

- (void) backButtonEvent
{
    
        if (isDetailView)
    {
        if(_fangdaoScroll!=nil)
        {
          [_fangdaoScroll removeFromSuperview];
          _fangdaoScroll = nil;
        }
        
        if(_shushiScroll!= nil)
        {
            [_shushiScroll removeFromSuperview];
            _shushiScroll = nil;
        }
        if(_meiguangScroll!= nil)
        {
            [_meiguangScroll removeFromSuperview];
            _meiguangScroll = nil;
        }
        isDetailView = NO;
        [pageImageView removeFromSuperview];
        pageImageView = nil;

    }
    else
    {
        [self.navigationController popViewControllerAnimated:NO];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
