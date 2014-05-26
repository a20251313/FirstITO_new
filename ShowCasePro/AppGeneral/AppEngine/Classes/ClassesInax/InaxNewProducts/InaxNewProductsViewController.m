//
//  InaxNewProductsViewController.m
//  ShowCasePro
//
//  Created by Mac on 14-3-18.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "InaxNewProductsViewController.h"
#import "InaxNewProduct.h"
#import "InaxNewProductCell.h"
#import "DatabaseOption+InaxNewProduct.h"
#import "DatabaseOption+condition.h"
#import "InaxNewProductListViewController.h"

#define Animation_Duration_Scroll   0.1

#define Section0_Scroll_Set         10
#define Section1_Scroll_Set         5
#define Section2_Scroll_Set         10


@interface InaxNewProductsViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    __weak IBOutlet UITableView *section0;
    __weak IBOutlet UITableView *section1;
    __weak IBOutlet UITableView *section2;
    
    
    float section0Height;  //实际所有cell的高度之和
    float section1Height;
    float section2Height;
    
    
}

@property (nonatomic , strong) DatabaseOption *dbo;

@property (nonatomic , strong) NSDictionary *inaxNewProductDictionary;

@property (nonatomic , strong) NSArray *section0Data;
@property (nonatomic , strong) NSArray *section1Data;
@property (nonatomic , strong) NSArray *section2Data;


@property (nonatomic , strong) NSTimer *scrollTimer;

@end

@implementation InaxNewProductsViewController



#pragma mark - scroll method-

- (void) scrollMethod
{
    CGPoint section0_contentOffSet = section0.contentOffset;
    CGPoint section1_contentOffSet = section1.contentOffset;
    CGPoint section2_contentOffSet = section2.contentOffset;
    
    section0_contentOffSet.y += Section0_Scroll_Set;
    section1_contentOffSet.y += Section1_Scroll_Set;
    section2_contentOffSet.y += Section2_Scroll_Set;
    
    [section0 setContentOffset:section0_contentOffSet animated:YES];
    [section1 setContentOffset:section1_contentOffSet animated:YES];
    [section2 setContentOffset:section2_contentOffSet animated:YES];
    
    
    if (section0_contentOffSet.y >= section0Height*6)
    {
        section0_contentOffSet.y = section0Height;
        [section0 setContentOffset:section0_contentOffSet animated:NO];
    }
    
    if (section1_contentOffSet.y >= section1Height*6)
    {
        section1_contentOffSet.y = section1Height;
        [section1 setContentOffset:section1_contentOffSet animated:NO];
    }
    
    if (section2_contentOffSet.y >= section2Height*6)
    {
        section2_contentOffSet.y = section2Height;
        [section2 setContentOffset:section2_contentOffSet animated:NO];
    }
    
}


#pragma mark - delegate -

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int section = 0;
    int row = 0;
     InaxNewProduct *inaxNewProduct = nil;
    InaxNewProductListViewController *listController = [InaxNewProductListViewController new];
    if (tableView == section0)
    {
        section = 0;
        row = indexPath.row % self.section0Data.count;
        inaxNewProduct = [self.section0Data objectAtIndex:row];
        NSString *sql =[NSString stringWithFormat:@"select * from tproduct where type1 = %@ and type3 = %@ and brand = 3 and param31 = 1",inaxNewProduct.type_id,inaxNewProduct.subtypeid];
        
       listController.productsArray = [self.dbo productArrayByConditionSQL:sql];

        [self.navigationController pushViewController:listController animated:NO];
        
    }
    else if (tableView == section1)
    {
        section = 1;
        row = indexPath.row % self.section1Data.count;
        inaxNewProduct = [self.section1Data objectAtIndex:row];
        NSString *sql = nil;
        if([inaxNewProduct.suiteid intValue] == 22)
        {
             sql =[NSString stringWithFormat:@"select * from tproduct where type2 = %@ and brand = 3 and param31 = 1",inaxNewProduct.suiteid];
        }
        else
        {
         sql =[NSString stringWithFormat:@"select * from tproduct where type1 = %@ and type3 = %@ and brand = 3 and param31 = 1",inaxNewProduct.type_id,inaxNewProduct.subtypeid];
        }
        
        listController.productsArray = [self.dbo productArrayByConditionSQL:sql];
        [self.navigationController pushViewController:listController animated:NO];
    }
    else
    {
        section = 2;
        row = indexPath.row % self.section2Data.count;
        inaxNewProduct = [self.section2Data objectAtIndex:row];
        NSString *sql =[NSString stringWithFormat:@"select * from tproduct where type1 = %@ and type3 = %@ and brand = 3 and param31 = 1",inaxNewProduct.type_id,inaxNewProduct.subtypeid];
        
        listController.productsArray = [self.dbo productArrayByConditionSQL:sql];
        [self.navigationController pushViewController:listController animated:NO];
    }
    
    NSLog(@"did select section : %d  row : %d",section,row);
}


#pragma mark - data source -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.section0Data.count*self.section1Data.count*self.section2Data.count*2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    InaxNewProduct *inaxNewProduct = nil;
    
    if (tableView == section0)
    {
        int index = indexPath.row % self.section0Data.count;
        
        if (index < self.section0Data.count)
        {
            inaxNewProduct = [self.section0Data objectAtIndex:index];
        }
        else
        {
            NSLog(@"error : InaxNewProductsViewController : 数组越界");
        }
    }
    else if (tableView == section1)
    {
        int index = indexPath.row % self.section1Data.count;
        
        if (index < self.section1Data.count)
        {
            inaxNewProduct = [self.section1Data objectAtIndex:index];
        }
        else
        {
            NSLog(@"error : InaxNewProductsViewController : 数组越界");
        }
    }
    else
    {
        int index = indexPath.row % self.section2Data.count;
        
        if (index < self.section2Data.count)
        {
            inaxNewProduct = [self.section2Data objectAtIndex:index];
        }
        else
        {
            NSLog(@"error : InaxNewProductsViewController : 数组越界");
        }
    }
    
    
    static NSString *identifier = @"InaxNewProductCell";
    
    InaxNewProductCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell)
    {
        cell = [[InaxNewProductCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.frame = CGRectMake(0, 0, tableView.frame.size.width, cell.frame.size.height);
    
    [cell showWithProduct:inaxNewProduct];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    InaxNewProductCell *cell =  (InaxNewProductCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    return cell.frame.size.height;
}


#pragma mark - view did appear -

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self computeTableCellHeightCount];
}

- (void) computeTableCellHeightCount
{
    /////
    float height0 = 0;
    
    for (int i = 0; i < self.section0Data.count; i++)
    {
        UITableViewCell *cell = [self tableView:section0 cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        height0 += cell.frame.size.height;
    }
    
    section0Height = height0;
    
    /////
    float height1 = 0;
    
    for (int i = 0; i < self.section1Data.count; i++)
    {
        UITableViewCell *cell = [self tableView:section1 cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        height1 += cell.frame.size.height;
    }
    
    section1Height = height1;
    
    /////
    float height2 = 0;
    
    for (int i = 0; i < self.section2Data.count; i++)
    {
        UITableViewCell *cell = [self tableView:section2 cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        height2 += cell.frame.size.height;
    }
    
    section2Height = height2;
}


#pragma mark - lift cycle -

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
    
    self.inaxNewProductDictionary = [self.dbo inaxNewProductDictionary];
    
    if (!self.inaxNewProductDictionary)
    {
        return;
    }
    
    self.section0Data = [self.inaxNewProductDictionary objectForKey:Section_0];
    self.section1Data = [self.inaxNewProductDictionary objectForKey:Section_1];
    self.section2Data = [self.inaxNewProductDictionary objectForKey:Section_2];
    
    
    self.scrollTimer = [NSTimer scheduledTimerWithTimeInterval:Animation_Duration_Scroll
                                                        target:self
                                                      selector:@selector(scrollMethod)
                                                      userInfo:nil
                                                       repeats:YES];
    [self.scrollTimer fire];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
