//
//  InaxNewProductListViewController.m
//  ShowCasePro
//
//  Created by CY-003 on 14-5-6.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "InaxNewProductListViewController.h"
#import "InaxProductDetailView.h"
#define Collection_Cell_Identifier      @"InaxNewProductsList"
#define Collection_Cell_ImageView_Tag   11
#define Collection_Cell_Lable_Tag       22
@interface InaxNewProductListViewController ()

@end

@implementation InaxNewProductListViewController
{
    __weak IBOutlet UICollectionView *inaxCollection;
    
    
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
   inaxCollection.dataSource = self;
    inaxCollection.delegate = self;
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake((1024-5*5)/4.0,221)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowLayout.sectionInset = UIEdgeInsetsMake(6, 6, 6, 6);
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 5;
    [flowLayout setHeaderReferenceSize:CGSizeMake(0,0)];
    [flowLayout setFooterReferenceSize:CGSizeMake(0, 0)];
    [inaxCollection setCollectionViewLayout:flowLayout];

    [inaxCollection registerNib:[UINib nibWithNibName:@"InaxNewProductListCell" bundle:nil] forCellWithReuseIdentifier:Collection_Cell_Identifier];
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = (UICollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:Collection_Cell_Identifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
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
        
       // productCode.text  = [self deleteSpaceString:product.code];
        
        productCode.text = [self IndexOfContainingString:@" " FromString:product.code];
        
    } else
    {
        cell.hidden = YES;
    }
    
    return cell;

    
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row >= self.productsArray.count)
    {
        NSLog(@"error : collectionView:didSelectItemAtIndexPath: 数组越界.");
        return;
    }
    
    Tproduct *product = [self.productsArray objectAtIndex:indexPath.row];
    
    //NSLog(@"product name : %@",product.name);
    
    InaxProductDetailView *pdv = [InaxProductDetailView new];
    pdv.productid = product.productid;
    
    [self.navigationController pushViewController:pdv animated:NO];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.productsArray) {
        return self.productsArray.count;
    }
    
    return 0;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSString*)IndexOfContainingString:(NSString *)findment FromString:(NSString *)scrString

{
    NSString *scr = scrString;
    NSRange range = [scrString rangeOfString:findment];
   
    NSUInteger location = range.location;
    if(location != NSNotFound){
    NSString *sub = [scrString substringToIndex:location];
    return sub;
    }
    return scr;
    
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
