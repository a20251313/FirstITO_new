//
//  ASShowProduct.m
//  ASShowProductTest
//
//  Created by Mac on 14-3-1.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import "ASShowProduct.h"
#import "SCHCircleView.h"
#import "viewCell.h"
#import "ASProductListView.h"
#import "ASProductListViewController.h"

#define Product_Image               @"image"
#define Product_Image_Selected      @"image-s"

@interface ASShowProduct ()<SCHCircleViewDataSource,SCHCircleViewDelegate>
{
    
    __weak IBOutlet UIButton *mtoButton;
}

@property (nonatomic , strong) SCHCircleView *circleView;

@property (nonatomic , strong) NSArray *dataArray;

@property (nonatomic , strong) NSMutableArray *cellArray;//存放所有cell的数组

@end

@implementation ASShowProduct


#pragma mark - delegate -

- (IBAction)toMtoVIew:(id)sender {
      NSLog(@"mto");
    ASProductListViewController *plc = [[ASProductListViewController alloc] initWithNibName:@"ASProductListViewController" bundle:nil];
    plc->_asProductListType = MtoType;
    plc.value = @"213";         //mto产品在suites表里的id是213
    //plc.productTypeid = nil;    //可选进入是淋浴房或者浴室家具
    [self.navigationController pushViewController:plc animated:NO];
  
}




-(void)animationBegin
{
    for (viewCell *cell in self.cellArray)
    {
        int index = [self.cellArray indexOfObject:cell];
        
        NSDictionary *dic = [self.dataArray objectAtIndex:index];
        
        UIImage *selectedImage = [UIImage imageNamed:[dic objectForKey:Product_Image]];
        
        cell.bounds = CGRectMake(0, 0, selectedImage.size.width/2, selectedImage.size.height/2);
        
        cell.image_view.image = selectedImage;
    }
}

-(void)animationEnd
{
    [self animationBegin];
    
    viewCell *cell = [self findFrontCell];
    
    int index = [self.cellArray indexOfObject:cell];
    
    NSDictionary *dic = [self.dataArray objectAtIndex:index];
    
    UIImage *selectedImage = [UIImage imageNamed:[dic objectForKey:Product_Image_Selected]];
    
    cell.bounds = CGRectMake(0, 0, selectedImage.size.width/2, selectedImage.size.height/2);
    
    cell.image_view.image = selectedImage;
    
}

-(void)dragBeginCircleViewCell:(SCHCircleViewCell *)cell indexOfCircleViewCell:(NSInteger)index
{
    [self animationBegin];
}

-(void)touchEndCircleViewCell:(SCHCircleViewCell *)cell indexOfCircleViewCell:(NSInteger)index
{
    if (cell == [self findFrontCell])
    {
        //viewCell *c = (viewCell *)cell;
        
        //ProductType *type = c.productType;
        
        //NSLog(@"type : %@",type.typeID);
        
        int index = [self.cellArray indexOfObject:cell];
        
        ASProductListView *plv = [ASProductListView new];
        
        ASProductListViewController *asproductListViewController = [[ASProductListViewController alloc] initWithNibName:@"ASProductListViewController" bundle:nil];
        asproductListViewController->_asProductListType = CategoryType;
        
        switch (index) {
            case 0:
            {
                plv.productTypeID = @"22";
                asproductListViewController.value= @"22";
            }
                break;
            case 1:
            {
                plv.productTypeID = @"23";
                asproductListViewController.value= @"23";
            }
                break;
            case 2:
            {
                plv.productTypeID = @"27";
                asproductListViewController.value= @"27";
            }
                break;
            case 3:
            {
                plv.productTypeID = @"26";
                asproductListViewController.value= @"26";
            }
                break;
            case 4:
            {
                plv.productTypeID = @"24";
                asproductListViewController.value= @"24";
            }
                break;
            case 5:
            {
                plv.productTypeID = @"29";
                asproductListViewController.value= @"29";
            }
                break;
            case 6:
            {
                plv.productTypeID = @"28";
                asproductListViewController.value= @"28";
            }
                break;
            case 7:
            {
                plv.productTypeID = @"20";
                asproductListViewController.value= @"20";
            }
                break;
            case 8:
            {
                plv.productTypeID = @"19";
                asproductListViewController.value= @"19";
            }
                break;
            case 9:
            {
                plv.productTypeID = @"25";
                asproductListViewController.value= @"25";
            }
                break;
            default:
                break;
        }
        
        [self.navigationController pushViewController:asproductListViewController animated:NO];
    }
}

- (viewCell *)findFrontCell
{
    viewCell *cell = [self.cellArray firstObject];
    
    for (viewCell *c in self.cellArray)
    {
        if (c.center.y > cell.center.y)
        {
            cell = c;
        }
    }
    
    return cell;
}

#pragma mark - data source -

-(CGFloat)radiusOfCircleView:(SCHCircleView *)circle_view
{
    return 450;
}

- (CGPoint)centerOfCircleView:(SCHCircleView *)circle_view
{
    CGPoint center = self.view.center;
    center.y -= 20;
    return center;
}

- (NSInteger)numberOfCellInCircleView:(SCHCircleView *)circle_view
{
    return self.dataArray.count;
}

- (SCHCircleViewCell *)circleView:(SCHCircleView *)circle_view cellAtIndex:(NSInteger)index_circle_cell
{
    NSDictionary *dic = [self.dataArray objectAtIndex:index_circle_cell];
    UIImage *pro_image = [UIImage imageNamed:[dic objectForKey:Product_Image]];
    
    viewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"viewCell" owner:nil options:nil] lastObject];
    
    cell.bounds = CGRectMake(0, 0, pro_image.size.width/2, pro_image.size.height/2);
    
    cell.image_view.image = pro_image;
    
    //将所有cell加入数组  方便遍历寻找当前在最前方的cell
    if (![self.cellArray containsObject:cell])
    {
        [self.cellArray addObject:cell];
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
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    [self initData];
    
    self.circleView = [[SCHCircleView alloc] initWithFrame:self.view.bounds];
    self.circleView.circle_view_data_source = self;
    self.circleView.circle_view_delegate = self;
    [self.circleView reloadData];
    [self animationEnd];
    
    [self.view addSubview:self.circleView];
    [self.view bringSubviewToFront:mtoButton];
}

- (void) initData
{
    NSDictionary *dic_guanxipen = [NSDictionary dictionaryWithObjects:@[@"sb_guanxipen",
                                                                        @"sb_guanxipen-s"]
                                                              forKeys:@[Product_Image,
                                                                        Product_Image_Selected]];
    
    NSDictionary *dic_longtou = [NSDictionary dictionaryWithObjects:@[@"sb_longtou",
                                                                        @"sb_longtou-s",]
                                                            forKeys:@[Product_Image,
                                                                      Product_Image_Selected]];
    
    NSDictionary *dic_linyushebei = [NSDictionary dictionaryWithObjects:@[@"sb_linyushebei",
                                                                        @"sb_linyushebei-s"]
                                                                forKeys:@[Product_Image,
                                                                          Product_Image_Selected]];
    
    NSDictionary *dic_linyufang = [NSDictionary dictionaryWithObjects:@[@"sb_linyufang",
                                                                        @"sb_linyufang-s"]
                                                              forKeys:@[Product_Image,
                                                                        Product_Image_Selected]];
    
    NSDictionary *dic_yushijiaju = [NSDictionary dictionaryWithObjects:@[@"sb_yushijiaju",
                                                                        @"sb_yushijiaju-s"]
                                                               forKeys:@[Product_Image,
                                                                         Product_Image_Selected]];
    
    NSDictionary *dic_peijian = [NSDictionary dictionaryWithObjects:@[@"sb_peijian",
                                                                        @"sb_peijian-s"]
                                                            forKeys:@[Product_Image,
                                                                      Product_Image_Selected]];
    
    NSDictionary *dic_shangyong = [NSDictionary dictionaryWithObjects:@[@"sb_shangyong",
                                                                        @"sb_shangyong-s"]
                                                              forKeys:@[Product_Image,
                                                                        Product_Image_Selected]];
    
    NSDictionary *dic_zhinengdianzigaiban = [NSDictionary dictionaryWithObjects:@[@"sb_zhinengdianzigaiban",
                                                                        @"sb_zhinengdianzigaiban-s"]
                                                                        forKeys:@[Product_Image,
                                                                                  Product_Image_Selected]];
    
    NSDictionary *dic_zuobianqi = [NSDictionary dictionaryWithObjects:@[@"sb_zuobianqi",
                                                                        @"sb_zuobianqi-s"]
                                                              forKeys:@[Product_Image,
                                                                        Product_Image_Selected]];
    
    NSDictionary *dic_yugang = [NSDictionary dictionaryWithObjects:@[@"sb_yugang",
                                                                        @"sb_yugang-s"]
                                                           forKeys:@[Product_Image,
                                                                     Product_Image_Selected]];


    self.dataArray = [NSArray arrayWithObjects:
                      dic_guanxipen,
                      dic_longtou,
                      dic_linyushebei,
                      dic_linyufang,
                      dic_yushijiaju,
                      dic_peijian,
                      dic_shangyong,
                      dic_zhinengdianzigaiban,
                      dic_zuobianqi,
                      dic_yugang,
                      nil];
    
    self.cellArray = [NSMutableArray array];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
