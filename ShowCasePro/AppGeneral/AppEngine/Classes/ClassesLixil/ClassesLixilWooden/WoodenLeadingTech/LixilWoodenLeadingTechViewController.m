//
//  LixilWoodenLeadingTechViewController.m
//  ShowCasePro
//
//  Created by Mac on 14-3-27.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "LixilWoodenLeadingTechViewController.h"
#import "WoodenLeadingTechCell.h"
#import "WoodenLeadingTechZhiNengMenViewController.h"
#import "UserGuideTips.h"
NSString *kWoodenLtCellID = @"WoodenLtCellID";
#define Animation_Duration_Scroll   0.1
#define Section_Scroll_Set         15



@interface LixilWoodenLeadingTechViewController ()
{
    __weak IBOutlet UICollectionView *scrollViews;
    int currentPage;
    
    BOOL stripDownOnce;
    
    UIView *detailView;
    
    UIScrollView *scollViewContent;
    BOOL isDetailView;
    BOOL isSheetView;
    
    UIImageView *pageCountImageView;
    __weak IBOutlet UIImageView *biMenQi;
    __weak IBOutlet UIImageView *heYie;
    __weak IBOutlet UIImageView *shuZhi;
    __weak IBOutlet UIImageView *yanGe;
    __weak IBOutlet UIImageView *huanBao;
    __weak IBOutlet UIImageView *huaLun;
    __weak IBOutlet UIImageView *boLi;
    __weak IBOutlet UIImageView *huanChong;
    __weak IBOutlet UIImageView *sixDao;
    __weak IBOutlet UIImageView *xiaoYinSuo;
    
    __weak IBOutlet UIView *shineiVIew;
    
    __weak IBOutlet UIScrollView *sheetScrollView;
    UIImageView *pageImageView ;
    
    UIScrollView *sheetScrollViewNew;
    UIView *sheetView;
    
}
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) WoodenLeadingTechCell *previousCell;
@property (nonatomic , strong) NSTimer *scrollTimer;
@property (nonatomic, strong) NSMutableArray *imgArray;
@property (nonatomic, strong) NSMutableArray *desImgArray;
@property (nonatomic, strong) WoodenLeadingTechZhiNengMenViewController *zhiengmenControler;
@property (nonatomic, strong) WoodenLeadingTechCell * currentCell;
@end

@implementation LixilWoodenLeadingTechViewController

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if(pageCountImageView!=nil)
    {

    CGPoint offset = scrollView.contentOffset;
    pageCountImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"inax_lt_page%d", (int)offset.y/683+1]];
    }
    if(pageImageView!=nil)
    {
        CGPoint offset =  sheetScrollViewNew.contentOffset;
        pageImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"wooden_lt_page%d", (int)offset.y/683+1]];
        
    }
    

    
}




- (void) scrollMethod
{
    if(!isDetailView)
    {
        CGPoint section0_contentOffSet = scrollViews.contentOffset;
        
        section0_contentOffSet.x += Section_Scroll_Set;
        
        
        [scrollViews setContentOffset:section0_contentOffSet animated:YES];
        
        if(section0_contentOffSet.x >= 1024/3 * 3* 35)
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
    
    [scrollViews registerClass:[WoodenLeadingTechCell class] forCellWithReuseIdentifier:kWoodenLtCellID];
    
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
   // [self performSelector:@selector(delayScrollMethod) withObject:nil afterDelay:1];
    _imgArray = [NSMutableArray arrayWithCapacity:3];
    _desImgArray = [NSMutableArray arrayWithCapacity:3];
    for(int i= 1;i<4;i++)
    {
        NSString *imageToLoad = [NSString stringWithFormat:@"wooden_lt_strip%d.png", i];
        UIImage *img =  [UIImage imageNamed:imageToLoad];
        [_imgArray addObject:img];
        NSString *desImageToLoad = [NSString stringWithFormat:@"wooden_lt_item%d.png", i];
        UIImage *desImage =  [UIImage imageNamed:desImageToLoad];
        [_desImgArray addObject:desImage];
    }
    
    detailView = [[UIView alloc] initWithFrame:CGRectMake(0, 85, 1024, 683)];
    detailView.backgroundColor = [UIColor blueColor];
    detailView.alpha = 0;
    [self.view addSubview:detailView];
    [self.view viewWithTag:101].hidden = YES;
    
    
    sheetView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 1024, 768)];
    [self.view addSubview:sheetView];
    sheetView.hidden = YES;
    
    pageImageView = [[UIImageView alloc] initWithFrame:CGRectMake(892, 612, 72/2, 191/2)];
    NSString *pageImage = [NSString stringWithFormat:@"wooden_lt_page%d.png", 1];
    pageImageView.image =  [UIImage imageNamed:pageImage];
    
    [self.view addSubview:pageImageView];
    
    [self.view  bringSubviewToFront:pageImageView];
    pageImageView.hidden = YES;
    
    
}


- (UICollectionViewCell*)cellForIndexRow:(int)row
{
    NSIndexPath *indexpath = [NSIndexPath indexPathForRow:row inSection:0];
    UICollectionViewCell  *cell = [scrollViews cellForItemAtIndexPath:indexpath];
    return cell;
}

- (UIScrollView*) creatScrollView:(CGRect)frame imageName:(NSString*)imgName
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:frame];
    scrollView.delegate = self;
   // scrollView.pagingEnabled = YES;
    UIImage *img =  [UIImage imageNamed:imgName];
    scrollView.bounces = NO;
    [scrollView setShowsHorizontalScrollIndicator:NO];
    [scrollView setShowsVerticalScrollIndicator:NO];
    
    [scrollView setContentSize:CGSizeMake(img.size.width/2, 683*3)];
    
    scrollView.backgroundColor = [UIColor clearColor];
    
    UIImageView   *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, img.size.width/2, img.size.height/2)];
    imgView.image = img;
 //   scollViewContent = scrollView;
    
  //  [scollViewContent addSubview:imgView];
    [scrollView addSubview:imgView];

    
    
    
    
    return scrollView;
}






- (WoodenLeadingTechCell  *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WoodenLeadingTechCell  *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kWoodenLtCellID forIndexPath:indexPath];
    
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
    WoodenLeadingTechCell * cell = (WoodenLeadingTechCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if(_previousCell != cell)
    {
        _previousCell.blueImageView.alpha = 0;
        _previousCell = cell;
    }
    cell.blueImageView.alpha = 1;
    
    
    _currentCell = cell;
    if(indexPath.row % 3 == 0)
    {
        
        [self performSelector:@selector(toShiNeiMen) withObject:nil afterDelay:0.3];
        
    }
    if(indexPath.row % 3 == 1)
    {
        
        [self performSelector:@selector(toZhiNengMen) withObject:nil afterDelay:0.3];
    }
    
}


-(void)toZhiNengMen
{
    _currentCell.blueImageView.alpha = 0;
    WoodenLeadingTechZhiNengMenViewController *zhinengMenCon = [[WoodenLeadingTechZhiNengMenViewController alloc]init];
    
    self.zhiengmenControler = zhinengMenCon;
    
    [self.navigationController pushViewController:_zhiengmenControler animated:NO];

}




-(void)toShiNeiMen
{
     isDetailView = YES;
    shineiVIew.alpha = 1;
    UserGuideTips *guideTips = [UserGuideTips shareInstance];
    [guideTips showUserGuideView:self.view tipKey:@"LixilWoodenLeadingTechViewController"  imageNamePre:@"wooden_lt_shinei_guide"];
    

}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 3;
}
- (void)toDetailInterface:(NSString*)imgName
{
    scollViewContent = [self  creatScrollView:CGRectMake(0, 0, 1024, 683) imageName:imgName];
    [detailView addSubview:scollViewContent];
    detailView.alpha = 1;
    isDetailView = YES;
 //   pageCountImageView = [[UIImageView alloc] initWithFrame:CGRectMake(892, 552, 69/2, 185/2)];
  //  pageCountImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"inax_lt_page%d", 1]];
  //  [detailView addSubview:pageCountImageView];
}
#pragma mark - 重写父类的返回方法

- (void) backButtonEvent
{
    
    if(isSheetView)
    {
        
        if(shuZhi.alpha ==1){
        [self.view viewWithTag:101].hidden = NO;
        }else{
        [self.view viewWithTag:101].hidden = YES;
        }
        
        isSheetView = NO;
        sheetScrollView.alpha = 0;
        sheetView.hidden = YES;
        pageImageView.hidden = YES;
        return;
    }
 
    if (isDetailView)
    {
       // detailView.alpha = 0;
        if(shuZhi.alpha ==1){
        [self.view viewWithTag:101].hidden = NO;
        }else{
        [self.view viewWithTag:101].hidden = YES;
            
        }
        shineiVIew.alpha = 0;
        isDetailView = NO;
        [scrollViews reloadData];
        
        
    }
    else
    {
        [self.navigationController popViewControllerAnimated:NO];
    }
}
#pragma mark - button Pressed - methods
- (IBAction)biMenQiBtnPressed:(UIButton *)sender {
    if(isDetailView == YES)
    {
        biMenQi.alpha = 1;
    }
}
- (IBAction)heYieBtnPressed:(UIButton *)sender {
    if(isDetailView == YES)
    {
        heYie.alpha = 1;
    }
}
- (IBAction)shuZhiBtnPressed:(UIButton *)sender {
    if(isDetailView == YES)
    {
    [self.view viewWithTag:101].hidden = NO;
       shuZhi.alpha = 1;
    }
}
- (IBAction)yanGeBtnPressed:(UIButton *)sender {
    if(isDetailView == YES)
    {
        [self.view viewWithTag:101].hidden = YES;
        yanGe.alpha = 1;
    }
}
- (IBAction)huanBaoBtnPressed:(UIButton *)sender {
    if(isDetailView == YES)
    {
        huanBao.alpha = 1;
    }
}
- (IBAction)sixBtnPressed:(UIButton *)sender {
    if(isDetailView == YES)
    {
        sixDao.alpha = 1;
    }
}
- (IBAction)boLiBtnPressed:(UIButton *)sender {
    if(isDetailView == YES)
    {
        boLi.alpha = 1;
    }
}
- (IBAction)huaLunBtnPressed:(UIButton *)sender {
    if(isDetailView == YES)
    {
       huaLun.alpha = 1;
    }
}
- (IBAction)xiaoYinSuoBtnPressed:(UIButton *)sender {
    if(isDetailView == YES)
    {
        xiaoYinSuo.alpha = 1;
    }
}
- (IBAction)huanChongQiBtnPressed:(UIButton *)sender {
    if(isDetailView == YES)
    {
        huanChong.alpha = 1;
    }

}
#pragma mark - button closed - methods

- (IBAction)huanChongQiCloseBtn:(UIButton *)sender {
    if(huanChong.alpha == 1)
    {
        huanChong.alpha = 0;
    }
    if( xiaoYinSuo.alpha == 1)
    {
        xiaoYinSuo.alpha = 0;
    }
}
- (IBAction)heYieCloseBtn:(UIButton *)sender {
    if(heYie.alpha == 1)
    {
        heYie.alpha = 0;
    }
    if(biMenQi.alpha == 1)
    {
        biMenQi.alpha = 0;
    }
    
    
}
- (IBAction)shuZhiCloseBtn:(UIButton *)sender {
    if(shuZhi.alpha == 1)
    {
        [self.view viewWithTag:101].hidden = YES;
        shuZhi.alpha = 0;
    }
}
- (IBAction)yanGeCloseBtn:(UIButton *)sender {
    if(yanGe.alpha == 1)
    {
        if(shuZhi.alpha==1){
        [self.view viewWithTag:101].hidden = NO;
        }else{
        [self.view viewWithTag:101].hidden = YES;
        }
        yanGe.alpha = 0;
    }
}
- (IBAction)huanBaoCloseBtn:(UIButton *)sender {
    if( huanBao.alpha == 1)
    {
        huanBao.alpha = 0;
    }
}
- (IBAction)huaLunCloseBtn:(UIButton *)sender {
    if( huaLun.alpha == 1)
    {
        huaLun.alpha = 0;
    }
}
- (IBAction)sixCloseBtn:(UIButton *)sender {
    if(sixDao.alpha == 1)
    {
        sixDao.alpha = 0;
    }
}
- (IBAction)boliCloseBtn:(UIButton *)sender {
    if( boLi.alpha == 1)
    {
        boLi.alpha = 0;
    }
}
- (IBAction)biMenQiCloseBtn:(UIButton *)sender {
    if(biMenQi.alpha == 1)
    {
        biMenQi.alpha = 0;
    }
    if(heYie.alpha == 1)
    {
        heYie.alpha = 0;
    }
}
- (IBAction)xiaoYinSuoCloseBtn:(UIButton *)sender {
    if( xiaoYinSuo.alpha == 1)
    {
        xiaoYinSuo.alpha = 0;
    }
    if(huanChong.alpha == 1)
    {
        huanChong.alpha = 0;
    }

}

- (IBAction)sheetBtnPressed:(UIButton *)sender {
   
    [self.view viewWithTag:101].hidden = YES;
    sheetView.hidden = NO;
    
    sheetScrollViewNew = [self creatScrollView:CGRectMake(0, 85, 1024, 683) imageName:@"wooden_lt_shinei_sheet1.png"];
    
    [sheetView addSubview:sheetScrollViewNew];
    
    isSheetView = YES;
   sheetScrollViewNew.alpha = 1;
    sheetScrollViewNew.contentSize = CGSizeMake(1024, 683*3);
    sheetScrollViewNew.pagingEnabled = YES;
    sheetScrollViewNew.bounces = NO;
    
    for(int i =2;i <4;i++)
    {
        UIImageView *im = [[UIImageView alloc]initWithFrame:CGRectMake(0, (i-1)*683, 1024, 683)];
        
        NSString *image = [NSString stringWithFormat:@"wooden_lt_shinei_sheet%d.png", i];
         im.image =  [UIImage imageNamed:image];
        [sheetScrollViewNew addSubview:im];
      }
    
    pageImageView.hidden = NO;
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
