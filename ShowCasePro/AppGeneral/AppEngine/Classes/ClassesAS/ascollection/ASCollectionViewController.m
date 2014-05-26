//
//  ASCollectionViewController.m
//  TCollectionViewController
//
//  Created by lvpw on 14-2-15.
//  Copyright (c) 2014年 lvpw. All rights reserved.
//

#import "ASCollectionViewController.h"
#import "GenericDao+Suites.h"
#import "Suites.h"
#import "ModueSpaceViewController.h"


#define ASCCollectionViewCellIdentifier @"ASCCollectionViewCellIdentifier"

@interface ASCollectionViewController () <iCarouselDataSource, iCarouselDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) NSArray *collectionArr;
@property BOOL iCarouselScrollState;
@property (nonatomic, strong) NSDictionary *matchup;

@end

@implementation ASCollectionViewController

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGPoint offset = scrollView.contentOffset;
    self.pageControl.currentPage = offset.x/1024;
}

#pragma mark - Handle Action

- (IBAction)changeToGridFrameAction:(id)sender {
    [UIView animateWithDuration:0.3 animations:^{
        self.iCarousel.alpha = 0;
        self.textImage.alpha = 0;
        self.collectionView.alpha = 1;
        self.pageControl.alpha = 1;
    }];
    [self.coverflowBtn setImage:[UIImage imageNamed:@"coverflow"] forState:UIControlStateNormal];
    [self.gridframeBtn setImage:[UIImage imageNamed:@"sixge"] forState:UIControlStateNormal];
}

- (IBAction)changeToCoverFlowAction:(id)sender {
    [UIView animateWithDuration:0.3 animations:^{
        self.iCarousel.alpha = 1;
        self.textImage.alpha = 1;
        self.collectionView.alpha = 0;
        self.pageControl.alpha = 0;
    }];
    [self.coverflowBtn setImage:[UIImage imageNamed:@"coverflowh"] forState:UIControlStateNormal];
    [self.gridframeBtn setImage:[UIImage imageNamed:@"sixge-b"] forState:UIControlStateNormal];
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    int row;
    row = [(NSString *)self.matchup[[NSString stringWithFormat:@"%d", indexPath.row]] integerValue];
    Suites *suite = self.collectionArr[indexPath.section *6 + row];
    
    ModueSpaceViewController *spaceViewController = [[ModueSpaceViewController alloc] initWithNibName:@"ModueSpaceViewController" bundle:nil];
    spaceViewController.brandID = [[LibraryAPI sharedInstance] currentBrandID];
    spaceViewController.suiteID = suite.suiteid;
    
    [self.navigationController pushViewController:spaceViewController animated:NO];
    
    
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.collectionArr.count%6==0 ? self.collectionArr.count/6 : self.collectionArr.count/6+1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = 0;
    // 横向滚动 改变collectionview的排列方式
    row = [(NSString *)self.matchup[[NSString stringWithFormat:@"%d", indexPath.row]] integerValue];
    
    NSInteger index = indexPath.section*6+row;
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ASCCollectionViewCellIdentifier forIndexPath:indexPath];
    if (index < self.collectionArr.count) {
        UIImageView *imageView = (UIImageView *)[cell viewWithTag:1000];
        if (imageView == nil) {
            imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 298, 265)];
            imageView.tag = 1000;
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            [cell addSubview:imageView];
            // 阴影
            CGRect bounds = imageView.bounds;
            bounds = (CGRect){.origin=bounds.origin, .size=CGSizeMake(bounds.size.width, bounds.size.height-52)};
            imageView.layer.shadowPath = [UIBezierPath bezierPathWithRect:bounds].CGPath;
            imageView.layer.shadowColor = [UIColor blackColor].CGColor;
            imageView.layer.shadowOffset = CGSizeMake(0, 8);
            imageView.layer.shadowRadius = 15;
            imageView.layer.shadowOpacity = 1;
        }
        cell.hidden = NO;
        Suites *suite = self.collectionArr[index];
        imageView.image = [[LibraryAPI sharedInstance] getImageFromPath:suite.img2 scale:2];
    } else {
       cell.hidden = YES;
    }
    
    return cell;
}

#pragma mark - iCarouselDelegate

- (CATransform3D)carousel:(iCarousel *)_carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform
{
    //implement 'flip3D' style carousel
    transform = CATransform3DRotate(transform, M_PI / 8.0f, 0.0f, 1.0f, 0.0f);
    return CATransform3DTranslate(transform, 0.0f, 0.0f, offset * self.iCarousel.itemWidth);
}

- (CGFloat)carousel:(iCarousel *)_carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    //customize carousel display
    switch (option)
    {
        case iCarouselOptionSpacing:
        {
            return value * 2.f;
        }
        case iCarouselOptionTilt:
        {
            return 0.2;
        }
        default:
        {
            return value;
        }
    }
}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
//    NSLog(@"Tapped view number: %d", index);
    Suites *suite = self.collectionArr[index];
    
    ModueSpaceViewController *spaceViewController = [[ModueSpaceViewController alloc] initWithNibName:@"ModueSpaceViewController" bundle:nil];
    spaceViewController.brandID = [[LibraryAPI sharedInstance] currentBrandID];
    spaceViewController.suiteID = suite.suiteid;
    
    [self.navigationController pushViewController:spaceViewController animated:NO];
    
    
}

- (void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel
{
//    NSLog(@"%d",carousel.currentItemIndex);
//    [UIView animateWithDuration:0.1 animations:^{
//        self.textImage.alpha = 0;
//    } completion:^(BOOL finished) {
//        [UIView animateWithDuration:0.1 animations:^{
//            self.textImage.alpha = 1;
//        }];
//    }];
    //CGPoint center = self.textImage.center;
//    UIImage *image = [UIImage imageNamed:[self.collectionArr[carousel.currentItemIndex] stringByAppendingString:@"dec"]];
    Suites *suite = self.collectionArr[carousel.currentItemIndex];
    UIImage *image = [[LibraryAPI sharedInstance] getImageFromPath:suite.remark scale:1];
    self.textImage.frame = (CGRect){.origin=self.textImage.frame.origin, .size=CGSizeMake(image.size.width/2, image.size.height/2)};
//    NSLog(@"%f, %f", image.size.width/2, image.size.height/2);
    //self.textImage.center = center;
    self.textImage.image = image;
    // 全部变暗
    NSArray *arr = carousel.visibleItemViews;
    for (UIView *view1 in arr) {
        UIView *shadowView = [view1 viewWithTag:2000];
        shadowView.alpha = 0.5;
    }
    // 当前item亮
    UIView *view = carousel.currentItemView;
    UIView *shadowView = [view viewWithTag:2000];
    [UIView animateWithDuration:0.3 animations:^{
        shadowView.alpha = 0;
    }];
    
    if (!self.iCarouselScrollState) {
        self.iCarouselScrollState = YES;
    }
}

#pragma mark - iCarouselDataSource

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return self.collectionArr.count;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    if (view == nil)
    {
        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 544.0f, 407.0f)];
        view.contentMode = UIViewContentModeScaleAspectFill;
        
        view.layer.shadowPath = [UIBezierPath bezierPathWithRect:view.bounds].CGPath;
        view.layer.shadowColor = [UIColor blackColor].CGColor;
        view.layer.shadowOffset = CGSizeMake(0, 8);
        view.layer.shadowRadius = 15;
        view.layer.shadowOpacity = 1;
        
        UIView *shadowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 544.0f, 407.0f)];
        shadowView.tag = 2000;
        shadowView.backgroundColor = [UIColor blackColor];
        shadowView.alpha = 0.5;
        [view addSubview:shadowView];
        if (index == 0 && !self.iCarouselScrollState) {
            shadowView.alpha = 0;
        }
        
    }
    // 名字image
    UIImageView *nameImageView = (UIImageView *)[view viewWithTag:123];
    if (nameImageView == nil) {
        
        nameImageView= [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, 216, 33)];
        nameImageView.tag = 123;
        [view addSubview:nameImageView];
    }
//    UIImage *nameImage = [UIImage imageNamed:[self.collectionArr[index] stringByAppendingString:@"name"]];
    Suites *suite = self.collectionArr[index];
    UIImage *nameImage = [[LibraryAPI sharedInstance] getImageFromPath:suite.img4 scale:1];
    nameImageView.image = nameImage;
    CGRect frame = nameImageView.frame;
    frame.size = CGSizeMake(nameImage.size.width/2, nameImage.size.height/2);
    nameImageView.frame = frame;
    // 图片
    ((UIImageView *)view).image = [[LibraryAPI sharedInstance] getImageFromPath:suite.img3 scale:2];
//    ((UIImageView *)view).image = [UIImage imageNamed:[self.collectionArr[index] stringByAppendingString:@"-"]];
//    [view bringSubviewToFront:nameImageView];
    return view;
}

#pragma mark - Init

- (void)initData
{
//    self.collectionArr = @[@"udslamoda", @"udsnobile", @"udslavita", @"idsnatural", @"idsclearqingxin",@"idsdynamic",@"ventuno",  @"moments", @"acacia", @"tonic",  @"townsquare",  @"cygnet", @"activeactiva", @"neomodern", @"concept",  @"simple"];
    GenericDao *suitesDao = [[GenericDao alloc] initWithClassName:@"Suites"];
    NSArray *arr = [suitesDao selectASCollectionsByOptions:@{@"suiteid":@"id"}];
    self.collectionArr = arr;
}

#pragma mark - Life Cycle

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
    [self initData];
    
    self.iCarousel.type = iCarouselTypeCoverFlow2;
    self.iCarousel.scrollSpeed = 0.1;
    self.iCarouselScrollState = NO;
    [self.iCarousel reloadData];
    
    self.navigationController.navigationBar.translucent = NO;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:ASCCollectionViewCellIdentifier];
    
    self.matchup = [[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"CollectionViewHorizonMatchup" ofType:@"plist"]] objectForKey:@"6"];
    
    self.pageControl.numberOfPages = self.collectionArr.count%6==0 ? self.collectionArr.count/6 : self.collectionArr.count/6+1;
    
    //self.textImage.contentMode = UIViewContentModeTopLeft;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
