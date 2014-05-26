//
//  InaxSearchViewController.m
//  ShowCasePro
//
//  Created by yczx on 14-4-14.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "InaxSearchViewController.h"
#import "InaxProductDetailView.h"
#import "Tproduct.h"
#import "DatabaseOption+condition.h"
#import "NSObject+RuntimeMethods.h"

#define Collection_Cell_Identifier      @"InaxShowProductsCell"
#define Collection_Cell_ImageView_Tag   11
#define Collection_Cell_Lable_Tag       22

@interface InaxSearchViewController ()
{
    IBOutlet UICollectionView *searchCollectionView;
}

@property (nonatomic , strong) NSArray *dataArray;

@property (nonatomic , strong) DatabaseOption *dbo;

@end

@implementation InaxSearchViewController

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
    return self.dataArray.count;
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
    
    InaxProductDetailView *pdv = [InaxProductDetailView new];
    pdv.productid = product.productid;
    
    [self.navigationController pushViewController:pdv animated:NO];
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

- (void)reloadData
{
    if (self.searchKeyWord)
    {
//        NSArray *productIDArray = [self.dbo productIDArrayByConditionSQL:[NSString stringWithFormat:@"select P.'id' from 'tproduct' AS P join 'ttype' AS T on P.'type1'=T.'id' left join 'tsubtype' AS ST on P.'type3'=ST.'id' left join 'suites' AS U on P.'type2'=U.'id' join 'tbrand' AS B on P.'brand'=B.'id' where ((P.'code' like '%%%@%%') or (T.'name' like '%%%@%%') or (ST.'name' like '%%%@%%') or (U.'name' like '%%%@%%') or (B.'name' like '%%%@%%')) and P.'brand'= '%@' and param31 = 1", self.searchKeyWord, self.searchKeyWord, self.searchKeyWord, self.searchKeyWord, self.searchKeyWord, @"3"]];
        
        
        NSString    *tempCode = [NSString stringWithFormat:@"%%%@%%",self.searchKeyWord];
          NSArray *productIDArray = [self.dbo productIDArrayByConditionSQL:[NSString stringWithFormat:@"select P.'id' from 'tproduct' AS P join 'ttype' AS T on P.'type1'=T.'id' left join 'tsubtype' AS ST on P.'type3'=ST.'id' left join 'suites' AS U on P.'type2'=U.'id' join 'tbrand' AS B on P.'brand'=B.'id' where ((P.'code' like '%@') or (T.'name' like '%@') or (ST.'name' like '%@') or (U.'name' like '%@') or (B.'name' like '%@')) and P.'brand'= '%@' and param31 = 1", tempCode, tempCode, tempCode,tempCode,tempCode, @"3"]];
        
        self.dataArray = [self.dbo productArrayByProductIDArray:productIDArray];
        
       // NSMutableArray  *arrayProduct = [NSMutableArray array];
    
        NSPredicate *pre = [NSPredicate predicateWithFormat:@"self.name contains %@ or self.code contains %@",self.searchKeyWord,self.searchKeyWord];
        self.dataArray = [self.dataArray filteredArrayUsingPredicate:pre];
        /*
        for (Tproduct *object in self.dataArray)
        {
            NSPredicate *pre = [NSPredicate predicateWithFormat:@"sele.name contains %@ or self.code contains %@",self.searchKeyWord];
            NSRange range = [object.name rangeOfString:self.searchKeyWord];
            if (range.location != NSNotFound)
            {
                [arrayProduct addObject:object];
                continue;
            }
            range = [object.code rangeOfString:self.searchKeyWord];
            if (range.location != NSNotFound)
            {
                [arrayProduct addObject:object];
               // continue;
            }
            debugLog(@"\n***********************************************\n");
            [self getdescriptionOfobject:object];
            debugLog(@"\n***********************************************\n");
        }
        
        self.dataArray = [NSArray arrayWithArray:arrayProduct];*/
        [searchCollectionView reloadData];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [searchCollectionView registerNib:[UINib nibWithNibName:@"InaxShowProductsCell" bundle:nil] forCellWithReuseIdentifier:@"InaxShowProductsCell"];
    
    self.dbo = [DatabaseOption new];
    
    [self reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

@end
