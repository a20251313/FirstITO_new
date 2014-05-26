
//
//  InaxLeadingTechViewController.m
//  ShowCasePro
//
//  Created by Mac on 14-3-18.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "InaxLeadingTechViewController.h"
#import "InaxLeadingTechCell.h"
NSString *kCellID = @"cellID";
#define Animation_Duration_Scroll   0.1
#define Section_Scroll_Set         15
@interface InaxLeadingTechViewController ()
{
    
    __weak IBOutlet UICollectionView *scrollViews;
    
    int currentPage;
  
    BOOL stripDownOnce;
    
    UIView *detailView;
    
    UIScrollView *scollViewContent;
    BOOL isDetailView;
    
    
    UIImageView *pageCountImageView;
     UIImageView *pageImageView;
   
}
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) InaxLeadingTechCell *previousCell;
@property (nonatomic , strong) NSTimer *scrollTimer;
@property (nonatomic, strong) NSMutableArray *imgArray;
@property (nonatomic, strong) NSMutableArray *desImgArray;
@property (nonatomic, strong)UIScrollView *scrollContent;
@property (nonatomic, strong)NSMutableArray *scrollContentArray;
@property (nonatomic, strong)NSMutableArray *ContentArray;

@end


@implementation InaxLeadingTechViewController

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if(detailView.alpha ==1 )
    {
        CGPoint offset = scrollView.contentOffset;
       pageCountImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"inax_lt_page%d", (int)offset.y/683+1]];
    }
    if(_ContentArray!=nil)
    {
        NSString *pageString = [_ContentArray objectAtIndex:0];
       
        if([pageString equals:@"inax_lt_lejing"]||[pageString equals:@"inax_lt_yiban"])
        {
            CGPoint offset = _scrollContent.contentOffset;
           pageImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"inax_lt_page6%d", (int)offset.y/683+1]];
          
        }
        if([pageString equals:@"inax_lt_regio"]||[pageString equals:@"inax_lt_suolaisi"]||[pageString equals:@"inax_lt_naiyi"])
        {
            CGPoint offset = _scrollContent.contentOffset;
            pageImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"wooden_lt_zhineng_main_fangdao_page%d", (int)offset.y/683+1]];
            
        }
        if([pageString equals:@"inax_lt_harmo"]||[pageString equals:@"inax_lt_asteo"]||[pageString equals:@"inax_lt_yixiangjing"]||[pageString equals:@"inax_lt_eco_tech"]||[pageString equals:@"inax_lt_qingpen"]||[pageString equals:@"inax_lt_xiaobianqi"])
        {
            CGPoint offset = _scrollContent.contentOffset;
           pageImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"inax_lt_page4%d", (int)offset.y/683+1]];
            
        }
        if([pageString equals:@"inax_lt_ailaige"]||[pageString equals:@"inax_lt_jieshui"]||[pageString equals:@"inax_lt_cp"]||[pageString equals:@"inax_lt_sma"]||[pageString equals:@"inax_lt_zunyu"]||[pageString equals:@"inax_lt_hw"])
        {
            CGPoint offset = _scrollContent.contentOffset;
            pageImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"inax_lt_page2%d", (int)offset.y/683+1]];
            
        }
       
        if([pageString equals:@"inax_lt_oufute"]||[pageString equals:@"inax_lt_zidonglongtou"]||[pageString equals:@"inax_lt_shumo"]||[pageString equals:@"inax_lt_yingyashi"]||[pageString equals:@"inax_lt_anmoyugang"])
        {
            CGPoint offset = _scrollContent.contentOffset;
            pageImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"wooden_lt_page%d", (int)offset.y/683+1]];
        }
       
    }

}

- (void) scrollMethod
{
    if(!isDetailView)
  {
    CGPoint section0_contentOffSet = scrollViews.contentOffset;
    
    section0_contentOffSet.x += Section_Scroll_Set;
    
    
    [scrollViews setContentOffset:section0_contentOffSet animated:YES];

    if(section0_contentOffSet.x >= 1024/6 * 23 * 35)
    {
        section0_contentOffSet.x = 0;
        [scrollViews setContentOffset:section0_contentOffSet animated:NO];
    }
  }
}
-(void)delayScrollMethod
{
    self.scrollTimer = [NSTimer scheduledTimerWithTimeInterval:Animation_Duration_Scroll
                                                        target:self
                                                      selector:@selector(scrollMethod)
                                                      userInfo:nil
                                                       repeats:YES];
    [self.scrollTimer fire];

}
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
    
    [scrollViews registerClass:[InaxLeadingTechCell class] forCellWithReuseIdentifier:kCellID];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(1024/6.0,703)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    [flowLayout setHeaderReferenceSize:CGSizeMake(0,0)];
    [flowLayout setFooterReferenceSize:CGSizeMake(0, 0)];
    [scrollViews setCollectionViewLayout:flowLayout];
    scrollViews.bounces = NO;
  
    stripDownOnce = NO;
    [self performSelector:@selector(delayScrollMethod) withObject:nil afterDelay:1];
    _imgArray = [NSMutableArray arrayWithCapacity:23];
    _desImgArray = [NSMutableArray arrayWithCapacity:23];
    for(int i= 1;i<24;i++)
    {
        NSString *imageToLoad = [NSString stringWithFormat:@"inax_leading_strip%d.png", i];
        UIImage *img =  [UIImage imageNamed:imageToLoad];
        [_imgArray addObject:img];
        NSString *desImageToLoad = [NSString stringWithFormat:@"inax_leading_Item%d.png", i];
        UIImage *desImage =  [UIImage imageNamed:desImageToLoad];
        [_desImgArray addObject:desImage];
    }
   
   detailView = [[UIView alloc] initWithFrame:CGRectMake(0, 85, 1024, 683)];
    detailView.backgroundColor = [UIColor blueColor];
    detailView.alpha = 0;
    [self.view addSubview:detailView];
    pageImageView = [[UIImageView alloc] initWithFrame:CGRectMake(892, 640, 69/2, 185/2)];
   
    [self.view addSubview:pageImageView];
   

    
}
- (UIScrollView*) creatScrollView:(CGRect)frame imageName:(NSString*)imgName
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:frame];
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    UIImage *img =  [UIImage imageNamed:imgName];
    scrollView.bounces = NO;
    [scrollView setShowsHorizontalScrollIndicator:NO];
    [scrollView setShowsVerticalScrollIndicator:NO];
    
    [scrollView setContentSize:CGSizeMake(img.size.width/2, img.size.height/2)];
   
    scrollView.backgroundColor = [UIColor clearColor];
   
    UIImageView   *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, img.size.width/2, img.size.height/2)];
    imgView.image = img;
    scollViewContent = scrollView;
    [scollViewContent addSubview:imgView];
   
    return scrollView;
}

-(NSMutableArray*)addImgTothisMutableArrayWithCount:(int)count andImgString:(NSString *)subString;
{
    
    NSMutableArray *arrayImg = [NSMutableArray arrayWithCapacity:count];
    for (int i =0; i< count; i++) {
        
        NSString *imgString= [NSString stringWithFormat:[subString stringByAppendingString:@"%d.jpg"],i+1];
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


- (UICollectionViewCell*)cellForIndexRow:(int)row
{
    NSIndexPath *indexpath = [NSIndexPath indexPathForRow:row inSection:0];
    UICollectionViewCell  *cell = [scrollViews cellForItemAtIndexPath:indexpath];
    return cell;
}




- (InaxLeadingTechCell  *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
      InaxLeadingTechCell  *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellID forIndexPath:indexPath];
   
    float delaytime = 0;
  
    UIImageView *img = cell.imageView;
    UIImageView *blueImg = cell.blueImageView;
  
    UIImageView *desImg = cell.desImageView;
    if(stripDownOnce == NO)
    {
    cell.desImageView.alpha = 0;
    }
    else{
    cell.desImageView.alpha = 1;

    }
    blueImg.image = [UIImage imageNamed:@"inax_leading_bluebottom"];
    UIImage  *imgTemp  = (UIImage*)[_imgArray objectAtIndex:indexPath.row%23];
    img.image = imgTemp;
   // img.bounds = CGRectMake(0, 0, imgTemp.size.width/2, imgTemp.size.height/2);
    UIImage  *desTemp  =  (UIImage*)[_desImgArray objectAtIndex:indexPath.row%23];
    desImg.image = desTemp;
    cell.desImageView.frame = CGRectMake(cell.desImageView.frame.origin.x, 50, desTemp.size.width/2, desTemp.size.height/2);
    cell.desImageView.center = CGPointMake(cell.frame.size.width/2, 50+desTemp.size.height/4);
 
   if(stripDownOnce == NO)
   {
    CGRect frame = img.frame;
    frame.origin.y = -2500;
    img.frame = frame;
    delaytime = 0.2;
       
   if(indexPath.row == 5)
   {
        stripDownOnce = YES;
   }
 
    [UIView animateWithDuration:indexPath.row * delaytime animations:^{
        
        CGRect frame = img.frame;
        frame.origin.y = 0;
        img.frame = frame;
        
    } completion:^(BOOL finished) {
         desImg.alpha = 1;
    }];
      
   }

    
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row % 23 == 2)
    {
        
        isDetailView = YES;
        [self performSelector:@selector(toDetailInterface:) withObject:@"inax_leading_tech_detail1" afterDelay:0.3];
       
    }
    
    if(indexPath.row % 23 == 0)
    {
        
      [self sendDataToNextSceneWithPicSubString:@"inax_lt_lejing" andPicMount:6 withPageString:@"inax_lt_page6"];
    }
    
    if(indexPath.row % 23 == 1)
    {
      [self sendDataToNextSceneWithPicSubString:@"inax_lt_regio" andPicMount:5 withPageString:@"wooden_lt_zhineng_main_fangdao_page"];

    }
    if(indexPath.row % 23 == 3)
    {
      [self sendDataToNextSceneWithPicSubString:@"inax_lt_asteo" andPicMount:4 withPageString:@"inax_lt_page4"];
    }
    
    if(indexPath.row % 23 == 4)
    {
       
        [self sendDataToNextSceneWithPicSubString:@"inax_lt_harmo" andPicMount:4 withPageString:@"inax_lt_page4"];

    }
    if(indexPath.row % 23 == 5)
    {
        
        [self sendDataToNextSceneWithPicSubString:@"inax_lt_yixiangjing" andPicMount:4 withPageString:@"inax_lt_page4"];
    }

    if(indexPath.row % 23 == 6)
    {
   
      [self sendDataToNextSceneWithPicSubString:@"inax_lt_eco_tech" andPicMount:4 withPageString:@"inax_lt_page4"];

    }
    if(indexPath.row % 23 == 7)
    {
        
      [self sendDataToNextSceneWithPicSubString:@"inax_lt_ailaige" andPicMount:2 withPageString:@"inax_lt_page2"];

    }
    if(indexPath.row % 23 == 8)
    {
        [self sendDataToNextSceneWithPicSubString:@"inax_lt_suolaisi" andPicMount:5 withPageString:@"wooden_lt_zhineng_main_fangdao_page"];
    }
    if(indexPath.row % 23 == 9)
    {
      
      [self sendDataToNextSceneWithPicSubString:@"inax_lt_hw" andPicMount:2 withPageString:@"inax_lt_page2"];

    }
    if(indexPath.row % 23 == 10)
    {
        
        [self sendDataToNextSceneWithPicSubString:@"inax_lt_oufute" andPicMount:3 withPageString:@"wooden_lt_page"];

    }
    if(indexPath.row % 23 == 11)
    {
        [self sendDataToNextSceneWithPicSubString:@"inax_lt_cp" andPicMount:2 withPageString:@"inax_lt_page2"];

    }
    if(indexPath.row % 23 == 12)
    {
        [self sendDataToNextSceneWithPicSubString:@"inax_lt_shumo" andPicMount:3 withPageString:@"wooden_lt_page"];

    }
    if(indexPath.row % 23 == 13)
    {
     
        [self sendDataToNextSceneWithPicSubString:@"inax_lt_yingyashi" andPicMount:3 withPageString:@"wooden_lt_page"];
    }
    if(indexPath.row % 23 == 14)
    {
        [self sendDataToNextSceneWithPicSubString:@"inax_lt_anmoyugang" andPicMount:3 withPageString:@"wooden_lt_page"];
    }
    if(indexPath.row % 23 == 15)
    {
        [self sendDataToNextSceneWithPicSubString:@"inax_lt_yiban" andPicMount:6 withPageString:@"inax_lt_page6"];
    }
    if(indexPath.row % 23 == 16)
    {
        [self sendDataToNextSceneWithPicSubString:@"inax_lt_qingpen" andPicMount:4 withPageString:@"inax_lt_page4"];
    }
    if(indexPath.row % 23 == 17)
    {
        [self sendDataToNextSceneWithPicSubString:@"inax_lt_sma" andPicMount:2 withPageString:@"inax_lt_page2"];
    }
    if(indexPath.row % 23 == 18)
    {
  
       [self sendDataToNextSceneWithPicSubString:@"inax_lt_zunyu" andPicMount:2 withPageString:@"inax_lt_page2"];
        
    }
    if(indexPath.row % 23 == 19)
    {
      [self sendDataToNextSceneWithPicSubString:@"inax_lt_naiyi" andPicMount:5 withPageString:@"wooden_lt_zhineng_main_fangdao_page"];
    }
    if(indexPath.row % 23 == 20)
    {
    
      [self sendDataToNextSceneWithPicSubString:@"inax_lt_xiaobianqi" andPicMount:4 withPageString:@"inax_lt_page4"];
    }
    if(indexPath.row % 23 == 21)
    {
      [self sendDataToNextSceneWithPicSubString:@"inax_lt_zidonglongtou" andPicMount:3 withPageString:@"wooden_lt_page"];
    }
    if(indexPath.row % 23 == 22)
    {
     [self sendDataToNextSceneWithPicSubString:@"inax_lt_jieshui" andPicMount:2 withPageString:@"inax_lt_page2"];
        
    }

    InaxLeadingTechCell * cell = (InaxLeadingTechCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if(_previousCell != cell)
    {
        _previousCell.blueImageView.alpha = 0;
        _previousCell = cell;
    }
    
    cell.blueImageView.alpha = 1;
   
}
-(void)sendDataToNextSceneWithPicSubString:(NSString *)subString andPicMount:(int)mount withPageString:(NSString*)pageString
{
    _ContentArray = [NSMutableArray arrayWithCapacity:2];
    [_ContentArray addObject:subString];
    NSNumber *nums = [[NSNumber alloc]initWithInt:mount];
    [_ContentArray addObject:nums];
    [self performSelector:@selector(toDetailInterfaceArray:) withObject:_ContentArray  afterDelay:0.3];
    pageImageView.image = [UIImage imageNamed:[pageString stringByAppendingFormat:@"%d",1]];
    
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
  
    return 23*36;
}
- (void)toDetailInterface:(NSString*)imgName
{
    
   scollViewContent = [self  creatScrollView:CGRectMake(0, 0, 1024, 683) imageName:imgName];
    [detailView addSubview:scollViewContent];
    detailView.alpha = 1;
    isDetailView = YES;
    pageCountImageView = [[UIImageView alloc] initWithFrame:CGRectMake(892, 552, 69/2, 185/2)];
    pageCountImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"inax_lt_page%d", 1]];
    [detailView addSubview:pageCountImageView];
}
- (void)toDetailInterfaceArray:(NSMutableArray*)array
{

    NSString *imgNames = [array objectAtIndex:0];
    
   NSNumber *subCount =  [array objectAtIndex:1];
    
     int  num = [subCount intValue];
    
    _scrollContentArray = [ self addImgTothisMutableArrayWithCount:num andImgString:imgNames];

    _scrollContent = [self creatScrollView:CGRectMake(0, 85, 1024, 683) imageArray:_scrollContentArray];
    [self.view addSubview:_scrollContent];
    [self.view bringSubviewToFront:_scrollContent];
     [self.view bringSubviewToFront:pageImageView];
     pageImageView.hidden = NO;
    isDetailView = YES;

}



#pragma mark - 重写父类的返回方法

- (void) backButtonEvent
{
    if (isDetailView)
    {
        [pageCountImageView removeFromSuperview];
        if(_scrollContent!=nil)
        {
            [_scrollContent removeFromSuperview];
            _scrollContent =nil;
            _scrollContentArray = nil;
            _ContentArray = nil;
            isDetailView = NO;
            pageImageView.hidden = YES;
        }
        
    if(detailView.alpha ==1 )
        {
         detailView.alpha = 0;
        isDetailView = NO;
        }
       // pageCountImageView = nil;

        [scrollViews reloadData];
        
    
    }
    else
    {
        [self.navigationController popViewControllerAnimated:NO];
    }
}

- (IBAction)leftBtnPressed:(UIButton *)sender {
    
      if(scrollViews.contentOffset.x <= 1024/1.0 )return;
    
    [UIView animateWithDuration:0.1 animations:^{
        
      [scrollViews setContentOffset:CGPointMake(scrollViews.contentOffset.x - 1024, scrollViews.contentOffset.y)];
        
    }];
}

- (IBAction)rightBtnPressed:(UIButton *)sender {
   
    if(scrollViews.contentOffset.x >= 1024/6 * 23*36 - 1024)return;
    
    [UIView animateWithDuration:0.1 animations:^{
        
        [scrollViews setContentOffset:CGPointMake(scrollViews.contentOffset.x + 1024, scrollViews.contentOffset.y)];
        
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
