//
//  FindersViewController.m
//  InsertFinderDemo
//
//  Created by CY-004 on 13-11-18.
//  Copyright (c) 2013年 CY. All rights reserved.
//

#import "FindersViewController.h"
#import "FinderCell.h"
#import "Category.h"
#import "FolderDetailViewController.h"
#import "DatabaseOption+DIYFolder.h"
#import "Tdiyfolder.h"
#import "LixilFolderDetailViewController.h"
#import "InaxFolderDetailViewController.h"

@interface FindersViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIAlertViewDelegate, FinderCellDelegate>

@property BOOL isEdit;

@property (nonatomic, strong) NSIndexPath *operatCellIndexPath;

@end

@implementation FindersViewController

#pragma mark - Util

- (NSString *)currentTime
{
    NSDate * newDate = [NSDate date];
    NSDateFormatter *dateformat=[[NSDateFormatter alloc] init];
    [dateformat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString * newDateOne = [dateformat stringFromDate:newDate];
    return newDateOne;
}

#pragma mark - FinderCellDelegate

- (void)editFinderCellLabel:(FinderCell *)finderCell
{
    _operatCellIndexPath = [self.collectionView indexPathForCell:finderCell];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"修改风格名称" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag = 2;
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert textFieldAtIndex:0].text = finderCell.folderNameView.text;
    [alert show];
}

- (void)deleteFinderCell:(FinderCell *)finderCell
{
    _operatCellIndexPath = [self.collectionView indexPathForCell:finderCell];
    [UIAlertView showWithTitle:@"删除风格" message:@"确定要删除吗？" cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
        // 删除
        if (buttonIndex == 1) {
            DatabaseOption *dbo = [[DatabaseOption alloc] init];
            if ([dbo deleteFolderByFolderID:((Tdiyfolder *)[self.folders objectAtIndex:self.operatCellIndexPath.row]).tdiyfolderid]) {
                // 若成功，刷新页面数据
                [self initFolders];
                [self.collectionView performBatchUpdates:^{
                    [self.collectionView deleteItemsAtIndexPaths:[NSArray arrayWithObject:_operatCellIndexPath]];
                }completion:^(BOOL finished){
                    if (finished) {
                        _isEdit = NO;
                        [self.collectionView reloadData];
                        [UIAlertView showAlertViewWithTitle:@"成功" message:@"删除文件夹成功"];
                    }
                }];
            }
        } else if (buttonIndex == 0){
            _isEdit = NO;
            [self.collectionView reloadData];
        }
    }];
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    // 确定
    if (buttonIndex == 1) {
        if (alertView.tag == 1) {
            // 添加文件夹
            NSString *floderName = [alertView textFieldAtIndex:0].text;
            // 封装diyfolder
            Tdiyfolder *diyfolder = [[Tdiyfolder alloc]initWithfoldername:floderName userid:@"" cretae_date:[self currentTime] update_time:@"" version:@""];
            // 执行插入数据
            DatabaseOption *dbo = [[DatabaseOption alloc] init];
            if ([dbo insertFolder:diyfolder]) {
                // 若成功，刷新页面数据
                [self initFolders];
                [self.collectionView performBatchUpdates:^{
                    [self.collectionView insertItemsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForItem:(_folders.count - 1) inSection:0]]];
                }completion:nil];
            }
        } else if (alertView.tag == 2){
            // 修改名称
            DatabaseOption *dbo = [[DatabaseOption alloc] init];
            if ([dbo updateFolderName:[alertView textFieldAtIndex:0].text
                           ByFolderID:((Tdiyfolder *)[self.folders objectAtIndex:self.operatCellIndexPath.row]).tdiyfolderid]) {
                // 若成功，刷新页面数据
                [self initFolders];
                [self.collectionView performBatchUpdates:^{
                    [self.collectionView reloadItemsAtIndexPaths:[NSArray arrayWithObject:_operatCellIndexPath]];
                }completion:^(BOOL finished){
                    _isEdit = NO;
                    [self.collectionView reloadData];
                }];
            }
        }
    } else if (buttonIndex == 0 && alertView.tag == 2){
        _isEdit = NO;
        [self.collectionView reloadData];
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 50.f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 50.f;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(100, 100);//CGSizeMake(70, 40)
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(30, 10, 20, 10);
}

#pragma mark - UICollectionViewDataSource & UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _folders.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FinderCell *cell = nil;
    if (indexPath.row == (_folders.count)) {
//        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FolderCell" forIndexPath:indexPath];
//        cell.folderImageView.image = [UIImage imageNamed:@"store"];
//        cell.folderNameView.text = @"";
//        cell.rightButton.hidden = YES;
//        cell.leftButton.hidden = YES;
    } else {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FolderCell" forIndexPath:indexPath];
        
        //根据品牌不同设置不同背景
        if ((![[LibraryAPI sharedInstance].currentBrandID isEqualToString:@"2"])&&(![[LibraryAPI sharedInstance].currentBrandID isEqualToString:@"3"])) //lixil
        {
            cell.folderImageView.image = [UIImage imageNamed:@"lixil_diy_folder"];
        }
        else if ([[LibraryAPI sharedInstance].currentBrandID isEqualToString:@"3"]) //inax
        {
            cell.folderImageView.image = [UIImage imageNamed:@"inax_diy_folder"];
            [cell.leftButton setImage:[UIImage imageNamed:@"inax_diy_delete"] forState:UIControlStateNormal];
        }
        else
        {
            cell.folderImageView.image = [UIImage imageNamed:@"diy_folder"];
        }
        
        cell.folderNameView.text = ((Tdiyfolder *)[_folders objectAtIndex:indexPath.row]).foldername;
        if (_isEdit) {
            cell.rightButton.hidden = NO;
            cell.leftButton.hidden = NO;
            cell.delegate = self;
        } else {
            cell.rightButton.hidden = YES;
            cell.leftButton.hidden = YES;
            cell.delegate = nil;
        }
    }
    return cell;
}

#pragma mark - Handel Action

- (void)handleTapGesture:(UITapGestureRecognizer *)recognizer
{
    if (_isEdit) return;
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        CGPoint initialPinchPoint = [recognizer locationInView:self.collectionView];
        NSIndexPath *tappedCellPath = [self.collectionView indexPathForItemAtPoint:initialPinchPoint];
        if (tappedCellPath != nil) {
            if (tappedCellPath.row == (_folders.count)) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"风格类型" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                alert.tag = 1;
                alert.alertViewStyle = UIAlertViewStylePlainTextInput;
                [self.view addSubview:alert];
                [alert show];
            } else {
                
                //根据品牌不同设置不同背景
                if ((![[LibraryAPI sharedInstance].currentBrandID isEqualToString:@"2"])&&(![[LibraryAPI sharedInstance].currentBrandID isEqualToString:@"3"])) //lixil
                {
                    LixilFolderDetailViewController *folderDetailViewController = [[LixilFolderDetailViewController alloc]initWithNibName:@"LixilFolderDetailViewController" bundle:nil];
                    folderDetailViewController.folderid = ((Tdiyfolder *)[_folders objectAtIndex:tappedCellPath.row]).tdiyfolderid;
                    folderDetailViewController.foldername = ((Tdiyfolder *)[_folders objectAtIndex:tappedCellPath.row]).foldername;
                    [self.navigationController pushViewController:folderDetailViewController animated:NO];
                }
                else if ([[LibraryAPI sharedInstance].currentBrandID isEqualToString:@"3"]) //inax
                {
                    InaxFolderDetailViewController *folderDetailViewController = [[InaxFolderDetailViewController alloc]initWithNibName:@"InaxFolderDetailViewController" bundle:nil];
                    folderDetailViewController.folderid = ((Tdiyfolder *)[_folders objectAtIndex:tappedCellPath.row]).tdiyfolderid;
                    folderDetailViewController.foldername = ((Tdiyfolder *)[_folders objectAtIndex:tappedCellPath.row]).foldername;
                    [self.navigationController pushViewController:folderDetailViewController animated:NO];
                }
                else
                {
                    FolderDetailViewController *folderDetailViewController = [[FolderDetailViewController alloc]initWithNibName:@"FolderDetailViewController" bundle:nil];
                    folderDetailViewController.folderid = ((Tdiyfolder *)[_folders objectAtIndex:tappedCellPath.row]).tdiyfolderid;
                    folderDetailViewController.foldername = ((Tdiyfolder *)[_folders objectAtIndex:tappedCellPath.row]).foldername;
                    [self.navigationController pushViewController:folderDetailViewController animated:NO];
                }

            }
        }
    }
}

- (void)addAction:(id)sender{
    if (_isEdit) return;
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"风格类型" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag = 1;
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [self.view addSubview:alert];
    [alert show];
}

- (void)editAction:(id)sender{
    [self LongPressGestureRecognizer:nil];
}

- (void)LongPressGestureRecognizer:(UIGestureRecognizer *)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateEnded || recognizer == nil) {
        if (_isEdit) {
            _isEdit = NO;
        } else {
            _isEdit = YES;
        }
        [self.collectionView reloadData];
    }
}

#pragma mark - Init

- (void)initFolders
{
    DatabaseOption *dbo = [[DatabaseOption alloc] init];
    self.folders = [dbo selectAllFolders];
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
    [self initFolders];
    _isEdit = NO;
    // 注册FolderCell
    [self.collectionView registerClass:[FinderCell class] forCellWithReuseIdentifier:@"FolderCell"];
    // 点击手势
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    [self.collectionView addGestureRecognizer:tapRecognizer];
    
    // 长按手势
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(LongPressGestureRecognizer:)];
    [self.collectionView addGestureRecognizer:lpgr];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
