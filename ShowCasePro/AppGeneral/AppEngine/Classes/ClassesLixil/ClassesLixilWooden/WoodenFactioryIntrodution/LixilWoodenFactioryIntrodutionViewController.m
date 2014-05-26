//
//  LixilWoodenFactioryIntrodutionViewController.m
//  ShowCasePro
//
//  Created by Mac on 14-3-27.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "LixilWoodenFactioryIntrodutionViewController.h"
#import "WoodenFactioryIntroductionCell.h"
NSString *kWoodenFiCellID = @"WoodenFiCellID";
#define Animation_Duration_Scroll   0.1
#define Section_Scroll_Set         15
@interface LixilWoodenFactioryIntrodutionViewController ()
{
    
    __weak IBOutlet UICollectionView *scrollViews;
    
    int currentPage;
    
    BOOL stripDownOnce;
    
    UIView *detailView;
    
    UIScrollView *scollViewContent;
    BOOL isDetailView;
    
    
    UIImageView *pageCountImageView;

    
}
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) WoodenFactioryIntroductionCell *previousCell;
@property (nonatomic , strong) NSTimer *scrollTimer;
@property (nonatomic, strong) NSMutableArray *imgArray;
@property (nonatomic, strong) NSMutableArray *desImgArray;
@end

@implementation LixilWoodenFactioryIntrodutionViewController
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if(pageCountImageView!=nil)
{
    CGPoint offset = scrollView.contentOffset;
    pageCountImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"wooden_fi_wuxi_page%d", (int)offset.y/683+1]];
}
}


- (void) scrollMethod
{
    if(!isDetailView)
    {
        CGPoint section0_contentOffSet = scrollViews.contentOffset;
        
        section0_contentOffSet.x += Section_Scroll_Set;
        
        
        [scrollViews setContentOffset:section0_contentOffSet animated:YES];
        
        if(section0_contentOffSet.x >= 1024/3 * 3 * 35)
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
    // Do any additional setup after loading the view from its nib.
    
    [scrollViews registerClass:[WoodenFactioryIntroductionCell class] forCellWithReuseIdentifier:kWoodenFiCellID];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(1024/3.0,703)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    [flowLayout setHeaderReferenceSize:CGSizeMake(0,0)];
    [flowLayout setFooterReferenceSize:CGSizeMake(0, 0)];
    [scrollViews setCollectionViewLayout:flowLayout];
    // scrollViews.pagingEnabled= YES;
    scrollViews.bounces = NO;
    
    stripDownOnce = NO;
  //  [self performSelector:@selector(delayScrollMethod) withObject:nil afterDelay:1];
    _imgArray = [NSMutableArray arrayWithCapacity:3];
    _desImgArray = [NSMutableArray arrayWithCapacity:3];
    for(int i= 1;i<4;i++)
    {
        NSString *imageToLoad = [NSString stringWithFormat:@"wooden_fi_strip%d.png", i];
        UIImage *img =  [UIImage imageNamed:imageToLoad];
        [_imgArray addObject:img];
        NSString *desImageToLoad = [NSString stringWithFormat:@"wooden_fi_item%d.png", i];
        UIImage *desImage =  [UIImage imageNamed:desImageToLoad];
        [_desImgArray addObject:desImage];
    }
    
    detailView = [[UIView alloc] initWithFrame:CGRectMake(0, 85, 1024, 683)];
    detailView.backgroundColor = [UIColor blueColor];
    detailView.alpha = 0;
    [self.view addSubview:detailView];

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
    [scrollView setAlwaysBounceVertical:YES];
    if([imgName isEqualToString:@"wooden_fi_wuxi_des1"])
    {
    [scrollView setContentSize:CGSizeMake(img.size.width/2, 683*3)];
    }
    else{
    
        [scrollView setContentSize:CGSizeMake(img.size.width/2, 683)];
    }
 
    
   
    scrollView.backgroundColor = [UIColor clearColor];
    
    UIImageView   *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, img.size.width/2, img.size.height/2)];
    imgView.image = img;
        scollViewContent = scrollView;
    [scollViewContent addSubview:imgView];
    if([imgName isEqualToString:@"wooden_fi_wuxi_des1"])
    {
       
        UIImage *img2 =  [UIImage imageNamed:@"wooden_fi_wuxi_des2"];
        UIImageView   *imgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 683, img2.size.width/2, img2.size.height/2)];
        imgView2.image = img2;
        [scollViewContent addSubview:imgView2];
        
        UIImage *img3 =  [UIImage imageNamed:@"wooden_fi_certificate"];
        UIImageView   *imgView3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 683*2, img3.size.width/2, img3.size.height/2)];
        imgView3.image = img3;
        [scollViewContent addSubview:imgView3];
        
        
    }

    
    
    
    
    return scrollView;
}


- (UICollectionViewCell*)cellForIndexRow:(int)row
{
    NSIndexPath *indexpath = [NSIndexPath indexPathForRow:row inSection:0];
    UICollectionViewCell  *cell = [scrollViews cellForItemAtIndexPath:indexpath];
    return cell;
}




- (WoodenFactioryIntroductionCell  *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WoodenFactioryIntroductionCell  *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kWoodenFiCellID forIndexPath:indexPath];
    
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
    blueImg.image = [UIImage imageNamed:@"wooden_fi_bottom"];
    UIImage  *imgTemp  = (UIImage*)[_imgArray objectAtIndex:indexPath.row%3];
    img.image = imgTemp;
    // img.bounds = CGRectMake(0, 0, imgTemp.size.width/2, imgTemp.size.height/2);
    UIImage  *desTemp  =  (UIImage*)[_desImgArray objectAtIndex:indexPath.row%3];
    desImg.image = desTemp;
    cell.desImageView.frame = CGRectMake(cell.desImageView.frame.origin.x, 50, desTemp.size.width/2, desTemp.size.height/2);
    cell.desImageView.center = CGPointMake(cell.frame.size.width/2, 50+desTemp.size.height/4);
    
    if(stripDownOnce == NO)
    {
        CGRect frame = img.frame;
        frame.origin.y = -2000;
        img.frame = frame;
        delaytime = 0.3;
        
        if(indexPath.row == 2)
        {
            stripDownOnce = YES;
        }
        
        NSUInteger row = indexPath.row+1;
        
        [UIView animateWithDuration:row * delaytime animations:^{
            
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
    if(indexPath.row % 3 == 1)
    {
        // isDetailView = YES;
        [self performSelector:@selector(toDetailInterface:) withObject:@"wooden_fi_wuxi_des1" afterDelay:0.5];
    }
    if(indexPath.row % 3 == 0)
    {
        // isDetailView = YES;
        [self performSelector:@selector(toDetailInterface:) withObject:@"wooden_fi_dalian_des" afterDelay:0.5];
    }
    
    WoodenFactioryIntroductionCell * cell = (WoodenFactioryIntroductionCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if(_previousCell != cell)
    {
        _previousCell.blueImageView.alpha = 0;
        _previousCell = cell;
    }
    
    cell.blueImageView.alpha = 1;
    
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 3*36;
}
- (void)toDetailInterface:(NSString*)imgName
{

    scollViewContent = [self  creatScrollView:CGRectMake(0, 0, 1024, 683) imageName:imgName];
    [detailView addSubview:scollViewContent];
    detailView.alpha = 1;
    isDetailView = YES;
    if([imgName isEqualToString:@"wooden_fi_dalian_des"])return;
    pageCountImageView = [[UIImageView alloc] initWithFrame:CGRectMake(892, 552, 72/2, 191/2)];
    pageCountImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"wooden_fi_wuxi_page%d", 1]];
    [detailView addSubview:pageCountImageView];
    
}
#pragma mark - 重写父类的返回方法

- (void) backButtonEvent
{
    if (isDetailView)
    {
        detailView.alpha = 0;
        isDetailView = NO;
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
    
    if(scrollViews.contentOffset.x >= 1024/3 * 3*36 - 1024)return;
    
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
