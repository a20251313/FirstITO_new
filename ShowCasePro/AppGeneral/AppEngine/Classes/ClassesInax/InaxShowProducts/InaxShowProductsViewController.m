//
//  InaxShowProductsViewController.m
//  ShowCasePro
//
//  Created by Mac on 14-3-18.
//  Copyright (c) 2014年 yczx. All rights reserved.
//

#define TableView_Width                 leftBgimageView.frame.size.width
#define TableView_Height                683
#define TableView_Cell_Height           85

#define Animation_Duration              0.25

#define Cell_Imageview_Tag              27366

#define Inax_Sp_Detail_Array            @"Inax_Sp_Detail_Array"
#define Inax_Sp_Detail_Bgimage          @"Inax_Sp_Detail_Bgimage"

#define Inax_Sp_ImageName               @"Inax_Sp_ImageName"
#define Inax_Sp_TypeID                  @"Inax_Sp_TypeID"


#define Collection_Cell_Identifier      @"InaxShowProductsCell"

#define Collection_Cell_ImageView_Tag   11
#define Collection_Cell_Lable_Tag       22

#import "InaxShowProductsViewController.h"
#import "DatabaseOption+condition.h"
#import "InaxProductDetailView.h"

@interface InaxShowProductsViewController ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
{
    __weak IBOutlet UIImageView *bgImageView;
    
    __weak IBOutlet UIImageView *leftBgimageView;
    
    __weak IBOutlet UICollectionView *productsCollectionView;
    
    
    UIView *tableViewContentView;   //加在leftbgimageview上  其中包含两个tableview
    
    UITableView *masterTableView;   //大类别
    UITableView *detailTableView;   //小类别
}

@property (nonatomic , strong) NSArray *master_deatil_Data;     //包含所有子类别的数组  存放顺序与master一致

@property (nonatomic , strong) NSArray *masterData;             //大类数组

@property (nonatomic , strong) NSArray *detailData;             //单个子类别的数组

@property (nonatomic , strong) DatabaseOption *dbo;

@property (nonatomic , strong) NSArray *productsArray;          //查询出的所有产品数组


@end

@implementation InaxShowProductsViewController


#pragma mark - collection view data source -

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = (UICollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:Collection_Cell_Identifier forIndexPath:indexPath];
    
    if (indexPath.row < self.productsArray.count)
    {
        cell.hidden = NO;
        
        Tproduct *product = (Tproduct *)[self.productsArray objectAtIndex:indexPath.row];
        
        UIImageView *productImg = (UIImageView *)[cell viewWithTag:Collection_Cell_ImageView_Tag];
        productImg.image = nil;
        
        // scale image in background
        
        
        if([product.type3 isEqualToString:@"19"]||[product.type3 isEqualToString:@"20"]||[product.type3 isEqualToString:@"22"]||[product.type3 isEqualToString:@"24"]||[product.type3 isEqualToString:@"26"])
        {
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
                UIImage *endImage = [[LibraryAPI sharedInstance] getImageFromPath:product.image2 scale:4];
                dispatch_async(dispatch_get_main_queue(), ^{
                    productImg.image = endImage;
                });
            });
            
            UILabel *productCode = (UILabel *)[cell viewWithTag:Collection_Cell_Lable_Tag];
            
            productCode.text  = [self deleteSpaceString:product.code];
            
            
        }
        else
        {
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
                UIImage *endImage = [[LibraryAPI sharedInstance] getImageFromPath:product.image1 scale:4];
                dispatch_async(dispatch_get_main_queue(), ^{
                    productImg.image = endImage;
                });
            });
            
            UILabel *productCode = (UILabel *)[cell viewWithTag:Collection_Cell_Lable_Tag];
            
            productCode.text  = [self deleteSpaceString:product.code];
            
            
        }
        
    } else
    {
        cell.hidden = YES;
    }
    
    return cell;
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

#pragma mark - collection view delegate -

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

#pragma mark - table view data source -

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ////////////////////////////////////////////////////////////////////////////////////
    
    if (tableView == masterTableView)
    {
        static NSString *masterIdentifier = @"Inax_Sp_Master_Cell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:masterIdentifier];
        
        if (!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:masterIdentifier];
            
            cell.frame = CGRectMake(0, 0, TableView_Width, TableView_Cell_Height);
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, TableView_Width, TableView_Cell_Height)];
            imageView.tag = Cell_Imageview_Tag;
            imageView.backgroundColor = [UIColor clearColor];
            [cell addSubview:imageView];
            
            cell.backgroundColor = [UIColor clearColor];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        if (indexPath.row >= self.masterData.count) {
            return cell;
        }
        
        NSDictionary *dic = [self.masterData objectAtIndex:indexPath.row];
        NSString *imageName = [dic objectForKey:Inax_Sp_ImageName];
        UIImage *image = [UIImage imageNamed:imageName];
        
        UIImageView *imageView = (UIImageView *)[cell viewWithTag:Cell_Imageview_Tag];
        imageView.image = image;
        
        return cell;
    }
    
    ////////////////////////////////////////////////////////////////////////////////////
    
    static NSString *detailIdentifier = @"Inax_Sp_Detail_Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:detailIdentifier];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:detailIdentifier];
        
        cell.frame = CGRectMake(0, 0, TableView_Width, TableView_Cell_Height);
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(17, 0, TableView_Width, TableView_Cell_Height)];
        imageView.tag = Cell_Imageview_Tag;
        imageView.backgroundColor = [UIColor clearColor];
        [cell addSubview:imageView];
        
        cell.backgroundColor = [UIColor clearColor];
    }
    
    if (!self.detailData || (indexPath.row >= self.detailData.count)) {
        return cell;
    }
    
    NSDictionary *dic = [self.detailData objectAtIndex:indexPath.row];
    NSString *imageName = [dic objectForKey:Inax_Sp_ImageName];
    UIImage *image = [UIImage imageNamed:imageName];
    
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:Cell_Imageview_Tag];
    imageView.frame = CGRectMake(17, TableView_Cell_Height - 17 - image.size.height/2, image.size.width/2, image.size.height/2);
    imageView.image = image;
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == masterTableView)
    {
        return self.masterData.count;
    }
    
    if (!self.detailData) {
        return 0;
    }
    
    return self.detailData.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return TableView_Cell_Height;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma mark - table view delegate -

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == masterTableView)
    {
        NSDictionary *detailDic = [self.master_deatil_Data objectAtIndex:indexPath.row];
        
        NSArray *detailArray = [detailDic objectForKey:Inax_Sp_Detail_Array];
        NSString *bgImageName = [detailDic objectForKey:Inax_Sp_Detail_Bgimage];
        
        [self pushToDetailTableView:detailArray bgImageName:bgImageName];
    }
    else
    {
        if (!self.detailData || (indexPath.row >= self.detailData.count)) {
            return;
        }
        
        NSDictionary *detailDic = [self.detailData objectAtIndex:indexPath.row];
        NSString *type_id = [detailDic objectForKey:Inax_Sp_TypeID];
        
        NSString *sql =[NSString stringWithFormat:@"select * from tproduct where type3 = %@ and brand = 3 and param31 = 1",type_id];
        
        self.productsArray = [self.dbo productArrayByConditionSQL:sql];
        
        if (!self.productsArray || !self.productsArray.count)
        {
            NSLog(@"error : 无数据.");
            
            if (!productsCollectionView.hidden)
            {
                productsCollectionView.hidden = YES;
            }
            
            return;
        }
        
        [productsCollectionView reloadData];
        
        productsCollectionView.hidden = NO;
    }
}


#pragma mark - 切换tableview -

- (BOOL) isMasterView
{
    if (tableViewContentView.frame.origin.x == 0)
    {
        return YES;
    }
    
    return NO;
}

- (void) moveToDetailView
{
    [UIView animateWithDuration:Animation_Duration animations:^
    {
        CGRect frame = tableViewContentView.frame;
        frame.origin.x -= TableView_Width;
        tableViewContentView.frame = frame;
    }];
}

- (void) moveToMasterView
{
    [UIView animateWithDuration:Animation_Duration animations:^
     {
         CGRect frame = tableViewContentView.frame;
         frame.origin.x = 0;
         tableViewContentView.frame = frame;
     }];
}

- (void) pushToDetailTableView:(NSArray *)dataArray bgImageName:(NSString *)imageName
{
    [self changeBackgroundImage:imageName];
    self.detailData = dataArray;
    [detailTableView reloadData];
    [self moveToDetailView];
}

- (void) popToMasterTableView
{
    productsCollectionView.hidden = YES;
    
    [self changeBackgroundImage:nil];
    [self moveToMasterView];
    self.detailData = nil;
}


#pragma mark - 更换背景图片 -

//nil 改回默认图片
- (void) changeBackgroundImage:(NSString *)imageName
{
    if (!imageName)
    {
        imageName = @"inax_sp_bg.png";
    }
    
    UIImage *bgImage = [UIImage imageNamed:imageName];
    
    if (!bgImage)
    {
        NSLog(@"error : InaxShowProductsViewController : changeBackgroundImage : 找不到图片.");
        return;
    }
    
    bgImageView.image = bgImage;
}


#pragma mark - 覆盖父类的返回方法  如果当前在detail table view 就pop to master tableview 否则就调用pop view controller -

- (void) backButtonEvent
{
    if (![self isMasterView])
    {
        [self popToMasterTableView];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:NO];
    }
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
    
    //初始化数据   以后可以换成从数据库读取
    self.masterData = [NSArray arrayWithObjects:
                       [NSDictionary dictionaryWithObject:@"inax_sp_bianqi.png" forKey:Inax_Sp_ImageName],  //便器
                       [NSDictionary dictionaryWithObject:@"inax_sp_yixiangjingwenshuizuobianqi.png" forKey:Inax_Sp_ImageName],//伊享净
                       [NSDictionary dictionaryWithObject:@"inax_sp_xiaobianqi.png" forKey:Inax_Sp_ImageName],//小便器
                       [NSDictionary dictionaryWithObject:@"inax_sp_mianpen.png" forKey:Inax_Sp_ImageName], //面盆
                       [NSDictionary dictionaryWithObject:@"inax_sp_huazhuangximiangui.png" forKey:Inax_Sp_ImageName],//化妆洗面柜
                       [NSDictionary dictionaryWithObject:@"inax_sp_yugang.png" forKey:Inax_Sp_ImageName],//浴缸
                       [NSDictionary dictionaryWithObject:@"inax_sp_longtou.png" forKey:Inax_Sp_ImageName],//龙头
                       [NSDictionary dictionaryWithObject:@"inax_sp_peijian.png" forKey:Inax_Sp_ImageName],//配件
                       nil];
    
    NSArray *bianqi = [NSArray arrayWithObjects:
                       [NSDictionary dictionaryWithObjects:@[@"inax_sp_bianqi_quanzidongzuobianqi.png",@"1"]
                                                   forKeys:@[Inax_Sp_ImageName,Inax_Sp_TypeID]],
                       [NSDictionary dictionaryWithObjects:@[@"inax_sp_bianqi_liantishizuobianqi.png",@"2"]
                                                   forKeys:@[Inax_Sp_ImageName,Inax_Sp_TypeID]],
                       [NSDictionary dictionaryWithObjects:@[@"inax_sp_bianqi_fentishizuobianqi.png",@"3"]
                                                   forKeys:@[Inax_Sp_ImageName,Inax_Sp_TypeID]],
                       [NSDictionary dictionaryWithObjects:@[@"inax_sp_bianqi_chongxifashizuobianqi.png",@"4"]
                                                   forKeys:@[Inax_Sp_ImageName,Inax_Sp_TypeID]],
                       [NSDictionary dictionaryWithObjects:@[@"inax_sp_bianqi_bianqichongxifa.png",@"5"]
                                                   forKeys:@[Inax_Sp_ImageName,Inax_Sp_TypeID]],
                       [NSDictionary dictionaryWithObjects:@[@"inax_sp_bianqi_guaqiangshiyinbishishuixiangzuobainqi.png",@"153"]
                                                   forKeys:@[Inax_Sp_ImageName,Inax_Sp_TypeID]],
                       nil];
    
    NSArray *yixiangjing = [NSArray arrayWithObjects:
                            [NSDictionary dictionaryWithObjects:@[@"inax_sp_yixiangjing_wenshuizuobainqi.png",@"6"]
                                                        forKeys:@[Inax_Sp_ImageName,Inax_Sp_TypeID]],
                            nil];
    
    NSArray *xiaobianqi = [NSArray arrayWithObjects:
                           [NSDictionary dictionaryWithObjects:@[@"inax_sp_xiaobianqi_xiaobianqi.png",@"7"]
                                                       forKeys:@[Inax_Sp_ImageName,Inax_Sp_TypeID]],
                           [NSDictionary dictionaryWithObjects:@[@"inax_sp_xiaobianqi_xiaobianchongxiqi.png",@"8"]
                                                       forKeys:@[Inax_Sp_ImageName,Inax_Sp_TypeID]],
                             nil];
    
    NSArray *mianpen = [NSArray arrayWithObjects:
                       [NSDictionary dictionaryWithObjects:@[@"inax_sp_mianpen_wanpen.png",@"9"]
                                                   forKeys:@[Inax_Sp_ImageName,Inax_Sp_TypeID]],
                       [NSDictionary dictionaryWithObjects:@[@"inax_sp_mianpen_taishangshimianpen.png",@"10"]
                                                   forKeys:@[Inax_Sp_ImageName,Inax_Sp_TypeID]],
                       [NSDictionary dictionaryWithObjects:@[@"inax_sp_mianpen_taixiashimianpen.png",@"11"]
                                                   forKeys:@[Inax_Sp_ImageName,Inax_Sp_TypeID]],
                       [NSDictionary dictionaryWithObjects:@[@"inax_sp_mianpen_xishoumianpen.png",@"13"]
                                                   forKeys:@[Inax_Sp_ImageName,Inax_Sp_TypeID]],
                       [NSDictionary dictionaryWithObjects:@[@"inax_sp_mianpen_lishimianpen.png",@"12"]
                                                   forKeys:@[Inax_Sp_ImageName,Inax_Sp_TypeID]],
                       [NSDictionary dictionaryWithObjects:@[@"inax_sp_mianpen_zayongtaocipin.png",@"14"]
                                                   forKeys:@[Inax_Sp_ImageName,Inax_Sp_TypeID]],
                       nil];
    
    NSArray *huazhuangximiangui = [NSArray arrayWithObjects:
                        [NSDictionary dictionaryWithObjects:@[@"inax_sp_huazhuangximiangui_suolaisite.png",@"15"]
                                                    forKeys:@[Inax_Sp_ImageName,Inax_Sp_TypeID]],
                        [NSDictionary dictionaryWithObjects:@[@"inax_sp_huazhuangximiangui_oufute.png",@"16"]
                                                    forKeys:@[Inax_Sp_ImageName,Inax_Sp_TypeID]],
                        [NSDictionary dictionaryWithObjects:@[@"inax_sp_huazhuangximiangui_cp.png",@"17"]
                                                    forKeys:@[Inax_Sp_ImageName,Inax_Sp_TypeID]],
                        [NSDictionary dictionaryWithObjects:@[@"inax_sp_huazhuangximiangui_huazhuangjinggui.png",@"18"]
                                                    forKeys:@[Inax_Sp_ImageName,Inax_Sp_TypeID]],
                        nil];
    
    NSArray *yugang = [NSArray arrayWithObjects:
                        [NSDictionary dictionaryWithObjects:@[@"inax_sp_yugang_shumuwenquanyugang.png",@"19"]
                                                    forKeys:@[Inax_Sp_ImageName,Inax_Sp_TypeID]],
                        [NSDictionary dictionaryWithObjects:@[@"inax_sp_yugang_yingyashiyugang.png",@"20"]
                                                    forKeys:@[Inax_Sp_ImageName,Inax_Sp_TypeID]],
                        [NSDictionary dictionaryWithObjects:@[@"inax_sp_yugang_kaishayugang.png",@"22"]
                                                    forKeys:@[Inax_Sp_ImageName,Inax_Sp_TypeID]],
                        [NSDictionary dictionaryWithObjects:@[@"inax_sp_yugang_lixiangshiyugang.png",@"24"]
                                                    forKeys:@[Inax_Sp_ImageName,Inax_Sp_TypeID]],
                        [NSDictionary dictionaryWithObjects:@[@"inax_sp_yugang_yakeliyugang.png",@"25"]
                                                    forKeys:@[Inax_Sp_ImageName,Inax_Sp_TypeID]],
                        [NSDictionary dictionaryWithObjects:@[@"inax_sp_yugang_zhutieyugang.png",@"26"]
                                                    forKeys:@[Inax_Sp_ImageName,Inax_Sp_TypeID]],
                        nil];
    
    
    NSArray *longtou = [NSArray arrayWithObjects:
                        [NSDictionary dictionaryWithObjects:@[@"inax_sp_longtou_zidongganyinglongtou.png",@"27"]
                                                    forKeys:@[Inax_Sp_ImageName,Inax_Sp_TypeID]],
                        [NSDictionary dictionaryWithObjects:@[@"inax_sp_longtou_qingpenzhilian.png",@"29"]
                                                    forKeys:@[Inax_Sp_ImageName,Inax_Sp_TypeID]],
                        [NSDictionary dictionaryWithObjects:@[@"inax_sp_longtou_saimu.png",@"28"]
                                                    forKeys:@[Inax_Sp_ImageName,Inax_Sp_TypeID]],
                        [NSDictionary dictionaryWithObjects:@[@"inax_sp_longtou_ecojieshuilongtou.png",@"118"]
                                                    forKeys:@[Inax_Sp_ImageName,Inax_Sp_TypeID]],
                        [NSDictionary dictionaryWithObjects:@[@"inax_sp_longtou_zhunyulongtou.png",@"30"]
                                                    forKeys:@[Inax_Sp_ImageName,Inax_Sp_TypeID]],
                        [NSDictionary dictionaryWithObjects:@[@"inax_sp_longtou_luoxiusilongtou.png",@"31"]
                                                    forKeys:@[Inax_Sp_ImageName,Inax_Sp_TypeID]],
                        [NSDictionary dictionaryWithObjects:@[@"inax_sp_longtou_yilinglongtou.png",@"32"]
                                                    forKeys:@[Inax_Sp_ImageName,Inax_Sp_TypeID]],
                        [NSDictionary dictionaryWithObjects:@[@"inax_sp_longtou_mofanglongtou.png",@"33"]
                                                    forKeys:@[Inax_Sp_ImageName,Inax_Sp_TypeID]],
                        [NSDictionary dictionaryWithObjects:@[@"inax_sp_longtou_asitelon",@"34"]
                                                    forKeys:@[Inax_Sp_ImageName,Inax_Sp_TypeID]],
                        [NSDictionary dictionaryWithObjects:@[@"inax_sp_longtou_yagelongtou.png",@"35"]
                                                    forKeys:@[Inax_Sp_ImageName,Inax_Sp_TypeID]],
                        [NSDictionary dictionaryWithObjects:@[@"inax_sp_longtou_cxilielongtou.png",@"36"]
                                                    forKeys:@[Inax_Sp_ImageName,Inax_Sp_TypeID]],
                        [NSDictionary dictionaryWithObjects:@[@"inax_sp_longtou_exilielongtou.png",@"37"]
                                                    forKeys:@[Inax_Sp_ImageName,Inax_Sp_TypeID]],
                        [NSDictionary dictionaryWithObjects:@[@"inax_sp_longtou_fxilielongtou.png",@"38"]
                                                    forKeys:@[Inax_Sp_ImageName,Inax_Sp_TypeID]],
                        [NSDictionary dictionaryWithObjects:@[@"inax_sp_longtou_bxilielongtou.png",@"39"]
                                                    forKeys:@[Inax_Sp_ImageName,Inax_Sp_TypeID]],
                        [NSDictionary dictionaryWithObjects:@[@"inax_sp_longtou_axilielongtou.png",@"40"]
                                                    forKeys:@[Inax_Sp_ImageName,Inax_Sp_TypeID]],
                        [NSDictionary dictionaryWithObjects:@[@"inax_sp_longtou_200xilielongtou.png",@"41"]
                                                    forKeys:@[Inax_Sp_ImageName,Inax_Sp_TypeID]],
                        [NSDictionary dictionaryWithObjects:@[@"inax_sp_longtou_nxilielongtou.png",@"42"]
                                                    forKeys:@[Inax_Sp_ImageName,Inax_Sp_TypeID]],
                        [NSDictionary dictionaryWithObjects:@[@"inax_sp_longtou_pxilielongtou.png",@"43"]
                                                    forKeys:@[Inax_Sp_ImageName,Inax_Sp_TypeID]],
                        [NSDictionary dictionaryWithObjects:@[@"inax_sp_longtou_ruqiangshilongtou.png",@"44"]
                                                    forKeys:@[Inax_Sp_ImageName,Inax_Sp_TypeID]],
                        [NSDictionary dictionaryWithObjects:@[@"inax_sp_longtou_huasashengjianggan.png",@"45"]
                                                    forKeys:@[Inax_Sp_ImageName,Inax_Sp_TypeID]],
                        [NSDictionary dictionaryWithObjects:@[@"inax_sp_longtou_huasalinyuzhu.png",@"46"]
                                                    forKeys:@[Inax_Sp_ImageName,Inax_Sp_TypeID]],
                        [NSDictionary dictionaryWithObjects:@[@"inax_sp_longtou_danlenglongtou.png",@"47"]
                                                    forKeys:@[Inax_Sp_ImageName,Inax_Sp_TypeID]],
                        [NSDictionary dictionaryWithObjects:@[@"inax_sp_longtou_chufanglongtou.png",@"152"]
                                                    forKeys:@[Inax_Sp_ImageName,Inax_Sp_TypeID]],
                        nil];
    
    
    
    NSArray *peijian = [NSArray arrayWithObjects:
                                   [NSDictionary dictionaryWithObjects:@[@"inax_sp_peijian_yushipeijian.png",@"48"]
                                                               forKeys:@[Inax_Sp_ImageName,Inax_Sp_TypeID]],
                                   [NSDictionary dictionaryWithObjects:@[@"inax_sp_peijian_lingpeijian.png",@"120"]
                                                               forKeys:@[Inax_Sp_ImageName,Inax_Sp_TypeID]],
                                   [NSDictionary dictionaryWithObjects:@[@"inax_sp_peijian_anquanfuzhufushou.png",@"121"]
                                                               forKeys:@[Inax_Sp_ImageName,Inax_Sp_TypeID]],
                                   nil];
    
    
    self.master_deatil_Data = [NSArray arrayWithObjects:
                               [NSDictionary dictionaryWithObjects:@[bianqi,@"inax_sp_bianqi_bgimage.png"]
                                                           forKeys:@[Inax_Sp_Detail_Array,Inax_Sp_Detail_Bgimage]],
                               [NSDictionary dictionaryWithObjects:@[yixiangjing,@"inax_sp_yixiangjing_bgimage.png"]
                                                           forKeys:@[Inax_Sp_Detail_Array,Inax_Sp_Detail_Bgimage]],
                               [NSDictionary dictionaryWithObjects:@[xiaobianqi,@"inax_sp_xiaobianqi_bgimage.png"]
                                                           forKeys:@[Inax_Sp_Detail_Array,Inax_Sp_Detail_Bgimage]],
                               [NSDictionary dictionaryWithObjects:@[mianpen,@"inax_sp_mianpen_bgimage.png"]
                                                           forKeys:@[Inax_Sp_Detail_Array,Inax_Sp_Detail_Bgimage]],
                               [NSDictionary dictionaryWithObjects:@[huazhuangximiangui,@"inax_sp_huazhuangximiangui_bgimage.png"]
                                                           forKeys:@[Inax_Sp_Detail_Array,Inax_Sp_Detail_Bgimage]],
                               [NSDictionary dictionaryWithObjects:@[yugang,@"inax_sp_yugang_bgimage.png"]
                                                           forKeys:@[Inax_Sp_Detail_Array,Inax_Sp_Detail_Bgimage]],
                               [NSDictionary dictionaryWithObjects:@[longtou,@"inax_sp_longtou_bgimage.png"]
                                                           forKeys:@[Inax_Sp_Detail_Array,Inax_Sp_Detail_Bgimage]],
                               [NSDictionary dictionaryWithObjects:@[peijian,@"inax_sp_peijian_bgimage.png"]
                                                           forKeys:@[Inax_Sp_Detail_Array,Inax_Sp_Detail_Bgimage]],
                               nil];
    
    /////初始化viewd
    leftBgimageView.clipsToBounds = YES;
    
    tableViewContentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, TableView_Width*2, TableView_Height)];
    tableViewContentView.backgroundColor = [UIColor clearColor];
    [leftBgimageView addSubview:tableViewContentView];
    
    masterTableView = [self creatTableView:CGRectMake(0, 0, TableView_Width, TableView_Height)];
    detailTableView = [self creatTableView:CGRectMake(TableView_Width, 0, TableView_Width, TableView_Height)];
    
    [masterTableView reloadData];
    
    
    [self initCollectionView];
}

//初始化 collection view
- (void) initCollectionView
{
    productsCollectionView.dataSource = self;
    productsCollectionView.delegate = self;
    
    productsCollectionView.hidden = YES;
    
    [productsCollectionView registerNib:[UINib nibWithNibName:@"InaxShowProductsCell" bundle:nil] forCellWithReuseIdentifier:@"InaxShowProductsCell"];
}

- (UITableView *) creatTableView:(CGRect)frame
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:frame];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.bounces = NO;
    tableView.backgroundColor = [UIColor clearColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    tableView.separatorColor = [UIColor whiteColor];
    tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    tableView.tableFooterView = [UIView new];
    
    [tableViewContentView addSubview:tableView];

    return tableView;
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
