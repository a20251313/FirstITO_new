//
//  ASProductListView.m
//  ShowCasePro
//
//  Created by yczx on 14-2-27.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "ASProductListView.h"
#import "LibraryAPI.h"


#import "DatabaseOption+Suites.h"
#import "DatabaseOption+Tproduct.h"
#import "DatabaseOption+Tsubtype.h"
#import "DatabaseOption+Ttype.h"
#import "DatabaseOption+TproductProperty.h"
#import "DatabaseOption+TproductPropertyValue.h"
#import "ProductDetailView.h"

#import "Ttype.h"
#import "Tsubtype.h"
#import "Suites.h"
#import "Tproduct.h"
#import "TproductProperty.h"
#import "TproductPropertyValue.h"

#define kFolderName 1
#define kFolderCode 2
#define kFolderImageView 3
#define kfolderEn 4



@interface ASProductListView ()<UICollectionViewDataSource,UICollectionViewDelegate,UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *productCollectionView;

// 产品列表数集合
@property (nonatomic, strong) NSMutableArray *productList;

// 品牌大类别数据集合
@property (nonatomic, strong) NSMutableArray *brandTypeList;

// 品牌下系列数据集合
@property (nonatomic, strong) NSMutableArray *brandSuiteList;


@property (nonatomic, strong) NSDictionary *matchup;

// pageControl
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

// 查询组合搜索数据集合
@property (nonatomic, strong) NSMutableArray *searchConList;



@end

@implementation ASProductListView

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
    //self.productTypeID = @"19";
    
    if (self.suiteColor)
    {
        //[self.ViewToolBarControl setBarStyle:UIBarStyleDefault];
        [self.ViewToolBarControl setBarTintColor:self.suiteColor];
        
        
    }
    
    _searchConList = [NSMutableArray array];
    
    [self.productCollectionView registerNib:[UINib nibWithNibName:@"FolderDetailCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"FloderDetailCollectionViewCell"];
    
    
    self.matchup = [[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"CollectionViewHorizonMatchup" ofType:@"plist"]] objectForKey:@"8"];

    
    // 加载当前品牌品类数据
    DatabaseOption *dbo = [[DatabaseOption alloc] init];
    _brandTypeList = [dbo brandType:[[LibraryAPI sharedInstance] currentBrandID]];
    NSMutableArray *list = [NSMutableArray array];
    // 加载品类数据到下拉菜单
    if (_brandTypeList){
        for (Ttype * obj in _brandTypeList) {
        
            if (obj){
                
                [list addObject:[obj name]];
            }
        }
        
        [self.leftSubItems addObject:list];
        
    }
    
    // 左边菜单数据
    //NSDictionary *mainDict = @{@"name":@"菜 单",@"searchkey":@"type1",@"image":@""};
    
    
    [self.leftMainItems addObject:@"菜 单"];
 
    
    [self makeRigthMenuItemBySelTypeID:_productTypeID];

    // 显示当前空间名称
    if (_brandSuiteList.count >0 && _suiteID)
    {
        for (NSObject *obj in _brandSuiteList) {
            NSDictionary *dict = (NSDictionary *)obj;
            if ([[dict objectForKey:@"id"] isEqualToString:_suiteID])
            {
                self.ViewControllerTitleLabel.text = [dict objectForKey:@"name"];
                break;
            }
            
        }
    }
    
    
    _productList = [self getProductDataByTypeID:_productTypeID];
 
    self.pageControl.numberOfPages = self.productList.count%8==0 ? self.productList.count/8 : self.productList.count/8+1;
    
}

// 根据当选择的产品大类生成右边菜单数据
-(void)makeRigthMenuItemBySelTypeID:(NSString *)typeID
{
   
    DatabaseOption *dbo = [[DatabaseOption alloc] init];
    [self.rightMainItems removeAllObjects];
    [self.rightSubItems removeAllObjects];
    
    // 获得当前品牌下系列数据
    NSDictionary *suitDict = @{@"name":@"系列",@"searchkey":@"type2"};
    
    [self.rightMainItems addObject:suitDict];
    _brandSuiteList = [dbo getSuitesDictByBrandID:[[LibraryAPI sharedInstance] currentBrandID]];
    [self addMenuNameTorightSubMenu:_brandSuiteList];
    
    
    // 根据产品类别初始化子属性菜单
    if (typeID)
    {
        // 获得品类下子类别
        NSDictionary *suitDict = @{@"name":@"子类别",@"searchkey":@"type3"};
        
        [self.rightMainItems addObject:suitDict];
        NSMutableArray *subTypeList = [dbo getSubtypesDictByTypeID:typeID];
        [self addMenuNameTorightSubMenu:subTypeList];
        
        // 添加字搜索属性
        NSMutableArray *properList = [dbo getPropertyByTypeID:typeID];
        
        for (NSObject *obj in properList) {
            
            TproductProperty *property = (TproductProperty *)obj;
            
            NSDictionary *suitDict = @{@"name":property.name,@"searchkey":property.searchkey};
            
            [self.rightMainItems addObject:suitDict];
            
            // 加载子属性对应的值
            NSMutableArray *subPropertyList = [dbo getPropertyValueDictByPropertyID:property.propertyid];
            if (subPropertyList)
            {
                [self addMenuNameTorightSubMenu:subPropertyList];
            }
            
        }
        
    //    NSLog( @"rightMainItems is %@",self.rightMainItems);
        
    //    NSLog( @"rightSubItems is %@",self.rightSubItems);
        
    }
    
}


// 添加右边菜单数据
-(void)addMenuNameTorightSubMenu:(NSMutableArray *)list
{
   if (list.count >0)
   {
       
           NSMutableArray *itemList = [NSMutableArray array];
           for (NSObject *obj in list) {
                NSMutableDictionary *type = (NSMutableDictionary *)obj;
               [itemList addObject:type];//[type objectForKey:@"name"]
               
           }
       
           [self.rightSubItems addObject:itemList];
       
   }
}

// 根据当前的产品ID 查询产品
-(NSMutableArray *)getProductDataByTypeID:(NSString *)typeID
{
    NSMutableArray *array;
    DatabaseOption *dbo = [[DatabaseOption alloc] init];
    array = [dbo selectProductsByType:@"type1" andValue:typeID];
    return array;
}



#pragma mark - RTFlyoutMenuDataSource

- (NSUInteger)numberOfMainItemsInFlyoutMenu:(RTFlyoutMenu *)flyoutMenu {
   
    if (flyoutMenu.menuTag == RTlyoutMenuMianTag)
    {
     	return [self.leftMainItems count];
    } else {
        return [self.rightMainItems count];
    }
    
}

- (NSString *)flyoutMenu:(RTFlyoutMenu *)flyoutMenu titleForMainItem:(NSUInteger)mainItemIndex {
    
    if (flyoutMenu.menuTag == RTlyoutMenuMianTag)
    {
        if (mainItemIndex >= [self.leftMainItems count]) return nil;
        
        return [self.leftMainItems objectAtIndex:mainItemIndex];

    } else {
        if (mainItemIndex >= [self.rightMainItems count]) return nil;
        
        return [[self.rightMainItems objectAtIndex:mainItemIndex] objectForKey:@"name"];
    }
    
	}

- (NSUInteger)flyoutMenu:(RTFlyoutMenu *)flyoutMenu numberOfItemsInSubmenu:(NSUInteger)mainItemIndex {
    
    if (flyoutMenu.menuTag == RTlyoutMenuMianTag)
    {
        if (mainItemIndex >= [self.leftMainItems count]) return 0;
        
     //    NSLog(@"rightSubItems is %d",[[self.leftSubItems objectAtIndex:mainItemIndex] count]);
        return [[self.leftSubItems objectAtIndex:mainItemIndex] count];
    } else {
       	if (mainItemIndex >= [self.rightMainItems count]) return 0;
        
        return [[self.rightSubItems objectAtIndex:mainItemIndex] count];
    }
    
}

- (NSString *)flyoutMenu:(RTFlyoutMenu *)flyoutMenu titleForSubItem:(NSUInteger)subItemIndex inMainItem:(NSUInteger)mainItemIndex {

    if (flyoutMenu.menuTag == RTlyoutMenuMianTag)
    {
        if (mainItemIndex >= [self.leftMainItems count]) return nil;
        if (subItemIndex >= [[self.leftSubItems objectAtIndex:mainItemIndex] count]) return nil;
        
       // NSLog(@"rightSubItems is %@",[[self.leftSubItems objectAtIndex:mainItemIndex] objectAtIndex:subItemIndex]);
        
        return [[self.leftSubItems objectAtIndex:mainItemIndex] objectAtIndex:subItemIndex];
        
    } else {
        if (mainItemIndex >= [self.rightMainItems count]) return nil;
        if (subItemIndex >= [[self.rightSubItems objectAtIndex:mainItemIndex] count]) return nil;
        
       // NSLog(@"rightSubItems is %@",[[self.rightSubItems objectAtIndex:mainItemIndex] objectAtIndex:subItemIndex]);
        
        return [[[self.rightSubItems objectAtIndex:mainItemIndex] objectAtIndex:subItemIndex] objectForKey:@"name"];
    }
    
    
}


#pragma mark - RTFlyoutMenuDelegate

- (void)flyoutMenu:(RTFlyoutMenu *)flyoutMenu didSelectMainItemWithIndex:(NSInteger)index {
    NSLog(@"Tap on main item: %d", index);

    //添加模糊视图控制界面操作
//    UIView *view = [[UIView alloc] initWithFrame:self.view.frame];
//    [view setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3]];
//    [self.view addSubview:view];
//    [self.view bringSubviewToFront:self.RightMenuView];
    
}

- (void)flyoutMenu:(RTFlyoutMenu *)flyoutMenu didSelectSubItemWithIndex:(NSInteger)subIndex mainMenuItemIndex:(NSInteger)mainIndex {
    NSLog(@"Tap on main/sub index: %d / %d", mainIndex, subIndex);
   
    if (subIndex == -2) return;
    // 在这里添加选中菜单项目后的执行事件
    if (flyoutMenu.menuTag == RTlyoutMenuMianTag)
    {
        [self execulteLeftMenutItemClickWithMainIndex:mainIndex andSubIndex:subIndex];
        
    } else
    {
        [self execulteRightMenutItemClickWithMainIndex:mainIndex andSubIndex:subIndex];
    }

    
}

- (void)didReloadFlyoutMenu:(RTFlyoutMenu *)flyoutMenu
{
    // 初始化右边菜单
    [self initRTFlayoutMenuToView:self.RightMenuView withTag:RTlyoutMenuRightTag WithColor:self.suiteColor];
    
}


// 执行左边菜单的点击事件
-(void)execulteLeftMenutItemClickWithMainIndex:(NSInteger)mainIndex andSubIndex:(NSInteger)subIndex
{
    
    Ttype *itemType = (Ttype *)[self.brandTypeList objectAtIndex:subIndex];
    
    DatabaseOption *dbo = [[DatabaseOption alloc] init];
    _productList = [dbo selectProductsByType:@"type1" andValue:[itemType ttypeid]];
    self.pageControl.numberOfPages = self.productList.count%8==0 ? self.productList.count/8 : self.productList.count/8+1;
    
    
    NSDictionary *typeDict = @{@"key" :@"type1",@"values":[itemType ttypeid]};
    [_searchConList removeAllObjects];
    [_searchConList addObject:typeDict];
    
    [self.productCollectionView reloadData];
    
    // 重新加载菜单数据
    [self makeRigthMenuItemBySelTypeID:[itemType ttypeid]];
    
    //[self.flyoutMenu reset];
    [self.flyoutMenu reloadData];
}


// 执行右边菜单的点击事件
-(void)execulteRightMenutItemClickWithMainIndex:(NSInteger)mainIndex andSubIndex:(NSInteger)subIndex
{
    
//    Ttype *itemType = (Ttype *)[self.brandTypeList objectAtIndex:subIndex];
//    
//    DatabaseOption *dbo = [[DatabaseOption alloc] init];
//    _productList = [dbo selectProductsByType:@"type1" andValue:[itemType ttypeid]];
//    
//    [self.productCollectionView reloadData];
//    
// 组合查询条件
    NSString *searchKey = [[self.rightMainItems objectAtIndex:mainIndex] objectForKey:@"searchkey"];

    NSString *searchValue;
    if (mainIndex == 0 || mainIndex == 1)
    {
       searchValue = [[[self.rightSubItems objectAtIndex:mainIndex] objectAtIndex:subIndex] objectForKey:@"id"];
    } else
    {
       searchValue = [[[self.rightSubItems objectAtIndex:mainIndex] objectAtIndex:subIndex] objectForKey:@"name"];
    }
    
    NSDictionary *searchDict = @{@"key" :searchKey,@"values":searchValue};
    
    if(![self checkListExistItem:searchDict with:_searchConList])
    {
        [_searchConList addObject:searchDict];
    } else
    {
        [_searchConList addObject:searchDict];
    }
    
    DatabaseOption *dbo = [[DatabaseOption alloc] init];
    _productList = [dbo selectProductByparams:_searchConList];
 
    self.pageControl.numberOfPages = self.productList.count%8==0 ? self.productList.count/8 : self.productList.count/8+1;
    
    [self.productCollectionView reloadData];
    
}


-(BOOL)checkListExistItem:(NSDictionary *)dict with:(NSMutableArray *)list
{
    for (NSDictionary *obj in list) {
        
        if ([[obj objectForKey:@"key"] isEqualToString:[dict objectForKey:@"key"]])
        {
            [list removeObject:obj];
            return YES;
        }
    }
    
    return NO;
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGPoint offset = scrollView.contentOffset;
    self.pageControl.currentPage = offset.x/1018;
}


#pragma mark --UICollectionViewDelegate

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = 0;
    
    row = [(NSString *)self.matchup[[NSString stringWithFormat:@"%d", indexPath.row]] integerValue];
    
    NSInteger index = indexPath.section*8+row;
    
    Tproduct *product = (Tproduct *)[self.productList objectAtIndex:index];
    
    ProductDetailView *detailView = [[ProductDetailView alloc]init];
    detailView.productid = product.productid;
//    detailView.allProductData = _productList;
    [self.navigationController pushViewController:detailView animated:NO];
    
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.productList.count%8==0 ? self.productList.count/8 : self.productList.count/8+1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 8;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = 0;
    
    row = [(NSString *)self.matchup[[NSString stringWithFormat:@"%d", indexPath.row]] integerValue];
    
    NSInteger index = indexPath.section*8+row;
    
    UICollectionViewCell *cell = (UICollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"FloderDetailCollectionViewCell" forIndexPath:indexPath];

    if (index < self.productList.count)
    {
        cell.hidden = NO;
        
        Tproduct *product = (Tproduct *)[self.productList objectAtIndex:index];
        
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

//删除字符串最后的空白
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

@end
