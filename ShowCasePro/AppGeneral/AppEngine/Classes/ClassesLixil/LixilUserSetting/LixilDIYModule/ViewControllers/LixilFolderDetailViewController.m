//
//  FolderDetailViewController.m
//  ShowCasePro
//
//  Created by lvpw on 13-11-28.
//  Copyright (c) 2013年 yczx. All rights reserved.
//
#define kFolderCode 4

#import "LixilFolderDetailViewController.h"
#import "LixilErWeiMaViewController.h"

#import "MacroDefine.h"
#import "Tdiydetail.h"
#import "DatabaseOption+DIYFolder.h"
#import "Category.h"
#import "LibraryAPI.h"

#import "LixilProductDetailView.h"

@interface LixilFolderDetailViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSArray *tDIYDetails;

@end

@implementation LixilFolderDetailViewController

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    Tdiydetail *diyDetail = [self.tDIYDetails objectAtIndex:indexPath.row];
    LixilProductDetailView *detailView = [[LixilProductDetailView alloc]init];
    detailView.productid = diyDetail.productid;
    [self.navigationController pushViewController:detailView animated:NO];
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(214, 218);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 30.f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 30.f;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(40, 30, 40, 30);
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.tDIYDetails count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LixilFloderDetailCollectionViewCell" forIndexPath:indexPath];
    ((UIImageView *)[cell viewWithTag:3]).image = nil;
    Tdiydetail *diyDetail = [self.tDIYDetails objectAtIndex:indexPath.row];
    /**
     * scale image on background thread before displaying it to prevent lag
     */
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 获取图片
        UIImage *endImage = [[LibraryAPI sharedInstance]getImageFromPath:diyDetail.product.image1 scale:4];
        dispatch_async(dispatch_get_main_queue(), ^{
            ((UIImageView *)[cell viewWithTag:3]).image = endImage;
        });
    });
    //    ((UIImageView *)[cell viewWithTag:kFolderImageView]).image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@", kDocuments, diyDetail.productimage]];
    ((UILabel *)[cell viewWithTag:kFolderCode]).text = diyDetail.product.code;
    
    cell.layer.shadowPath = [UIBezierPath bezierPathWithRect:cell.bounds].CGPath;
    cell.layer.shadowColor = [UIColor blackColor].CGColor;
    cell.layer.shadowOffset = CGSizeMake(0, 8);
    cell.layer.shadowRadius = 15;
    cell.layer.shadowOpacity = 1;
    return cell;
}

#pragma mark - Init

- (void)initFolderDetail
{
    DatabaseOption *dbo = [[DatabaseOption alloc] init];
    self.tDIYDetails = [dbo selectAllFolderDetailsByFolderID:self.folderid];
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
    // 初始化数据
    [self initFolderDetail];
    
    self.folderName.text = self.foldername;
    
    [self.folderDetailCollectionView registerNib:[UINib nibWithNibName:@"LixilFolderDetailCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"LixilFloderDetailCollectionViewCell"];
    self.navigationController.navigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)erweimashare:(id)sender {
//    NSString *temp = @"{\"details\":[{\"productcode\":\"YBCT1500YQ(裙边、附溢水口)\",\"productimage\":\"data/productimage/YBCT1500YQ.png\",\"productname\":\"理想石浴缸\",\"floderid\":\"2\",\"update_time\":null,\"productid\":\"175\",\"version\":null}],\"foldername\":\"商务风格\",\"userid\":null,\"update_time\":null,\"cretae_date\":null,\"version\":null}";
    DatabaseOption *dbo = [[DatabaseOption alloc] init];
    NSString *str = [dbo selectShareStringByFolderID:self.folderid];
    NSLog(@"%@", str);
    LixilErWeiMaViewController *erWeiMaViewController = [[LixilErWeiMaViewController alloc] initWithNibName:@"LixilErWeiMaViewController" bundle:nil];
    erWeiMaViewController.erweimaString = str;
//    NSLog(@"%d",str.length);
    [self.navigationController pushViewController:erWeiMaViewController animated:NO];
//    if ([dbo insertFolderByShareString:temp]) {
//        [UIAlertView showAlertViewWithTitle:@"成功" message:@"插入成功"];
//    };
}
@end
