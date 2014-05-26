//
//  LixilWoodenBrandConceptViewController.m
//  ShowCasePro
//
//  Created by Mac on 14-3-27.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "LixilWoodenBrandConceptViewController.h"
#import "WoodenBrandConceptCell.h"
#import <MediaPlayer/MediaPlayer.h>
NSString *kWoodenBcCellID = @"WoodenBcCellID";
#define Animation_Duration_Scroll   0.1
#define Section_Scroll_Set         15
#define ToDetailTIme         0.3
@interface LixilWoodenBrandConceptViewController ()
{
    __weak IBOutlet UICollectionView *scrollViews;
    
    int currentPage;
    
    BOOL stripDownOnce;
    
    UIView *detailView;
    
    UIScrollView *scollViewContent;
    BOOL isDetailView;
    
    
    UIImageView *pageCountImageView;

    __weak IBOutlet UIView *bgView;
    __weak IBOutlet UIImageView *bgImage;
    __weak IBOutlet UIButton *playButton;
    
}
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) WoodenBrandConceptCell *previousCell;
@property (nonatomic , strong) NSTimer *scrollTimer;
@property (nonatomic, strong) NSMutableArray *imgArray;
@property (nonatomic, strong) NSMutableArray *desImgArray;
@property (strong, nonatomic) MPMoviePlayerController *mpcontroller;
@end

@implementation LixilWoodenBrandConceptViewController

- (IBAction)playVideo
{
   
    NSString *videoPath = @"data/brandvideo/lixil/Lixil_jiancai_xuanguanmen.mp4";
    NSString *url_client = [[LibraryAPI sharedInstance] downVideoByLink:videoPath
                                                                 inView:[UIApplication sharedApplication].keyWindow.rootViewController.view];
    
    if (url_client)
    {
        NSURL *url = [NSURL fileURLWithPath:url_client];
        
        [self initVideoViewWithURL:url];
    }
}


- (void)initVideoViewWithURL:(NSURL *)url
{
    MPMoviePlayerController *mpcontroller = [[MPMoviePlayerController alloc] initWithContentURL:url];
    [bgView addSubview:mpcontroller.view];
    mpcontroller.view.frame = bgView.bounds;
    mpcontroller.fullscreen = NO;
    mpcontroller.scalingMode = MPMovieScalingModeAspectFit;
    mpcontroller.shouldAutoplay = YES;
    self.mpcontroller = mpcontroller;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(videoFinish:) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(videoStataChange:) name:MPMoviePlayerNowPlayingMovieDidChangeNotification object:nil];
}

- (void)videoFinish:(NSNotification *)notification
{
    [self.mpcontroller.view removeFromSuperview];
    self.mpcontroller = nil;
    [self playAnimationWith:playButton withAlpha:1];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
}

-(void)playAnimationWith:(UIButton *)btn withAlpha:(CGFloat)value
{
    [UIView animateWithDuration:0.5f animations:^{
        [btn setAlpha:value];
    } completion:^(BOOL finished) {
        
    }];
}

- (void)videoStataChange:(NSNotification *)notification{
    
    [UIView animateWithDuration:0.5f animations:^{
        [playButton setAlpha:0];
    } completion:^(BOOL finished) {
        
    }];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:MPMoviePlayerLoadStateDidChangeNotification object:nil];
}

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
#pragma mark - buttonImage -



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [scrollViews registerClass:[WoodenBrandConceptCell class] forCellWithReuseIdentifier:kWoodenBcCellID];
    
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
   //[self performSelector:@selector(delayScrollMethod) withObject:nil afterDelay:1];
    _imgArray = [NSMutableArray arrayWithCapacity:4];
    _desImgArray = [NSMutableArray arrayWithCapacity:4];
    for(int i= 1;i<5;i++)
    {
        NSString *imageToLoad = [NSString stringWithFormat:@"wooden_bc_strip%d.png", i];
        UIImage *img =  [UIImage imageNamed:imageToLoad];
        [_imgArray addObject:img];
        NSString *desImageToLoad = [NSString stringWithFormat:@"wooden_bc_item%d.png", i];
        UIImage *desImage =  [UIImage imageNamed:desImageToLoad];
        [_desImgArray addObject:desImage];
    }
    
    detailView = [[UIView alloc] initWithFrame:CGRectMake(0, 85, 1024, 683)];
    detailView.backgroundColor = [UIColor blueColor];
    detailView.alpha = 0;
    [self.view addSubview:detailView];
    
    bgView.hidden = YES;

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
    if([imgName isEqualToString:@"wooden_bc_03bk"])
    {
        [scrollView setContentSize:CGSizeMake(img.size.width/2, 683)];
    }
    else{
        
        [scrollView setContentSize:CGSizeMake(img.size.width/2, 683)];
    }
    
    
    
    scrollView.backgroundColor = [UIColor clearColor];
    
    UIImageView   *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, img.size.width/2, img.size.height/2)];
    imgView.image = img;
    scollViewContent = scrollView;
    [scollViewContent addSubview:imgView];
    
    if([imgName isEqualToString:@"wooden_bc_03bk"])
    {
        UIImage *imgdes1 =  [UIImage imageNamed:@"wooden_bc_03des1"];
        UIScrollView *scrollView1 = [[UIScrollView alloc] initWithFrame:CGRectMake(608, 0, imgdes1.size.width/2, 603)];
        scrollView1.delegate = self;
       // scrollView1.pagingEnabled = YES;
      
        scrollView1.bounces = YES;
        [scrollView1 setShowsHorizontalScrollIndicator:NO];
        [scrollView1 setShowsVerticalScrollIndicator:NO];
        [scrollView1 setAlwaysBounceVertical:YES];
        [scrollView1 setContentSize:CGSizeMake(imgdes1.size.width/2, imgdes1.size.height+270)];
       // [scrollView1 setBackgroundColor:[UIColor blueColor]];
         scrollView1.backgroundColor = [UIColor clearColor];
        
        
      

        UIImageView   *imgViewDes1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0+81, imgdes1.size.width/2, imgdes1.size.height/2)];
        imgViewDes1.image = imgdes1;
        [scollViewContent addSubview:scrollView1];
        
        UIImage *imgdes2 =  [UIImage imageNamed:@"wooden_bc_03des2"];

        UIImageView   *imgViewDes2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, imgdes1.size.height/2+100, imgdes2.size.width/2, imgdes2.size.height/2)];
        imgViewDes2.image = imgdes2;
        
         [scrollView1 addSubview:imgViewDes2];

        [scrollView1 addSubview:imgViewDes1];
        
       
        
        UIImage *imgCover1 =  [UIImage imageNamed:@"wooden_bc_cover"];
        
        UIImageView   *imgViewCover1 = [[UIImageView alloc] initWithFrame:CGRectMake(608, 0, imgCover1.size.width/2, imgCover1.size.height/2)];
        imgViewCover1.image = imgCover1;
        
        [scollViewContent addSubview:imgViewCover1];
        
        
    }
    
    return scrollView;
}


- (UICollectionViewCell*)cellForIndexRow:(int)row
{
    NSIndexPath *indexpath = [NSIndexPath indexPathForRow:row inSection:0];
    UICollectionViewCell  *cell = [scrollViews cellForItemAtIndexPath:indexpath];
    return cell;
}




- (WoodenBrandConceptCell  *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WoodenBrandConceptCell  *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kWoodenBcCellID forIndexPath:indexPath];
    
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
    UIImage  *imgTemp  = (UIImage*)[_imgArray objectAtIndex:indexPath.row%4];
    img.image = imgTemp;
    // img.bounds = CGRectMake(0, 0, imgTemp.size.width/2, imgTemp.size.height/2);
    UIImage  *desTemp  =  (UIImage*)[_desImgArray objectAtIndex:indexPath.row%4];
    desImg.image = desTemp;
    cell.desImageView.frame = CGRectMake(cell.desImageView.frame.origin.x, 50, desTemp.size.width/2, desTemp.size.height/2);
    cell.desImageView.center = CGPointMake(cell.frame.size.width/2, 50+desTemp.size.height/4);
    
    if(stripDownOnce == NO)
    {
        CGRect frame = img.frame;
        frame.origin.y = -2000;
        img.frame = frame;
        delaytime = 0.3;
        
        if(indexPath.row == 3)
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
    WoodenBrandConceptCell * cell = (WoodenBrandConceptCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if(_previousCell != cell)
    {
        _previousCell.blueImageView.alpha = 0;
        _previousCell = cell;
    }
    
    cell.blueImageView.alpha = 1;

    
    
    
   if(indexPath.row % 4 == 3)
    {
        bgView.hidden = NO;
        isDetailView = YES;

    }
    
    if(indexPath.row % 4 == 2)
    {
        // isDetailView = YES;
        [self performSelector:@selector(toDetailInterface:) withObject:@"wooden_bc_03bk" afterDelay:ToDetailTIme];
    }
    if(indexPath.row % 4 == 1)
    {
        // isDetailView = YES;
        [self performSelector:@selector(toDetailInterface:) withObject:@"wooden_bc_02des" afterDelay:ToDetailTIme];
    }
    if(indexPath.row % 4 == 0)
    {
        // isDetailView = YES;
        [self performSelector:@selector(toDetailInterface:) withObject:@"wooden_bc_01des" afterDelay:ToDetailTIme];
    }
    
    
  
    
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
    if([imgName isEqualToString:@"wooden_bc_01des"]||[imgName isEqualToString:@"wooden_bc_02des"])return;
//    pageCountImageView = [[UIImageView alloc] initWithFrame:CGRectMake(892, 552, 69/2, 185/2)];
//    pageCountImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"wooden_fi_wuxi_page%d", 1]];
//    [detailView addSubview:pageCountImageView];
    
}

-(void)toVideoView
{
    
    
    
    
}
#pragma mark - 重写父类的返回方法

- (void) backButtonEvent
{
    if (isDetailView)
    {
        detailView.alpha = 0;
        isDetailView = NO;
        [scrollViews reloadData];
        if(bgView.hidden ==NO){
            
            bgView.hidden = YES;
        }
        
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
