//
//  EcocaratNewProductsViewController.m
//  ShowCasePro
//
//  Created by Mac on 14-4-2.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "EcocaratNewProductsViewController.h"
#import "LixilProductDetailView.h"

#define ImageName       @"ImageName"
#define ProductID       @"ProductID"

#define ImageViewTag    10086


#define Animation_Duration_Scroll   0.1

#define Section0_Scroll_Set         10
#define Section1_Scroll_Set         5
#define Section2_Scroll_Set         10

@interface EcocaratNewProductsViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    __weak IBOutlet UITableView *tableViewLeft;
    __weak IBOutlet UITableView *tableViewCenter;
    __weak IBOutlet UITableView *tableViewRight;
    
    float section0Height;  //实际所有cell的高度之和
    float section1Height;
    float section2Height;
}

@property (nonatomic , strong) NSArray *dataLeft;
@property (nonatomic , strong) NSArray *dataCenter;
@property (nonatomic , strong) NSArray *dataRight;

@property (nonatomic , strong) NSTimer *scrollTimer;

@end

@implementation EcocaratNewProductsViewController


#pragma mark - scroll method-

- (void) scrollMethod
{
    CGPoint section0_contentOffSet = tableViewLeft.contentOffset;
    CGPoint section1_contentOffSet = tableViewCenter.contentOffset;
    CGPoint section2_contentOffSet = tableViewRight.contentOffset;
    
    section0_contentOffSet.y += Section0_Scroll_Set;
    section1_contentOffSet.y += Section1_Scroll_Set;
    section2_contentOffSet.y += Section2_Scroll_Set;
    
    [tableViewLeft setContentOffset:section0_contentOffSet animated:YES];
    [tableViewCenter setContentOffset:section1_contentOffSet animated:YES];
    [tableViewRight setContentOffset:section2_contentOffSet animated:YES];
    
    
    if (section0_contentOffSet.y >= section0Height*6)
    {
        section0_contentOffSet.y = section0Height;
        [tableViewLeft setContentOffset:section0_contentOffSet animated:NO];
    }
    
    if (section1_contentOffSet.y >= section1Height*6)
    {
        section1_contentOffSet.y = section1Height;
        [tableViewCenter setContentOffset:section1_contentOffSet animated:NO];
    }
    
    if (section2_contentOffSet.y >= section2Height*6)
    {
        section2_contentOffSet.y = section2Height;
        [tableViewRight setContentOffset:section2_contentOffSet animated:NO];
    }
    
}


#pragma mark - delegate -

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = nil;
    
    if (tableView == tableViewLeft)
    {
        int index = indexPath.row % self.dataLeft.count;
        dic = [self.dataLeft objectAtIndex:index];
    }
    else if (tableView == tableViewCenter)
    {
        int index = indexPath.row % self.dataCenter.count;
        dic = [self.dataCenter objectAtIndex:index];
    }
    else
    {
        int index = indexPath.row % self.dataRight.count;
        dic = [self.dataRight objectAtIndex:index];
    }
    
    NSString *productID = [dic objectForKey:ProductID];
    
    LixilProductDetailView *lpdv = [LixilProductDetailView new];
    lpdv.productid = productID;
    [self.navigationController pushViewController:lpdv animated:NO];
}


#pragma mark - data source -

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifer = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300, 100)];
        imageView.tag = ImageViewTag;
        [cell addSubview:imageView];
    }
    
    NSDictionary *dic = nil;
    
    if (tableView == tableViewLeft)
    {
        int index = indexPath.row % self.dataLeft.count;
        dic = [self.dataLeft objectAtIndex:index];
    }
    else if (tableView == tableViewCenter)
    {
        int index = indexPath.row % self.dataCenter.count;
        dic = [self.dataCenter objectAtIndex:index];
    }
    else
    {
        int index = indexPath.row % self.dataRight.count;
        dic = [self.dataRight objectAtIndex:index];
    }
    
    UIImage *image = [UIImage imageNamed:[dic objectForKey:ImageName]];
    
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:ImageViewTag];
    imageView.frame = CGRectMake(0, 0, image.size.width/2, image.size.height/2);
    imageView.image = image;
    
    cell.frame = CGRectMake(0, 0, image.size.width/2, image.size.height/2 + 10);
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 99;
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
    
    for (int i = 0; i < self.dataLeft.count; i++)
    {
        UITableViewCell *cell = [self tableView:tableViewLeft cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        height0 += cell.frame.size.height;
    }
    
    section0Height = height0;
    
    /////
    float height1 = 0;
    
    for (int i = 0; i < self.dataCenter.count; i++)
    {
        UITableViewCell *cell = [self tableView:tableViewCenter cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        height1 += cell.frame.size.height;
    }
    
    section1Height = height1;
    
    /////
    float height2 = 0;
    
    for (int i = 0; i < self.dataRight.count; i++)
    {
        UITableViewCell *cell = [self tableView:tableViewRight cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        height2 += cell.frame.size.height;
    }
    
    section2Height = height2;
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
    
    self.dataLeft = [NSArray arrayWithObjects:
                     [self dictionaryWithImageName:@"ecocarat_np_lengying" andProductID:@"1421"],
                     [self dictionaryWithImageName:@"ecocarat_np_yayan" andProductID:@"1417"],
                     nil];
    
    self.dataCenter = [NSArray arrayWithObjects:
                       [self dictionaryWithImageName:@"ecocarat_np_zhumie" andProductID:@"1422"],
                                                                                            //yanshi ,1423
                        nil];
                       
    self.dataRight = [NSArray arrayWithObjects:
                       [self dictionaryWithImageName:@"ecocarat_np_bolang" andProductID:@"1418"],
                       [self dictionaryWithImageName:@"ecocarat_np_zhizhun" andProductID:@"1419"],
                       [self dictionaryWithImageName:@"ecocarat_np_luoxiu" andProductID:@"1420"],
                        nil];
    
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

- (NSDictionary *)dictionaryWithImageName:(NSString *)imageName andProductID:(NSString *)productID
{
    return [NSDictionary dictionaryWithObjects:@[imageName,productID] forKeys:@[ImageName,ProductID]];
}

@end
