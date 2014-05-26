//
//  ExpandedViewController.m
//  LearnAppaginaTableView
//
//  Created by CY-004 on 13-11-19.
//  Copyright (c) 2013年 CY. All rights reserved.
//

#import "ExpandedViewController.h"
#import "FavoriteCell.h"
#import "LibraryAPI.h"
#import "DatabaseOption+Tfavorite.h"
#import "Category.h"
#import "ProductDetailView.h"
#import "LixilProductDetailView.h"
#import "InaxProductDetailView.h"

@interface ExpandedViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, DeleteCellProtocol>

@property BOOL isDelete;
@property (nonatomic, strong) UICollectionView *collectionVoew;
@property NSInteger count;
@property (nonatomic, strong) UITextView *textView;
@property CGRect originalContentViewFrame;

@end

@implementation ExpandedViewController

#pragma mark - Util

- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)unregisterForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - DeleteCellProtocol

- (void)deleteCell:(FavoriteCell *)cell
{
    NSIndexPath *indexPath = [self.collectionVoew indexPathForCell:cell];
    DatabaseOption *dbo = [[DatabaseOption alloc]init];
    int i = [dbo deleteProductByDateID:self.favorite.dateid andProductid:((TfavoriteDetail *)self.favorite.details[indexPath.row]).productid];
    if (i==1) {
        self.favorite.details = [dbo selectFavoriteDetailsByDateID:self.favorite.dateid];
        _count -= 1;
        [self.collectionVoew performBatchUpdates:^{
            [self.collectionVoew deleteItemsAtIndexPaths:[NSArray arrayWithObject:[_collectionVoew indexPathForCell:cell]]];
        }completion:^(BOOL finished) {
            if (finished) {
                [_collectionVoew reloadData];
            }
        }];
    } else {
        [UIAlertView showAlertViewWithTitle:@"删除失败" message:@"删除失败"];
    }
    if ([self.delegate respondsToSelector:@selector(expandedViewControllerCommentDidChange:)]) {
        [self.delegate expandedViewControllerCommentDidChange:self];
    }
}

#pragma mark - Handle Action

- (void)remarkButtonClicked:(id)sender
{
    if ([self.favorite.comment equals:self.textView.text]) {
        [UIAlertView showAlertViewWithTitle:@"失败" message:@"备注未修改"];
        return;
    }
    DatabaseOption *dbo = [[DatabaseOption alloc] init];
    if ([dbo updateRemark:self.textView.text byTfavoriteID:self.favorite.tfavoriteid]) {
        [UIAlertView showAlertViewWithTitle:@"成功" message:@"修改备注成功"];
        if ([self.delegate respondsToSelector:@selector(expandedViewControllerCommentDidChange:)]) {
            [self.delegate expandedViewControllerCommentDidChange:self];
        }
    }
}

- (void)deleteBegan:(UIButton *)sender
{
    if (_isDelete) {
        [sender setBackgroundImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
    } else {
        
        //根据品牌不同设置不同背景
        if ((![[LibraryAPI sharedInstance].currentBrandID isEqualToString:@"2"])&&(![[LibraryAPI sharedInstance].currentBrandID isEqualToString:@"3"])) //lixil
        {
           [sender setBackgroundImage:[UIImage imageNamed:@"lixil_delete-color"] forState:UIControlStateNormal];
        }
        else if ([[LibraryAPI sharedInstance].currentBrandID isEqualToString:@"3"]) //inax
        {
            [sender setBackgroundImage:[UIImage imageNamed:@"inax_delete-color"] forState:UIControlStateNormal];
        }
        else
        {
            [sender setBackgroundImage:[UIImage imageNamed:@"delete-color"] forState:UIControlStateNormal];
        }
        
    }
    _isDelete = !_isDelete;
    [_collectionVoew reloadData];
}

- (void)keyboardWasShow:(NSNotification *)notification
{
    self.originalContentViewFrame = self.textView.frame;
    // 取得键盘的frame
    CGRect endRect = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGPoint endOrigin = endRect.origin;
    // 把键盘的frame坐标系转换到与UITextView一致的父view上来
    if ([UIApplication sharedApplication].keyWindow && self.textView.superview) {
        endOrigin = [self.textView.superview convertPoint:endRect.origin fromView:[UIApplication sharedApplication].keyWindow];
    }
    CGFloat adjustHeight = self.originalContentViewFrame.origin.y + self.originalContentViewFrame.size.height;
    adjustHeight -= endOrigin.y;
    if (adjustHeight > 0) {
        CGRect newRect = self.originalContentViewFrame;
        newRect.origin.y -= adjustHeight;
        [UIView animateWithDuration:0.3 animations:^{
            self.textView.frame = newRect;
        }];
    }
}

- (void)keyboardWillBeHidden:(NSNotification *)notification
{
    [UIView animateWithDuration:0.3 animations:^{
        self.textView.frame = self.originalContentViewFrame;
    }];
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.isDelete) {
        TfavoriteDetail *detail = (TfavoriteDetail *)self.favorite.details[indexPath.row];
        
        //根据品牌不同设置不同背景
        if ((![[LibraryAPI sharedInstance].currentBrandID isEqualToString:@"2"])&&(![[LibraryAPI sharedInstance].currentBrandID isEqualToString:@"3"])) //lixil
        {
            LixilProductDetailView *detailView = [[LixilProductDetailView alloc]init];
            detailView.productid = detail.productid;
            [self.navigationController pushViewController:detailView animated:NO];
        }
        else if ([[LibraryAPI sharedInstance].currentBrandID isEqualToString:@"3"]) //inax
        {
            InaxProductDetailView *detailView = [[InaxProductDetailView alloc]init];
            detailView.productid = detail.productid;
            [self.navigationController pushViewController:detailView animated:NO];
        }
        else
        {
            ProductDetailView *detailView = [[ProductDetailView alloc]init];
            detailView.productid = detail.productid;
            [self.navigationController pushViewController:detailView animated:NO];
        }
        
    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.favorite.details.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FavoriteCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.imageView.image = [[LibraryAPI sharedInstance] getImageFromPath:((TfavoriteDetail *)self.favorite.details[indexPath.row]).productimg scale:16];
    cell.deleteBtn.hidden = !_isDelete;
    cell.delegate = self;
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(80.f, 80.f);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10.f;
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
	// Do any additional setup after loading the view.
    _isDelete = NO;
    _count = 50;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 735, 748)];
    // 添加 label控件显示哪一天
    UILabel *day = [[UILabel alloc] initWithFrame:CGRectMake(4, 200, 40, 20)];
    day.text = [NSString stringWithFormat:@"%@日", self.favorite.day];
    
    //根据品牌不同设置不同背景
    if ((![[LibraryAPI sharedInstance].currentBrandID isEqualToString:@"2"])&&(![[LibraryAPI sharedInstance].currentBrandID isEqualToString:@"3"])) //lixil
    {
        day.textColor = [UIColor orangeColor];
    }
    else if ([[LibraryAPI sharedInstance].currentBrandID isEqualToString:@"3"]) //inax
    {
        day.textColor = [UIColor colorWithRed:0/255. green:128/255. blue:220/255. alpha:1.];
    }
    else
    {
        day.textColor = [UIColor colorWithRed:184/255. green:156/255. blue:101/255. alpha:1.];
    }
    
    day.textAlignment = NSTextAlignmentCenter;
    day.font = [UIFont systemFontOfSize:15.f];
    day.backgroundColor = [UIColor clearColor];
    // 添加贯穿视图的黑线
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(54, 0, 6, 748)];
    lineView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"line"]];
    // 添加黑圆结点
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(47, 200, 20, 20)];
    
    //根据品牌不同设置不同背景
    if ((![[LibraryAPI sharedInstance].currentBrandID isEqualToString:@"2"])&&(![[LibraryAPI sharedInstance].currentBrandID isEqualToString:@"3"])) //lixil
    {
        imageView.image = [UIImage imageNamed:@"lixil_cycle_orange"];
    }
    else if ([[LibraryAPI sharedInstance].currentBrandID isEqualToString:@"3"]) //inax
    {
        imageView.image = [UIImage imageNamed:@"inax_cycle_orange"];
    }
    else
    {
        imageView.image = [UIImage imageNamed:@"cycle_orange"];
    }
    
    imageView.backgroundColor = [UIColor clearColor];
    // 添加箭头
    UIImageView *arrowView = [[UIImageView alloc] initWithFrame:CGRectMake(70, 195, 17, 30)];
    arrowView.image = [UIImage imageNamed:@"arrow_black"];
    imageView.backgroundColor = [UIColor clearColor];
    // 添加内容视图
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(87, 30, 685, 450)];
    contentView.backgroundColor = [UIColor clearColor];
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:(CGRect){.origin=CGPointMake(0, 0), .size=contentView.frame.size}];
    bgView.image = [[UIImage imageNamed:@"bg_black"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [contentView addSubview:bgView];
    // 日期显示
    UILabel *data = [[UILabel alloc] initWithFrame:CGRectMake(27, 5, 50, 30)];
    NSRange range;
    range.location = 4;
    range.length = 2;
    data.text = [NSString stringWithFormat:@"%@年%@月%@日", [self.favorite.dateid substringToIndex:4],
                 [self.favorite.dateid substringWithRange:range],[self.favorite.dateid substringFromIndex:6]];
    data.textColor = [UIColor whiteColor];
    data.backgroundColor = [UIColor clearColor];
    [data sizeToFit];
    [contentView addSubview:data];
    // 添加删除收藏图片操作
    UIButton *deleteBegan = [[UIButton alloc] initWithFrame:CGRectMake(572, 5, 25, 21)];
    deleteBegan.backgroundColor = [UIColor clearColor];
    [deleteBegan setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
    [deleteBegan addTarget:self action:@selector(deleteBegan:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:deleteBegan];
    // 收藏图片显示
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(27, 40, 570, 250) collectionViewLayout:[[UICollectionViewFlowLayout alloc]init]];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    _collectionVoew = collectionView;
    [collectionView registerClass:[FavoriteCell class] forCellWithReuseIdentifier:@"cell"];
    [contentView addSubview:collectionView];
    // 备注
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(27, 295, 570, 70)];
    textView.font = [UIFont systemFontOfSize:15.f];
    textView.backgroundColor = [UIColor whiteColor];
    textView.text = self.favorite.comment;
    self.textView = textView;
    [contentView addSubview:textView];
    // 确定备注按钮
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(499, 370, 100, 44)];
    [button setTitle:@"修改备注" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(remarkButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    //根据品牌不同设置不同背景
    if ((![[LibraryAPI sharedInstance].currentBrandID isEqualToString:@"2"])&&(![[LibraryAPI sharedInstance].currentBrandID isEqualToString:@"3"])) //lixil
    {
        button.backgroundColor = [UIColor colorWithRed:230/255. green:87/255. blue:7/255. alpha:1.];
    }
    else if ([[LibraryAPI sharedInstance].currentBrandID isEqualToString:@"3"]) //inax
    {
        button.backgroundColor = [UIColor colorWithRed:0/255. green:128/255. blue:220/255. alpha:1.];
    }
    else
    {
        button.backgroundColor = [UIColor colorWithRed:184/255. green:156/255. blue:101/255. alpha:1.];
    }
    
    [contentView addSubview:button];
    
    [view addSubview:day];
    [view addSubview:lineView];
    [view addSubview:arrowView];
    [view addSubview:imageView];
    [view addSubview:contentView];
    
    [self.view addSubview:view];
    
    [self registerForKeyboardNotifications];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [self unregisterForKeyboardNotifications];
}

@end
