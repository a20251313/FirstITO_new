//
//  SashShowProductsViewController.m
//  ShowCasePro
//
//  Created by Mac on 14-4-8.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "SashShowProductsViewController.h"
#import "DatabaseOption+condition.h"
#import "LixilProductDetailView.h"
#import "Tproduct.h"

#define Collection_Cell_Identifier      @"InaxShowProductsCell"

#define Collection_Cell_ImageView_Tag   11
#define Collection_Cell_Lable_Tag       22

@interface SashShowProductsViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    IBOutlet UICollectionView *productsCollectionView;
}

@property (nonatomic , strong) DatabaseOption *dbo;

@property (nonatomic , strong) NSArray *dataArray;

@end

@implementation SashShowProductsViewController

#pragma mark - collection view data source -

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = (UICollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:Collection_Cell_Identifier forIndexPath:indexPath];
    
    if (indexPath.row < self.dataArray.count)
    {
        cell.hidden = NO;
        
        Tproduct *product = (Tproduct *)[self.dataArray objectAtIndex:indexPath.row];
        
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
        
        productCode.text  = [self deleteSpaceString:product.code];
        
    } else
    {
        cell.hidden = YES;
    }
    
    return cell;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.dataArray) {
        return self.dataArray.count;
    }
    
    return 0;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

#pragma mark - collection view delegate -

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row >= self.dataArray.count)
    {
        NSLog(@"error : collectionView:didSelectItemAtIndexPath: 数组越界.");
        return;
    }
    
    Tproduct *product = [self.dataArray objectAtIndex:indexPath.row];
    
    //NSLog(@"product name : %@",product.name);
    
    LixilProductDetailView *pdv = [LixilProductDetailView new];
    pdv.productid = product.productid;
    
    [self.navigationController pushViewController:pdv animated:NO];
}

#pragma mark - button event -

- (IBAction)taSeriesButtonEvent
{
    //type3 = 139   ta
    //type3 = 140   td
    
    NSString *sql = @"select * from tproduct where param31 = 1 and type3 = 139";
    [self reloadDataWithSql:sql];
}

- (IBAction)tdSeriesButtonEvent
{
    //type3 = 139   ta
    //type3 = 140   td
    
    NSString *sql = @"select * from tproduct where param31 = 1 and type3 = 140";
    [self reloadDataWithSql:sql];
}

- (void) reloadDataWithSql:(NSString *)sql
{
    self.dataArray = [self.dbo productArrayByConditionSQL:sql];
    
    if (self.dataArray)
    {
        [productsCollectionView reloadData];
        productsCollectionView.hidden = NO;
    }
    else
    {
        productsCollectionView.hidden = YES;
    }
}

#pragma mark - life cycle -

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
    
    productsCollectionView.hidden = YES;
    
    [productsCollectionView registerNib:[UINib nibWithNibName:@"InaxShowProductsCell" bundle:nil] forCellWithReuseIdentifier:Collection_Cell_Identifier];
    
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

@end
