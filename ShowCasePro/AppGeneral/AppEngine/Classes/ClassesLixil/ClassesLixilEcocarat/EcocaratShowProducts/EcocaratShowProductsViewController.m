//
//  EcocaratShowProductsViewController.m
//  ShowCasePro
//
//  Created by Mac on 14-4-2.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#import "EcocaratShowProductsViewController.h"
#import "LixilProductDetailView.h"
#import "UserGuideTips.h"
#define Ecocarat_SP_List_Image_Name     @"Ecocarat_SP_List_Image_Name"
#define Ecocarat_SP_BG_Image_Name       @"Ecocarat_SP_BG_Image_Name"
#define Ecocarat_SP_Product_ID          @"Ecocarat_SP_Product_ID"

#define Cell_Height                     683/6.0

#define Cell_ImageView_Tag              8752

@interface EcocaratShowProductsViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    __weak IBOutlet UITableView *listTableView;
    
    __weak IBOutlet UIImageView *bgImageView;
}

@property (nonatomic , strong) NSArray *dataArray;

@property (nonatomic , assign) int currentIndex;

@end

@implementation EcocaratShowProductsViewController

- (IBAction)buttonEvent
{
    NSDictionary *dic = [self.dataArray objectAtIndex:self.currentIndex];
    
    NSString *productID = [dic objectForKey:Ecocarat_SP_Product_ID];
    
    LixilProductDetailView *lpdv = [LixilProductDetailView new];
    lpdv.productid = productID;
    lpdv.isShowCer = YES;
    
    [self.navigationController pushViewController:lpdv animated:NO];
}


#pragma mark - table view data source -

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return Cell_Height;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, Cell_Height)];
        imageView.tag = Cell_ImageView_Tag;
        [cell addSubview:imageView];
    }
    
    NSDictionary *dic = [self.dataArray objectAtIndex:indexPath.row];
    NSString *imageName = [dic objectForKey:Ecocarat_SP_List_Image_Name];
    UIImage *image = [UIImage imageNamed:imageName];
    
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:Cell_ImageView_Tag];
    imageView.image = image;
    
    return cell;
}

#pragma mark - table view delegate -

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.currentIndex = indexPath.row;
    
    NSDictionary *dic = [self.dataArray objectAtIndex:indexPath.row];
    
    UIImage *image = [UIImage imageNamed:[dic objectForKey:Ecocarat_SP_BG_Image_Name]];
    
    bgImageView.image = image;
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
    //提示产品详情
    UserGuideTips *guideTips = [UserGuideTips shareInstance];
    [guideTips showUserGuideView:self.view tipKey:@"chanpinzhanshi"  imageNamePre:@"EcocaratTip_1"];
    
    
    self.dataArray = [NSArray arrayWithObjects:
                      [self listImageName:@"ecocarat_sp_yayan"
                              bgImageName:@"ecocarat_sp_yayan_bg"
                                productID:@"1417"],                 //雅岩
                      [self listImageName:@"ecocarat_sp_bolang"
                              bgImageName:@"ecocarat_sp_bolang_bg"
                                productID:@"1418"],                 //波浪马赛克
                      [self listImageName:@"ecocarat_sp_zhizun"
                              bgImageName:@"ecocarat_sp_zhizun_bg"
                                productID:@"1419"],                 //至尊马赛克
                      [self listImageName:@"ecocarat_sp_luoxiu"
                              bgImageName:@"ecocarat_sp_luoxiu_bg"
                                productID:@"1420"],                 //洛修马赛克
                      [self listImageName:@"ecocarat_sp_lengying"
                              bgImageName:@"ecocarat_sp_lengying_bg"
                                productID:@"1421"],                 //棱影马赛克
                      [self listImageName:@"ecocarat_sp_zhumie"
                              bgImageName:@"ecocarat_sp_zhumie_bg"
                                productID:@"1422"],                 //竹篾
                      //岩石 1423
                      nil];
    
    self.currentIndex = 0;  //默认选择雅岩呼吸砖
    
    listTableView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0);
}

- (NSDictionary *) listImageName:(NSString *)listImageName
                     bgImageName:(NSString *)bgImageName
                       productID:(NSString *)productID
{
    return [NSDictionary dictionaryWithObjects:@[listImageName,
                                                 bgImageName,
                                                 productID]
                                       forKeys:@[Ecocarat_SP_List_Image_Name,
                                                 Ecocarat_SP_BG_Image_Name,
                                                 Ecocarat_SP_Product_ID]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
