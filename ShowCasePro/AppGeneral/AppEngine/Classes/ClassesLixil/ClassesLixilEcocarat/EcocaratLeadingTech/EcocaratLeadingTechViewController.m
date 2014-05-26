//
//  EcocaratLeadingTechViewController.m
//  ShowCasePro
//
//  Created by Mac on 14-4-2.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "EcocaratLeadingTechViewController.h"
#import "EcocaratLeadingTechCell.h"
#import "UserGuideTips.h"
NSString *kEcocaratLeadingTechCellID = @"EcocaratLeadingTechCellID";
#define Animation_Duration_Scroll   0.1
#define Section_Scroll_Set         15

@interface EcocaratLeadingTechViewController ()
{
    
    __weak IBOutlet UICollectionView *scrollViews;
    __weak IBOutlet UIView *itemView1;
    __weak IBOutlet UIImageView *viewDetail1;
    __weak IBOutlet UIImageView *viewDetail2;
    
    __weak IBOutlet UIView *itemView2;
    
    __weak IBOutlet UIScrollView *view2Scroll;
    
    __weak IBOutlet UIImageView *view2AfterImg;
    
    __weak IBOutlet UIView *itemView3;
    __weak IBOutlet UIScrollView *view3Scroll;
    
    __weak IBOutlet UIView *itemView4;
    
    
    int currentPage;
    
    BOOL stripDownOnce;
    
    UIView *detailView;
    
    UIScrollView *scollViewContent;
    BOOL isDetailView;
    
    
    UIImageView *pageCountImageView;
}
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) EcocaratLeadingTechCell *previousCell;
@property (nonatomic , strong) NSTimer *scrollTimer;
@property (nonatomic, strong) NSMutableArray *imgArray;
@property (nonatomic, strong) NSMutableArray *desImgArray;
@property (nonatomic, strong)  UISlider *view2Slider;
@property (nonatomic, strong) UIScrollView *view3_1;
@property (nonatomic, strong) UIScrollView *view3_2;
@property (nonatomic, strong) UIScrollView *view3_3;
@property (nonatomic, strong) UIScrollView *view4_1;
@property (nonatomic, strong) UIScrollView *view4_2;
@end

@implementation EcocaratLeadingTechViewController
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    CGPoint offset = scrollView.contentOffset;
    pageCountImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"inax_lt_page%d", (int)offset.y/683+1]];
    
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
    // Do any additional setup after loading the view from its nib.

    
    [scrollViews registerClass:[EcocaratLeadingTechCell class] forCellWithReuseIdentifier:kEcocaratLeadingTechCellID];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(1024/4.0,703)];
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
    _imgArray = [NSMutableArray arrayWithCapacity:23];
    _desImgArray = [NSMutableArray arrayWithCapacity:23];
    for(int i= 1;i<5;i++)
    {
        NSString *imageToLoad = [NSString stringWithFormat:@"ecocarat_leading_strip%d.png", i];
        UIImage *img =  [UIImage imageNamed:imageToLoad];
        [_imgArray addObject:img];
        NSString *desImageToLoad = [NSString stringWithFormat:@"ecocarat_leading_item%d.png", i];
        UIImage *desImage =  [UIImage imageNamed:desImageToLoad];
        [_desImgArray addObject:desImage];
    }
    
    detailView = [[UIView alloc] initWithFrame:CGRectMake(0, 85, 1024, 683)];
    detailView.backgroundColor = [UIColor blueColor];
    detailView.alpha = 0;
    [self.view addSubview:detailView];
    
    view2Scroll.contentSize = CGSizeMake(700*3, 385);
    view2Scroll.pagingEnabled = YES;
    
    _view2Slider = (UISlider*)[self.view viewWithTag:15];
    
    UIImage *slider_forward = [UIImage imageNamed:@"ecoract_lt_slider_forward.png"];
    [self scaleToSize:slider_forward size:CGSizeMake(33, 10)];
    
    [_view2Slider setThumbImage:[UIImage imageNamed:@"ecoract_lt_slider_forward.png"] forState:UIControlStateNormal];
   
}
- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size{
    
    UIGraphicsBeginImageContext(size);
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
  
    UIGraphicsEndImageContext();

    return scaledImage;
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
   // scollViewContent = scrollView;
   // [scollViewContent addSubview:imgView];
    
    [scrollView addSubview:imgView];
    
    
    
    return scrollView;
}


- (UICollectionViewCell*)cellForIndexRow:(int)row
{
    NSIndexPath *indexpath = [NSIndexPath indexPathForRow:row inSection:0];
    UICollectionViewCell  *cell = [scrollViews cellForItemAtIndexPath:indexpath];
    return cell;
}




- (EcocaratLeadingTechCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    EcocaratLeadingTechCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kEcocaratLeadingTechCellID  forIndexPath:indexPath];
    
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
    blueImg.image = [UIImage imageNamed:@"ecocarat_leading_orangebottom"];
    UIImage  *imgTemp  = (UIImage*)[_imgArray objectAtIndex:indexPath.row];
    img.image = imgTemp;
    // img.bounds = CGRectMake(0, 0, imgTemp.size.width/2, imgTemp.size.height/2);
    UIImage  *desTemp  =  (UIImage*)[_desImgArray objectAtIndex:indexPath.row];
    desImg.image = desTemp;
    cell.desImageView.frame = CGRectMake(cell.desImageView.frame.origin.x, 50, desTemp.size.width/2, desTemp.size.height/2);
    cell.desImageView.center = CGPointMake(cell.frame.size.width/2, 50+desTemp.size.height/4);
    
    if(stripDownOnce == NO)
    {
        CGRect frame = img.frame;
        frame.origin.y = -3500;
        img.frame = frame;
        delaytime = 0.3;
        
        if(indexPath.row == 3)
        {
            stripDownOnce = YES;
        }
        
        [UIView animateWithDuration:(indexPath.row+1) * delaytime animations:^{
            
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
    if(indexPath.row  == 0)
    {
         isDetailView = YES;
        [self performSelector:@selector(toItemView1) withObject:nil afterDelay:0.3];

      //  [self performSelector:@selector(toItemView:) withObject:@"0" afterDelay:1];
        
    }
    if(indexPath.row  == 1)
    {
        isDetailView = YES;
         [self performSelector:@selector(toItemView2) withObject:nil afterDelay:0.3];
        
    }
    if(indexPath.row  == 2)
    {
      
        isDetailView = YES;
        [self performSelector:@selector(toItemView3) withObject:nil afterDelay:0.3];
        
    }
    if(indexPath.row  == 3)
    {
        
        
        isDetailView = YES;
        [self performSelector:@selector(toItemView4) withObject:nil afterDelay:0.3];
        
    }
    
    EcocaratLeadingTechCell * cell = (EcocaratLeadingTechCell *)[collectionView cellForItemAtIndexPath:indexPath];
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
    
    return 4;
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

-(void)toItemView1
{
    
    itemView1.alpha = 1;
    UserGuideTips *guideTips = [UserGuideTips shareInstance];
   [guideTips showUserGuideView:self.view tipKey:@"leadTechJinghuajiaquan"  imageNamePre:@"leadingJiaquan"];
 
}
-(void)toItemView2
{
    itemView2.alpha = 1;
    UserGuideTips *guideTips = [UserGuideTips shareInstance];
   [guideTips showUserGuideView:self.view tipKey:@"leadTechTiaojieshidu4"  imageNamePre:@"leadingShidu"];
    
   
}
-(void)toItemView3
{
    itemView3.alpha = 1;
}
-(void)toItemView4
{
    itemView4.alpha = 1;
    UserGuideTips *guideTips = [UserGuideTips shareInstance];
    [guideTips showUserGuideView:self.view tipKey:@"leadTechXifuyiwei1"  imageNamePre:@"leadingYiwei"];
}


#pragma mark - 重写父类的返回方法

- (void) backButtonEvent
{
    if (isDetailView)
    {
       // detailView.alpha = 0;
        if(itemView1.alpha == 1)
        {
            itemView1.alpha = 0;
        }
        if(itemView2.alpha == 1)
        {
            itemView2.alpha = 0;
        }
        if(itemView3.alpha == 1)
        {
            itemView3.alpha = 0;
        }
        if(itemView4.alpha == 1)
        {
            itemView4.alpha = 0;
        }
        
        isDetailView = NO;
        [scrollViews reloadData];
        
    }
    else
    {
        [self.navigationController popViewControllerAnimated:NO];
    }
}

- (IBAction)view1Detail1BtnPressed:(UIButton *)sender {
    [self.view viewWithTag:5].alpha = 1;
    if(viewDetail2.alpha ==1)return;
    viewDetail1.alpha = 1;
}

- (IBAction)view1Detail2BtnPressed:(UIButton *)sender {
     [self.view viewWithTag:5].alpha = 1;
    if(viewDetail1.alpha ==1)return;

    viewDetail2.alpha = 1;
}
- (IBAction)view1CloseBtnPressed:(UIButton *)sender {
    if(viewDetail1.alpha ==1||viewDetail2.alpha ==1)
    {
        viewDetail1.alpha = 0;
        viewDetail2.alpha = 0;
        [self.view viewWithTag:5].alpha = 0;
    }
}
- (IBAction)view2RIghtBtnPressed:(UIButton *)sender {
      if(view2Scroll.contentOffset.x >= 700*2/1.0 )return;
    
    [UIView animateWithDuration:0.3 animations:^{
        
        [view2Scroll setContentOffset:CGPointMake(view2Scroll.contentOffset.x + 700, view2Scroll.contentOffset.y)];
        
    }];
    
}
- (IBAction)view2LeftBtnPressed:(UIButton *)sender {
  
    if(view2Scroll.contentOffset.x <= 0/1.0 )return;
    
    [UIView animateWithDuration:0.3 animations:^{
        
        [view2Scroll setContentOffset:CGPointMake(view2Scroll.contentOffset.x - 700, view2Scroll.contentOffset.y)];
        
    }];

}
- (IBAction)coverBtn1Pressed:(UIButton *)sender {
    view2Scroll.alpha = 1;
    [self.view viewWithTag:10].alpha = 1;
    [self.view viewWithTag:11].alpha = 1;
    [self.view viewWithTag:12].alpha = 1;
}
- (IBAction)view2BtnClose:(UIButton *)sender {
    view2Scroll.alpha = 0;
    [self.view viewWithTag:10].alpha = 0;
    [self.view viewWithTag:11].alpha = 0;
    [self.view viewWithTag:12].alpha = 0;
}
- (IBAction)view2Slider:(id)sender {
    UISlider *slider = (UISlider*)sender;
    view2AfterImg.alpha = slider.value;
}

- (IBAction)view3LeftBtnPressed:(UIButton *)sender {
    
    if(_view3_2.alpha == 1||_view3_3.alpha == 1)return;

    [self.view viewWithTag:3].alpha =1;
    
  _view3_1 = [self creatScrollView:CGRectMake(162, 114, 700, 387) imageName:@"ecocarat_lt_detail_item3_detail2"];
   
    
    
    [itemView3 addSubview:_view3_1];
    
    [itemView3 bringSubviewToFront: [self.view viewWithTag:3]];
    
}
- (IBAction)view3MiddleBtnPressed:(UIButton *)sender {
    
    if(_view3_1.alpha == 1||_view3_3.alpha == 1)return;
    
    [self.view viewWithTag:3].alpha =1;
    
    _view3_2 = [self creatScrollView:CGRectMake(162, 114, 700, 387) imageName:@"ecocarat_lt_detail_item3_detail1"];
    
    
    
    [itemView3 addSubview:_view3_2];
    
    [itemView3 bringSubviewToFront: [self.view viewWithTag:3]];
    
}
- (IBAction)view3RightBtnPressed:(id)sender {
    
    
    if(_view3_1.alpha == 1||_view3_2.alpha == 1)return;
    
    [self.view viewWithTag:60].alpha =1;
    
    _view3_3 = [self creatScrollView:CGRectMake(274, 115, 700, 387) imageName:@"ecocarat_lt_detail_item3_detail3"];
    
    
    
    [itemView3 addSubview:_view3_3];
    
    [itemView3 bringSubviewToFront: [self.view viewWithTag:60]];

    
    
}

- (IBAction)view3CloseBtn:(UIButton *)sender {
    
      if(_view3_1.alpha == 1)_view3_1.alpha =0;
     if(_view3_2.alpha == 1)_view3_2.alpha =0;
    if(_view3_3.alpha == 1)_view3_3.alpha =0;
     [self.view viewWithTag:3].alpha =0;
    
}
- (IBAction)view3LastBtn:(UIButton *)sender {
    if(_view3_3.alpha == 1)_view3_3.alpha =0;
    
    [self.view viewWithTag:60].alpha =0;

}
- (IBAction)view4LeftBtnPressed:(UIButton *)sender {
    
    if(_view4_2.alpha == 1)return;
    
    [self.view viewWithTag:100].alpha =1;
    
    _view4_1 = [self creatScrollView:CGRectMake(162, 114, 700, 387) imageName:@"ecocarat_ltdetail_item4_detail2"];
    
    
    
    [itemView4 addSubview:_view4_1];
    
    [itemView4 bringSubviewToFront: [self.view viewWithTag:100]];

    
    
}
- (IBAction)view4RightBtnPressed:(UIButton *)sender {
    if(_view4_1.alpha == 1)return;
    
    [self.view viewWithTag:100].alpha =1;
    
    _view4_2 = [self creatScrollView:CGRectMake(162, 114, 700, 387) imageName:@"ecocarat_lt_detail_item4_detail1"];
    
    
    
    [itemView4 addSubview:_view4_2];
    
    [itemView4 bringSubviewToFront: [self.view viewWithTag:100]];
    
}
- (IBAction)view4CloseBtnPressed:(UIButton *)sender {
    
    if(_view4_1.alpha == 1)_view4_1.alpha =0;
    if(_view4_2.alpha == 1)_view4_2.alpha =0;
    [self.view viewWithTag:100].alpha = 0;
    

}






- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
