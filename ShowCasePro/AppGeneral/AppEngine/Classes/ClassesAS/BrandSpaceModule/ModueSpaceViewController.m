//
//  ;
//  ShowCasePro
//
//  Created by LX on 14-3-3.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "ModueSpaceViewController.h"
#import "BrandSpace.h"
#import "DatabaseOption+BrandSpace.h"
#import "BrandSpaceView.h"
#import "ASProductListView.h"
#import "BrandSpaceButton.h"
#import "ASProductListViewController.h"

#define ASCCollectionViewCellIdentifier @"ASCCollectionViewCellIdentifier"


@interface ModueSpaceViewController ()<BrandSpaceDelegate>


@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property (strong, nonatomic) NSMutableArray *dataList;


@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic) int index;

@end

@implementation ModueSpaceViewController

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
    
    _brandID = @"2";
    
    _dataList = [NSMutableArray array];
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:ASCCollectionViewCellIdentifier];
    
    DatabaseOption *dbo = [[DatabaseOption alloc] init];
    // 查询当前品牌下套间信息
    NSMutableArray *list= [dbo getModuleSpaceList:_brandID];
    
    for (int i = 0; i < list.count; i++) {
        BrandSpace *obj = (BrandSpace *)[list objectAtIndex:i];
        if ([obj.suiteid isEqualToString:_suiteID]) {
            _index = i;
        }
        BrandSpaceView *spaceView = [BrandSpaceView initWIthSpaceData:obj];
        spaceView.delegate = self;
        [_dataList addObject:spaceView];
    }
    self.pageControl.numberOfPages = self.dataList.count;
    [self.view bringSubviewToFront:_pageControl];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:_index inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    self.pageControl.currentPage = _index;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGPoint offset = scrollView.contentOffset;
    self.pageControl.currentPage = offset.x/1024;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
   return self.dataList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ASCCollectionViewCellIdentifier forIndexPath:indexPath];
     NSInteger index = indexPath.row;
    
    UIView *view = (UIView *)[cell viewWithTag:1000];
    if (view == nil) {
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024, 704)];
        view.tag = 1000;
        [cell addSubview:view];
    } else {
        for (UIView *subview in view.subviews) {
            [subview removeFromSuperview];
        }
    }
    UIView *subview = [self.dataList objectAtIndex:index];
    [view addSubview:subview];
    
    return cell;
}


#pragma mark - brand space delegate -

-(void)btnMoreClickEvent:(BrandSpaceButton *)sender WithSuiteColor:(UIColor *)color
{
//    ASProductListView *proViewControll = [[ASProductListView alloc] initWithNibName:@"ASProductListView" bundle:nil];
    
    NSDictionary *dict = sender.brandSpaceDict;
    _index = [self.collectionView indexPathForCell:self.collectionView.visibleCells[0]].row;
//    proViewControll.productTypeID = [dict objectForKey:@"typeid"];
//    proViewControll.suiteID = [dict objectForKey:@"suiteid"];
//    proViewControll.suiteColor = color;
    
    ASProductListViewController *asproductListViewController = [[ASProductListViewController alloc] initWithNibName:@"ASProductListViewController" bundle:nil];
    asproductListViewController->_asProductListType = SuiteType;
    asproductListViewController.value = [dict objectForKey:@"suiteid"];
    asproductListViewController.productTypeid = [dict objectForKey:@"typeid"];
    asproductListViewController.color = color;
    
    [self.navigationController pushViewController:asproductListViewController animated:NO];
    
}

-(void)turnTo3DModulePageWith:(id)obj
{
//    BrandSpace *brandSpace = (BrandSpace *)obj;
    
    // 1.brandSpace 数据实体里面找到 3d模型文件的路径
    //NSString *modulePath = [NSString stringWithFormat:@"%@/%@",kLibrary,brandSpace.space_module];
    // 2.加载 下载到本地目录的 3D模型文件
    
    // 3.跳转到 3D展示 场景类。
    
    
}


@end
