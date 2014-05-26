//
//  ASProductListViewController.m
//  ShowCasePro
//
//  Created by lvpw on 14-3-14.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "ASProductListViewController.h"
#import "DownMenuViewController.h"
#import "Tproduct.h"
#import "Ttype.h"
#import "TproductProperty.h"
#import "TproductPropertyValue.h"

#import "ProductDetailView.h"
#import "DatabaseOption+Suites.h"
#import "DatabaseOption+Ttype.h"
#import "DatabaseOption+condition.h"
#import "DatabaseOption+Tproduct.h"

#import "DatabaseOption+Tsubtype.h"
#import "DatabaseOption+TproductProperty.h"
#import "DatabaseOption+TproductPropertyValue.h"
#import "GenericDao.h"

#define kFolderName 1
#define kFolderCode 2
#define kFolderImageView 3
#define kfolderEn 4
#define RightButtonWidth 80

@interface ASProductListViewController () <DownMenuViewControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray *tempProductsArray; // 用于显示的产品数组
@property (nonatomic, strong) NSMutableArray *productIDs; // 产品id数组
@property (nonatomic, strong) NSMutableDictionary *rightButtonTagDic; // 右边按钮tag对应的field
@property (nonatomic, strong) NSMutableDictionary *rightButtonsDataDic; // 右边按钮tag对应的数组
@property (nonatomic, strong) NSMutableArray *leftDataArray;

@property (nonatomic, strong) UIToolbar *toolbar;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *rightMenuButtonContainerView;

@property (nonatomic, strong) DownMenuViewController *downMenuViewController;

@property (nonatomic, strong) UICollectionView *collectionView; // 用于显示产品
@property (nonatomic, strong) NSDictionary *matchup;
@property (nonatomic) BOOL isleft; // 是否左边菜单

@property (nonatomic, strong) Ttype *currentType;
@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation ASProductListViewController

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGPoint offset = scrollView.contentOffset;
    self.pageControl.currentPage = offset.x/1018;
}

#pragma mark - Handle Action

- (void)leftButtonClickedAction:(UIButton *)sender
{
    if (self.downMenuViewController.show) {
        [self.downMenuViewController dismiss];
        [(UIView *)[self.view viewWithTag:999] removeFromSuperview];
    } else {
        [self addTapBGView];
        self.isleft = YES;
        self.downMenuViewController.dataArray = self.leftDataArray;
        self.downMenuViewController.color = self.color;
        self.downMenuViewController.buttontag = 0;
        self.downMenuViewController.delegate = self;
        [self.downMenuViewController showFromView:sender inView:self.view animated:NO];
        
    }
}

- (void)rightButonClickedAction:(UIButton *)sender
{
    if (self.downMenuViewController.show) {
        [self.downMenuViewController dismiss];
        [(UIView *)[self.view viewWithTag:999] removeFromSuperview];
    } else {
        [self addTapBGView];
        self.isleft = NO;
        self.downMenuViewController.dataArray = [self.rightButtonsDataDic objectForKey:[NSString stringWithFormat:@"%d", sender.tag]];
        self.downMenuViewController.buttontag = sender.tag;
        self.downMenuViewController.color = self.color;
        self.downMenuViewController.delegate = self;
        [self.downMenuViewController showFromView:sender inView:self.view animated:NO];
    }
}

#pragma mark - DownMenuViewControllerDelegate

- (void)downMenu:(DownMenuViewController *)downMenuViewController DidSeletedAtIndex:(NSInteger)index
{
    DatabaseOption *dbo = [[DatabaseOption alloc] init];
    if (self.isleft) {
        self.currentType = self.leftDataArray[index];
        if (_asProductListType == SearchType) {
            self.productIDs = [dbo productIDArrayByConditionSQL:[NSString stringWithFormat:@"select P.'id' from 'tproduct' AS P join 'ttype' AS T on P.'type1'=T.'id' left join 'tsubtype' AS ST on P.'type3'=ST.'id' left join 'suites' AS U on P.'type2'=U.'id' join 'tbrand' AS B on P.'brand'=B.'id' where ((P.'code' like '%%%@%%') or (T.'name' like '%%%@%%') or (ST.'name' like '%%%@%%') or (U.'name' like '%%%@%%') or (B.'name' like '%%%@%%')) and P.'brand'= '%@' and type1=%@", self.value, self.value, self.value, self.value, self.value, @"2", self.currentType.ttypeid]];
            
            self.tempProductsArray = [dbo productArrayByProductIDArray:self.productIDs];
        } else if (_asProductListType == CategoryType) {
            self.tempProductsArray = [dbo selectProductsByType:@"type1" andValue:self.currentType.ttypeid];
        } else if (_asProductListType == SuiteType || _asProductListType == MtoType) {
            self.tempProductsArray = [dbo selectProductsByType:@"type2" andValue:self.value params:@{@"type1": @[self.currentType.ttypeid]}];
        }
        [self updateRightMenuButton];
    } else {
        NSString *field = self.rightButtonTagDic[[NSString stringWithFormat:@"%d", downMenuViewController.buttontag]];
        ObjectBase *objectBase = self.rightButtonsDataDic[[NSString stringWithFormat:@"%d", downMenuViewController.buttontag]][index];
        NSString *value = objectBase.baseid;
        if ([field hasPrefix:@"param"]) {
            value = [NSString stringWithFormat:@"'%@'", value];
        }
        if (_asProductListType == SearchType) {
            self.productIDs = [dbo productIDArrayByConditionSQL:[NSString stringWithFormat:@"select P.'id' from 'tproduct' AS P join 'ttype' AS T on P.'type1'=T.'id' left join 'tsubtype' AS ST on P.'type3'=ST.'id' left join 'suites' AS U on P.'type2'=U.'id' join 'tbrand' AS B on P.'brand'=B.'id' where ((P.'code' like '%%%@%%') or (T.'name' like '%%%@%%') or (ST.'name' like '%%%@%%') or (U.'name' like '%%%@%%') or (B.'name' like '%%%@%%')) and P.'brand'= '%@' and %@=%@", self.value, self.value, self.value, self.value, self.value, @"2", field, value]];
            
            self.tempProductsArray = [dbo productArrayByProductIDArray:self.productIDs];
        } else if (_asProductListType == CategoryType) {
            self.tempProductsArray = [dbo selectProductsByType:@"type1" andValue:self.currentType.ttypeid params:@{field : @[value]}];
        } else if (_asProductListType == SuiteType || _asProductListType == MtoType) {
            self.tempProductsArray = [dbo selectProductsByType:@"type2" andValue:self.value params:@{@"type1": @[self.currentType.ttypeid], field : @[value]}];
        }
    }
    
    [self.collectionView reloadData];
    self.pageControl.numberOfPages = self.pageControl.numberOfPages = self.tempProductsArray.count%8==0 ? self.tempProductsArray.count/8 : self.tempProductsArray.count/8+1;
    [self.downMenuViewController dismiss];
    [(UIView *)[self.view viewWithTag:999] removeFromSuperview];
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = [(NSString *)self.matchup[[NSString stringWithFormat:@"%d", indexPath.row]] integerValue];
    NSInteger index = indexPath.section*8+row;
    Tproduct *product = (Tproduct *)[self.tempProductsArray objectAtIndex:index];
    ProductDetailView *detailView = [[ProductDetailView alloc]init];
    detailView.productid = product.productid;
    [self.navigationController pushViewController:detailView animated:NO];
    
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.tempProductsArray.count%8==0 ? self.tempProductsArray.count/8 : self.tempProductsArray.count/8+1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 8;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = [(NSString *)self.matchup[[NSString stringWithFormat:@"%d", indexPath.row]] integerValue];
    NSInteger index = indexPath.section*8+row;
    UICollectionViewCell *cell = (UICollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"FloderDetailCollectionViewCell" forIndexPath:indexPath];
    
    if (index < self.tempProductsArray.count)
    {
        cell.hidden = NO;
        
        Tproduct *product = (Tproduct *)[self.tempProductsArray objectAtIndex:index];
        
        UIImageView *productImg = (UIImageView *)[cell viewWithTag:kFolderImageView];
        productImg.image = nil;
        
        // scale image in background
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            UIImage *endImage = [[LibraryAPI sharedInstance] getImageFromPath:product.image1 scale:4];
            dispatch_async(dispatch_get_main_queue(), ^{
                productImg.image = endImage;
            });
        });
        
        UILabel *productCode = (UILabel *)[cell viewWithTag:kFolderCode];
        UILabel *productName = (UILabel *)[cell viewWithTag:kFolderName];
        UILabel *productEn = (UILabel *)[cell viewWithTag:kfolderEn];
        productCode.text  = [self deleteSpaceString:product.code];
        
        productName.text  = [self deleteSpaceString:product.name];
        
        productEn.text = [self deleteSpaceString:product.name_en];
    } else {
        cell.hidden = YES;
    }
    return cell;
}

#pragma mark - Util

- (void)addTapBGView
{
    UIControl *tapView = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, 1024, 704)];
    tapView.backgroundColor = [UIColor clearColor];
    tapView.tag = 999;
    [tapView addTarget:self action:@selector(tapBGView1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:tapView];
}

- (void)tapBGView1
{
    [self.downMenuViewController dismiss];
    [(UIView *)[self.view viewWithTag:999] removeFromSuperview];
}

- (void)updateRightMenuButton
{
    //mto类型产品暂时不需要右边过滤条件  暂时屏蔽
    if (_asProductListType == MtoType) {
        return;
    }
    
    [self.rightButtonsDataDic removeAllObjects];
    [self.rightButtonTagDic removeAllObjects];
    for (UIView *view in self.rightMenuButtonContainerView.subviews) {
        [view removeFromSuperview];
    }
    int tag = 90;
    int i = 0;
    DatabaseOption *dbo = [[DatabaseOption alloc] init];
    // 属性值
    NSArray *properties = [dbo getPropertyByTypeID:self.currentType.ttypeid];
    if (properties.count) {
        for (TproductProperty *property in properties) {
            // 数据整理
            NSArray *arr = [dbo getPropertyValueByPropertyID:property.propertyid];
            [self.rightButtonsDataDic setObject:arr forKey:[NSString stringWithFormat:@"%d", tag+i]];
            [self.rightButtonTagDic setObject:property.searchkey forKey:[NSString stringWithFormat:@"%d", tag+i]];
            // 加入button
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(320-RightButtonWidth*(i+1), 0, RightButtonWidth, 37)];
            button.tag = tag+i;
            [button setTitle:[NSString stringWithFormat:@"%@▼", property.name] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:15];
            [button addTarget:self action:@selector(rightButonClickedAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.rightMenuButtonContainerView addSubview:button];
            i++;
        }
    }
    
    // 子类别
    NSArray *subtypes = [dbo getSubtypesByTypeID:self.currentType.ttypeid];
    if (subtypes.count) {
        [self.rightButtonsDataDic setObject:subtypes forKey:[NSString stringWithFormat:@"%d", tag+i]];
        [self.rightButtonTagDic setObject:@"type3" forKey:[NSString stringWithFormat:@"%d", tag+i]];
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(320-RightButtonWidth*(i+1), 0, RightButtonWidth, 37)];
        button.tag = tag+i;
        [button setTitle:@"子类别▼" forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button addTarget:self action:@selector(rightButonClickedAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.rightMenuButtonContainerView addSubview:button];
        i++;
    }
    
    // 系列
    NSArray *suites;
    if (_asProductListType == CategoryType) {
        suites = [dbo getSuitesByTypeID:self.currentType.ttypeid];
    }else if (_asProductListType == SuiteType) {
        suites = nil;
    }else if (_asProductListType == SearchType) {
        suites = [dbo getSuitesByProductIDs:self.productIDs];
    }
    if (suites.count) {
        [self.rightButtonsDataDic setObject:suites forKey:[NSString stringWithFormat:@"%d", tag+i]];
        [self.rightButtonTagDic setObject:@"type2" forKey:[NSString stringWithFormat:@"%d", tag+i]];
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(320-RightButtonWidth*(i+1), 0, RightButtonWidth, 37)];
        button.tag = tag+i;
        [button setTitle:@"系列▼" forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button addTarget:self action:@selector(rightButonClickedAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.rightMenuButtonContainerView addSubview:button];
        i++;
    }
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

#pragma mark - override

/**
 *  覆盖属性方法 若无值 赋一个默认值 并返回
 *
 *  @return 界面的色调
 */
- (UIColor *)color{
    if (!_color) {
        _color = AS_DefatuleColor;
    }
    return _color;
}

- (NSMutableArray *)tempProductsArray {
    if (!_tempProductsArray) {
        _tempProductsArray = [NSMutableArray array];
    }
    return _tempProductsArray;
}

- (NSMutableDictionary *)rightButtonsDataDic {
    if (!_rightButtonsDataDic) {
        _rightButtonsDataDic = [NSMutableDictionary dictionary];
    }
    return _rightButtonsDataDic;
}

- (NSMutableDictionary *)rightButtonTagDic {
    if (!_rightButtonTagDic) {
        _rightButtonTagDic = [NSMutableDictionary dictionary];
    }
    return _rightButtonTagDic;
}

- (DownMenuViewController *)downMenuViewController {
    if (!_downMenuViewController) {
        _downMenuViewController = [[DownMenuViewController alloc] initWithNibName:@"DownMenuViewController" bundle:nil];
        _downMenuViewController.delegate = self;
    }
    return _downMenuViewController;
}

- (NSMutableArray *)leftDataArray {
    if (!_leftDataArray) {
        _leftDataArray = [NSMutableArray array];
    }
    return _leftDataArray;
}

- (NSMutableArray *)productIDs
{
    if (!_productIDs) {
        _productIDs = [NSMutableArray array];
    }
    return _productIDs;
}

#pragma mark - Init

- (void)initToolbar
{
    // 初始化toolbar
    self.toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 1024, 44)];
    
    if ([self.toolbar respondsToSelector:@selector(setBarTintColor:)])
    {
        [self.toolbar setBarTintColor:self.color];
    }
    
    // 绘制左边菜单按钮 UIbutton
    UIButton *leftMenuButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 6, 17, 15)];
    [leftMenuButton setBackgroundImage:[UIImage imageNamed:@"as_minamenu"] forState:UIControlStateNormal];
    [leftMenuButton addTarget:self action:@selector(leftButtonClickedAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftMenuButton];
    
    // 绘制ViewContorller视图名称视图 (UIView + UIlabel)
    UIView *titleBGView = [[UIView alloc] initWithFrame:CGRectMake(60, 6, 140, 33)];
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 140, 33)];
    self.titleLabel.backgroundColor = [UIColor clearColor];
    [self.titleLabel setTextColor:[UIColor whiteColor]];
    [self.titleLabel setFont:[UIFont boldSystemFontOfSize:19]];
    if (_asProductListType == SuiteType || _asProductListType == MtoType) {
        DatabaseOption *dbo = [[DatabaseOption alloc] init];
        Suites *suite = [dbo getSuiteBysuiteid:self.value];
        self.titleLabel.text = suite.name;
    }
    [titleBGView addSubview:self.titleLabel];
    UIBarButtonItem *titleBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:titleBGView];
    
    // 绘制右边button容器view
    self.rightMenuButtonContainerView = [[UIView alloc] initWithFrame:CGRectMake(688, 6, 320, 33)];
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightMenuButtonContainerView];
    
    // 绘制SpaceItem
    UIBarButtonItem * spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    // 添加绘制的控件到ToolBar
    self.toolbar.items = [NSArray arrayWithObjects:leftBarButtonItem, titleBarButtonItem, spaceItem, rightBarItem, nil];
    [self.view addSubview:self.toolbar];
}

- (void)initCollectionview
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumInteritemSpacing = 36;
    flowLayout.minimumLineSpacing = 36;
    flowLayout.itemSize = CGSizeMake(214, 280);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.sectionInset = UIEdgeInsetsMake(35, 30, 35, 30);
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 37, 1024, 667) collectionViewLayout:flowLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.pagingEnabled = YES;
    [self.collectionView registerNib:[UINib nibWithNibName:@"FolderDetailCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"FloderDetailCollectionViewCell"];
    [self.view addSubview:self.collectionView];
    
    self.matchup = [[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"CollectionViewHorizonMatchup" ofType:@"plist"]] objectForKey:@"8"];
}

/**
 *  左边菜单数据
 */
- (void)initLeftMenuData
{
    DatabaseOption *dbo = [[DatabaseOption alloc] init];
    if (_asProductListType == SearchType) {
        self.leftDataArray = [dbo getTypesByProductIDs:self.productIDs];
        self.currentType = nil;
    } else if (_asProductListType == CategoryType) {
        self.leftDataArray = [dbo brandType:@"2"];
        self.currentType = [dbo gettypeByTypeid:self.value];
    } else if (_asProductListType == SuiteType || _asProductListType == MtoType) {
        self.leftDataArray = [dbo getTypesBySuiteID:self.value];
        self.currentType = [dbo gettypeByTypeid:self.productTypeid];
    }
}

/**
 *  初始产品数据
 */
- (void)initProductData
{
    DatabaseOption *dbo = [[DatabaseOption alloc] init];
    if (_asProductListType == SearchType) {
        self.productIDs = [dbo productIDArrayByConditionSQL:[NSString stringWithFormat:@"select P.'id' from 'tproduct' AS P join 'ttype' AS T on P.'type1'=T.'id' left join 'tsubtype' AS ST on P.'type3'=ST.'id' left join 'suites' AS U on P.'type2'=U.'id' join 'tbrand' AS B on P.'brand'=B.'id' where ((P.'code' like '%%%@%%') or (T.'name' like '%%%@%%') or (ST.'name' like '%%%@%%') or (U.'name' like '%%%@%%') or (B.'name' like '%%%@%%')) and P.'brand'= '%@'", self.value, self.value, self.value, self.value, self.value, @"2"]];
        
        self.tempProductsArray = [dbo productArrayByProductIDArray:self.productIDs];
    } else if (_asProductListType == CategoryType) {
        self.tempProductsArray = [dbo selectProductsByType:@"type1" andValue:self.value];
    } else if (_asProductListType == SuiteType || _asProductListType == MtoType)
    {
        //如果进入套间并指定了产品大类
        if (self.productTypeid)
        {
            self.tempProductsArray = [dbo selectProductsByType:@"type2" andValue:self.value params:@{@"type1": @[self.productTypeid]}];
        }
        else
        {
            self.tempProductsArray = [dbo selectProductsByType:@"type2" andValue:self.value params:nil];
        }
        
    }
}

/**
 *  初始化右边菜单数据
 */
- (void)initRightMenuData
{
    [self updateRightMenuButton];
}

- (void)initPagecontrol
{
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(493, 672, 39, 37)];
    [self.view addSubview:self.pageControl];
    self.pageControl.numberOfPages = self.pageControl.numberOfPages = self.tempProductsArray.count%8==0 ? self.tempProductsArray.count/8 : self.tempProductsArray.count/8+1;
    [self.pageControl setCurrentPageIndicatorTintColor:self.color];
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
    
    [self initProductData];
    
    if (_asProductListType == SearchType && !self.productIDs.count) {
        [UIAlertView showWithTitle:@"无数据" message:@"没有此产品数据" cancelButtonTitle:@"确定" otherButtonTitles:nil tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
            [self.navigationController popViewControllerAnimated:NO];
        }];
        return;
    }
    
    [self initLeftMenuData];
    
    [self initToolbar];
    
    [self initCollectionview];
    
    [self initRightMenuData];
    
    [self initPagecontrol];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
