//
//  LixilWoodenSuitesCollectionViewController.m
//  ShowCasePro
//
//  Created by Mac on 14-3-27.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "LixilWoodenSuitesCollectionViewController.h"
#import "InaxSuiteCollection.h"
#import "DatabaseOption+InaxSuiteCollection.h"
#import "HVTableView.h"
#import "WoodenSuitesCollectionSubViewController.h"

#define Inax_Suites_Collection_Cell_Height          137
#define Inax_Suites_Collection_Cell_Height_Expand   274
#define Inax_Suites_Collection_Cell_Offset          57
#define Inax_Suites_Collection_Cell_Center          130


#define Inax_Suites_Collection_Cell_Bg_Tag          12306
#define Inax_Suites_Collection_Cell_Des_Tag         12580
#define Inax_Suites_Collection_Cell_Detail_Tag      10086


#define Inax_Suites_Collection_Animation_Duration   0.5

@interface LixilWoodenSuitesCollectionViewController ()<HVTableViewDataSource,HVTableViewDelegate>
{
    HVTableView *suiteCollectionTableView;
}

@property (nonatomic , strong) DatabaseOption *dbo;

@property (nonatomic , strong) NSArray *dataArray;

@property (nonatomic , assign) int selectedIndex;

@end

@implementation LixilWoodenSuitesCollectionViewController


#pragma mark - data source -

//perform your expand stuff (may include animation) for cell here. It will be called when the user touches a cell
-(void)tableView:(UITableView *)tableView expandCell:(UITableViewCell *)cell withIndexPath:(NSIndexPath *)indexPath
{
    UIImageView *desImageView       = (UIImageView *)[cell viewWithTag:Inax_Suites_Collection_Cell_Des_Tag];
    UIImageView *detailImageView    = (UIImageView *)[cell viewWithTag:Inax_Suites_Collection_Cell_Detail_Tag];
    
    UIImage *desImage = desImageView.image;
    UIImage *detailImage = detailImageView.image;
    
    desImageView.bounds = CGRectMake(0, 0, desImage.size.width/2, desImage.size.height/2);
    detailImageView.bounds = CGRectMake(0, 0, detailImage.size.width/2, detailImage.size.height/2);
    
    [UIView animateWithDuration:Inax_Suites_Collection_Animation_Duration animations:^
     {
         desImageView.center = CGPointMake(Inax_Suites_Collection_Cell_Offset + desImageView.frame.size.width/2, -desImageView.frame.size.height/2);
         detailImageView.center = CGPointMake(Inax_Suites_Collection_Cell_Center, Inax_Suites_Collection_Cell_Height_Expand/2);
         
         desImageView.alpha = 0;
         detailImageView.alpha = 1;
     }];
    
    self.selectedIndex = indexPath.row;
}

-(void)tableView:(UITableView *)tableView collapseCell:(UITableViewCell *)cell withIndexPath:(NSIndexPath *)indexPath
{
    UIImageView *desImageView       = (UIImageView *)[cell viewWithTag:Inax_Suites_Collection_Cell_Des_Tag];
    UIImageView *detailImageView    = (UIImageView *)[cell viewWithTag:Inax_Suites_Collection_Cell_Detail_Tag];
    
    UIImage *desImage = desImageView.image;
    UIImage *detailImage = detailImageView.image;
    
    desImageView.bounds = CGRectMake(0, 0, desImage.size.width/2, desImage.size.height/2);
    detailImageView.bounds = CGRectMake(0, 0, detailImage.size.width/2, detailImage.size.height/2);
    
    [UIView animateWithDuration:Inax_Suites_Collection_Animation_Duration animations:^
     {
         desImageView.center = CGPointMake(Inax_Suites_Collection_Cell_Offset + desImageView.frame.size.width/2, Inax_Suites_Collection_Cell_Height/2);
         detailImageView.center = CGPointMake(-detailImageView.frame.size.width/2, Inax_Suites_Collection_Cell_Height_Expand/2);
         
         desImageView.alpha = 1;
         detailImageView.alpha = 0;
     }];
    
    [self performSelector:@selector(pushToSubViewcontroller:) withObject:[NSString stringWithFormat:@"%d",indexPath.row] afterDelay:0.2];
}

- (void) pushToSubViewcontroller:(NSString *)indexString
{
    int index = [indexString intValue];
    
    if (self.selectedIndex == index)
    {
        //进入次级界面
        WoodenSuitesCollectionSubViewController *wscsc = [WoodenSuitesCollectionSubViewController new];
        wscsc.selectedIndex = index;
        wscsc.dataArray = self.dataArray;
        [self.navigationController pushViewController:wscsc animated:NO];
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath isExpanded:(BOOL)isexpanded
{
	if (isexpanded)
		return Inax_Suites_Collection_Cell_Height_Expand;
	
	return Inax_Suites_Collection_Cell_Height;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath isExpanded:(BOOL)isExpanded
{
	static NSString *CellIdentifier = @"Inax_Suties_Collection_Cell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    InaxSuiteCollection *suiteCollection = [self.dataArray objectAtIndex:indexPath.row];
    
    NSString *bgImagePath = suiteCollection.bg_image;
    UIImage *bgImage = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",kLibrary,bgImagePath]];
    
    NSString *desImagePath = suiteCollection.des_image;
    UIImage *desImage = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",kLibrary,desImagePath]];
    
    NSString *detailImagePath = suiteCollection.detail_image;
    UIImage *detailImage = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",kLibrary,detailImagePath]];
    
	if (!cell)
	{
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
		UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1024, Inax_Suites_Collection_Cell_Height_Expand)];
		imageView.image = bgImage;
        imageView.tag = Inax_Suites_Collection_Cell_Bg_Tag;
		[cell.contentView addSubview:imageView];
        
        UIImageView *desImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, desImage.size.width/2, desImage.size.height/2)];
        desImageView.image = desImage;
        desImageView.center = CGPointMake(Inax_Suites_Collection_Cell_Offset + desImageView.frame.size.width/2, Inax_Suites_Collection_Cell_Height/2);
        desImageView.tag = Inax_Suites_Collection_Cell_Des_Tag;
        [cell.contentView addSubview:desImageView];
        
        UIImageView *detailImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, detailImage.size.width/2, detailImage.size.height/2)];
        detailImageView.image = desImage;
        detailImageView.center = CGPointMake(-detailImageView.frame.size.width/2, Inax_Suites_Collection_Cell_Height_Expand/2);
        detailImageView.tag = Inax_Suites_Collection_Cell_Detail_Tag;
        [cell.contentView addSubview:detailImageView];
	}
	
    UIImageView *imageView          = (UIImageView *)[cell viewWithTag:Inax_Suites_Collection_Cell_Bg_Tag];
    UIImageView *desImageView       = (UIImageView *)[cell viewWithTag:Inax_Suites_Collection_Cell_Des_Tag];
    UIImageView *detailImageView    = (UIImageView *)[cell viewWithTag:Inax_Suites_Collection_Cell_Detail_Tag];
    
    desImageView.bounds = CGRectMake(0, 0, desImage.size.width/2, desImage.size.height/2);
    detailImageView.bounds = CGRectMake(0, 0, detailImage.size.width/2, detailImage.size.height/2);
    
	if (!isExpanded) //prepare the cell as if it was collapsed! (without any animation!)
	{
		imageView.image             = bgImage;
        desImageView.image          = desImage;
        detailImageView.image       = detailImage;
        
        desImageView.center = CGPointMake(Inax_Suites_Collection_Cell_Offset + desImageView.frame.size.width/2, Inax_Suites_Collection_Cell_Height/2);
        detailImageView.center = CGPointMake(-detailImageView.frame.size.width/2, Inax_Suites_Collection_Cell_Height_Expand/2);
	}
	else ///prepare the cell as if it was expanded! (without any animation!)
	{
		imageView.image             = bgImage;
        desImageView.image          = desImage;
        detailImageView.image       = detailImage;
        
        desImageView.center = CGPointMake(Inax_Suites_Collection_Cell_Offset + desImageView.frame.size.width/2, -desImageView.frame.size.height/2);
        detailImageView.center = CGPointMake(Inax_Suites_Collection_Cell_Center, Inax_Suites_Collection_Cell_Height_Expand/2);
    }
    
	return cell;
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
    
    self.dataArray = [self.dbo inaxSuiteCollectionArray];
    
    suiteCollectionTableView = [[HVTableView alloc] initWithFrame:CGRectMake(0, 85, 1024, 685) expandOnlyOneCell:YES enableAutoScroll:YES];
    suiteCollectionTableView.HVTableViewDelegate = self;
    suiteCollectionTableView.HVTableViewDataSource = self;
    suiteCollectionTableView.separatorColor = [UIColor blackColor];
    suiteCollectionTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    suiteCollectionTableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    suiteCollectionTableView.bounces = NO;
    suiteCollectionTableView.tableFooterView = [UIView new];
    [suiteCollectionTableView reloadData];
    
    //i dont know why , but if not do this ,there will happen sth. looks strange
    suiteCollectionTableView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0);
    
    [self.view addSubview:suiteCollectionTableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
