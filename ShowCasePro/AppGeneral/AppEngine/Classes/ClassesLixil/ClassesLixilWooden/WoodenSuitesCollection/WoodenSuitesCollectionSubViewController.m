//
//  WoodenSuitesCollectionSubViewController.m
//  ShowCasePro
//
//  Created by Mac on 14-4-9.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "WoodenSuitesCollectionSubViewController.h"
#import "InaxSuiteCollection.h"
#import "LixilProductDetailView.h"
#import "DatabaseOption+condition.h"

#define TableView_Cell_Height                   85

#define TableView_ImageView_ContentOffSet       50
#define TableView_ImageView_Tag                 57363



#define CollectionView_Identifier               @"InaxShowProductsCell"

#define Collection_Cell_ImageView_Tag           11
#define Collection_Cell_Lable_Tag               22

@interface WoodenSuitesCollectionSubViewController ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
{
    __weak IBOutlet UIImageView *bgImageView;
    __weak IBOutlet UITableView *categoryTableView;
    __weak IBOutlet UICollectionView *productsCollectionView;
    
    
    UIScrollView *scrollView;
    NSTimer *scrollTimer ;
    int imageNum;
    UIPageControl *pageControl;
}

@property (nonatomic , strong) DatabaseOption *dbo;

@property (nonatomic , strong) NSArray *productsArray; //搜索出的产品数组

@end

@implementation WoodenSuitesCollectionSubViewController

#pragma mark - collection view data source -

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = (UICollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CollectionView_Identifier forIndexPath:indexPath];
    
    if (indexPath.row < self.productsArray.count)
    {
        cell.hidden = NO;
        
        Tproduct *product = (Tproduct *)[self.productsArray objectAtIndex:indexPath.row];
        
        UIImageView *productImg = (UIImageView *)[cell viewWithTag:Collection_Cell_ImageView_Tag];
        productImg.image = nil;
        
        // scale image in background
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            UIImage *endImage = [[LibraryAPI sharedInstance] getImageFromPath:product.image1 scale:4];
            dispatch_async(dispatch_get_main_queue(), ^{
                productImg.image = endImage;
            });
        });
        

        UILabel *productCode = (UILabel *)[cell viewWithTag:Collection_Cell_Lable_Tag];
      /*  CGRect  frame =  productCode.frame;
        frame.origin.y = 200;
        productCode.frame = frame;*/
        productCode.adjustsFontSizeToFitWidth = YES;
        
        productCode.text  = [self deleteSpaceString:product.code];
        
    } else
    {
        cell.hidden = YES;
    }
    
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.productsArray.count;
}

#pragma mark - collection view delegate -

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row >= self.productsArray.count)
    {
        NSLog(@"error : collectionView:didSelectItemAtIndexPath: 数组越界.");
        return;
    }
    
    Tproduct *product = [self.productsArray objectAtIndex:indexPath.row];
    
    //NSLog(@"product name : %@",product.name);
    
    LixilProductDetailView *pdv = [LixilProductDetailView new];
    pdv.productid = product.productid;
    
    [self.navigationController pushViewController:pdv animated:NO];
}

#pragma mark - table view data source -

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 85)];
        imageView.tag = TableView_ImageView_Tag;
        [cell addSubview:imageView];
        
        cell.backgroundColor = [UIColor clearColor];
    }
    
    InaxSuiteCollection *isc = [self.dataArray objectAtIndex:indexPath.row];
    NSString *imagePath = isc.des_image;
    UIImage *image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",kLibrary,imagePath]];
    
    if (image)
    {
        UIImageView *imageView = (UIImageView *)[cell viewWithTag:TableView_ImageView_Tag];
        imageView.frame = CGRectMake(TableView_ImageView_ContentOffSet, TableView_Cell_Height/2 - image.size.height/4, image.size.width/2, image.size.height/2);
        imageView.image = image;
    }
    else
    {
        NSLog(@"Error : EcocaratSuitesCollectionSubViewController : %@ : image 未找到.",NSStringFromSelector(_cmd));
    }
    
    return cell;
}

#pragma mark - table view delegate -

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    InaxSuiteCollection *isc = [self.dataArray objectAtIndex:indexPath.row];
    
   // [self changeTopSuiteImage:isc.bg_image];
    [self changeTopSuiteImagesByIndex:indexPath.row];

    [self selectProductsFromDBWithSuiteID:isc.suite_id];
}



-(void)selectDefaultIndex:(int)index
{
    
    if (index > self.dataArray.count)
    {
        return;
    }
    InaxSuiteCollection *isc = [self.dataArray objectAtIndex:index];
    
    // [self changeTopSuiteImage:isc.bg_image];
    [self changeTopSuiteImagesByIndex:index];
    
    [self selectProductsFromDBWithSuiteID:isc.suite_id];
    
}



#pragma mark - 更换上方套间图片 -

- (void) changeTopSuiteImagesByIndex:(NSInteger)index
{
    
    bgImageView.hidden = YES;
    if (!scrollView)
    {
        scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(272, 85, 751, 274)];
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.bounces = NO;
        scrollView.pagingEnabled = YES;
        [self.view insertSubview:scrollView belowSubview:categoryTableView];
        
        
        
    }
    
    
    NSString *imagePath = nil;
    NSMutableArray  *arrayImage = [NSMutableArray array];
    NSString    *strPre = nil;
    NSInteger   imageCount = 0;
    switch (index)
    {
        case 0:
        case 1:
        case 2:
        {
            InaxSuiteCollection *isc = [self.dataArray objectAtIndex:index];
            imagePath = isc.bg_image;
            imageCount = 1;
            //[self changeTopSuiteImage:isc.bg_image];
        }
          
            break;
        case 3:
            strPre = @"kangfeiliSuitesCollection";
            imageCount = 12;
            break;
        case 4:
            strPre = @"linaierSuitesCollection";
            imageCount = 4;
            break;
        default:
            break;
    }
    
    if (imagePath)
    {
      UIImage *imageTemp =  [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",kLibrary,imagePath]];
        [arrayImage addObject:imageTemp];
        
      //  [arrayImage addObject:[UIImage imageNamed:imagePath]];
    }else
    {
        for (int i = 0; i < imageCount; i++)
        {
            NSString    *strImageName = [NSString stringWithFormat:@"%@%d.png",strPre,i+1];
            UIImage *image = [UIImage imageNamed:strImageName];
            if (image)
            {
                [arrayImage addObject:image];
            }
            
        }
        
    }
    
    
    if (index < 3)
    {
        [scrollView setFrame:CGRectMake(0, 85, 1024, 274)];
        [self stopScroll];
        [pageControl setHidden:YES];
        
    }else
    {
        [scrollView setFrame:CGRectMake(272, 85, 751, 274)];
        [self startScroll];
        [pageControl setHidden:NO];
    }
   
    
    //begin tag is 1000
    if (arrayImage.count)
    {
        for (int i = 0; i < 3; i++)
        {
            UIView  *view = [scrollView viewWithTag:1000+i];
            [view removeFromSuperview];
        }
        
        
        
        for (int i = 0; i < arrayImage.count; i++)
        {
            CGFloat fxpoint = i*scrollView.frame.size.width;
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(fxpoint, 0, scrollView.frame.size.width, scrollView.frame.size.height)];
            imageView.image =  arrayImage[i];
            imageView.tag = 1000+i;
            [scrollView addSubview:imageView];
            
        }
        
        
        [scrollView setContentSize:CGSizeMake(imageCount*scrollView.frame.size.width, scrollView.frame.size.height)];
        [scrollView setDelegate:self];
        scrollView.showsHorizontalScrollIndicator = NO;
        [scrollView setContentOffset:CGPointMake(0, 0)];
        //        [];
        
        [scrollView setBackgroundColor:[UIColor redColor]];
        
        imageNum = arrayImage.count;
        
        
        if (!pageControl) {
            pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(CGRectGetMinX(scrollView.frame) + scrollView.center.x/2, 85+230, 100.0f, 20.0f)];
        }
        
        pageControl.numberOfPages = arrayImage.count;
        pageControl.currentPage = 0;
        [pageControl setBackgroundColor:[UIColor clearColor]];
        [pageControl setFrame:CGRectMake(CGRectGetMinX(scrollView.frame) + scrollView.center.x/2, 85+230, 100.0f, 20.0f)];
        [self.view addSubview:pageControl];
        
        
        
        
    }
    else
    {
        NSLog(@"Error : EcocaratSuitesCollectionSubViewController : viewWillAppear :找不到图片.");
    }
    
    if (index < 3)
    {
        [scrollView setFrame:CGRectMake(0, 85, 1024, 274)];
        [self stopScroll];
        [pageControl setHidden:YES];
        
    }else
    {
        [scrollView setFrame:CGRectMake(272, 85, 751, 274)];
        [self startScroll];
        [pageControl setHidden:NO];
    }

}


-(void)stopScroll
{
    if ([scrollTimer isValid]) {
        [scrollTimer invalidate];
    }
    
}
-(void)startScroll
{
    [self stopScroll];
    
    [scrollView setContentOffset:CGPointMake(0, 0)];
   // [self scrollMethod];
    
    scrollTimer = [NSTimer scheduledTimerWithTimeInterval:2
                                                   target:self
                                                 selector:@selector(scrollMethod)
                                                 userInfo:nil
                                                  repeats:YES];
    [scrollTimer setFireDate:[NSDate dateWithTimeIntervalSinceNow:2]];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView1{
    
    
    CGPoint section0_contentOffSet = scrollView.contentOffset;
    
    
    int page = section0_contentOffSet.x/751;
    
    pageControl.currentPage = page;
    
    
    NSLog(@"er");
    
}
- (void) changeTopSuiteImage:(NSString *)imageName
{
    UIImage *image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",kLibrary,imageName]];
    
    if (image)
    {
        bgImageView.image = image;
    }
    else
    {
        NSLog(@"Error : EcocaratSuitesCollectionSubViewController : viewWillAppear :找不到图片.");
    }
}




#pragma mark - 从数据库查询相应产品信息 -

- (void) selectProductsFromDBWithSuiteID:(NSString *)suiteID
{
    if (suiteID)
    {
        NSString *sql = [NSString stringWithFormat:@"select * from tproduct where type2 = %@ and param31 = 1",suiteID];
        self.productsArray = [self.dbo productArrayByConditionSQL:sql];
        [productsCollectionView reloadData];
    }
}


#pragma mark - life cycle -

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.dataArray && (self.selectedIndex < self.dataArray.count))
    {
        InaxSuiteCollection *isc = [self.dataArray objectAtIndex:self.selectedIndex];
        [self changeTopSuiteImage:isc.bg_image];
        [self changeTopSuiteImagesByIndex:self.selectedIndex];
        [self selectProductsFromDBWithSuiteID:isc.suite_id];
    }
    else
    {
        NSLog(@"Error : EcocaratSuitesCollectionSubViewController : viewWillAppear :数据有误.");
    }
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
    
    self.dbo = [DatabaseOption new];
    
    NSString *suiteID = ((InaxSuiteCollection *)[self.dataArray objectAtIndex:self.selectedIndex]).suite_id;
    [self selectProductsFromDBWithSuiteID:suiteID];
    
  
    categoryTableView.tableFooterView = [UIView new];
    categoryTableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    [productsCollectionView registerNib:[UINib nibWithNibName:@"InaxShowProductsCell" bundle:nil] forCellWithReuseIdentifier:CollectionView_Identifier];
    
    
    
}



- (void) scrollMethod
{
    //    if(!isDetailView)
    //    {
    NSLog(@"time running");
    CGPoint section0_contentOffSet = scrollView.contentOffset;
    
    section0_contentOffSet.x += 751;
    
    
    [scrollView setContentOffset:section0_contentOffSet animated:YES];
    
    if(section0_contentOffSet.x >= 751 * imageNum )
    {
        section0_contentOffSet.x = 0;
        
        section0_contentOffSet.x = 751;
        pageControl.currentPage = 0;
        [scrollView setContentOffset: section0_contentOffSet animated:NO];
        section0_contentOffSet.x = 0;
        [scrollView setContentOffset:section0_contentOffSet animated:YES];
        return;
    }
    
    int page = section0_contentOffSet.x/751;
    
    
    
    pageControl.currentPage = page;
    
    
}

- (NSString *) deleteSpaceString:(NSString *)string
{
    if (!string || !string.length) {
        return nil;
    }
    
    while (1)
    {
        if (!string.length) {
            break;
        }
        
        if ([[string substringWithRange:NSMakeRange(string.length-1,1)] isEqualToString:@" "])
        {
            string = [string substringWithRange:NSMakeRange(0, string.length-1)];
        }
        else
        {
            break;
        }
    }
    
    return string;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)dealloc{
    
    if ([scrollTimer isValid]) {
        [scrollTimer invalidate];
    }
    
}

@end
